// import 'package:flutter/material.dart';
// import 'package:meal_app/Featuers/home/data/meal_model.dart';
// import 'package:meal_app/core/servers/api_servers.dart';

// class HomeProvider with ChangeNotifier {
//   final ApiService apiService;

//   HomeProvider(this.apiService);

//   /// القائمة الرئيسية اللي فيها كل الوجبات
//   List<MealModel> _meals = [];
//   List<MealModel> get meals => _meals;

//   /// حالة التحميل
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   /// الدولة/المنطقة المختارة لفلترة الوجبات (مثلاً: Egyptian, Italian)
//   String _selectedArea = 'All';
//   String get selectedArea => _selectedArea;

//   /// قائمة بكل الدول أو المناطق الموجودة في الوجبات
//   List<String> _areas = [];
//   List<String> get areas => _areas;

//   /// دالة لجلب كل الوجبات من السيرفر
//   Future<void> fetchAllMeals() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await apiService.getAllMeals();
//       final mealsData = response['meals'] as List<dynamic>;

//       _meals = mealsData.map((json) => MealModel.fromJson(json)).toList();

//       // استخرج الدول (strArea) من الوجبات بدون تكرار
//       _areas = _meals.map((meal) => meal.strArea ?? 'Unknown').toSet().toList()
//         ..sort();

//       _areas.insert(0, 'All'); // لإضافة خيار الكل في البداية
//     } catch (e) {
//       print('خطأ في تحميل الوجبات: $e');
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   /// دالة لتغيير الدولة المختارة لفلترة الوجبات
//   void changeSelectedArea(String area) {
//     _selectedArea = area;
//     notifyListeners();
//   }

//   /// فلترة الوجبات حسب الدولة المختارة
//   List<MealModel> get filteredMeals {
//     if (_selectedArea == 'All') return _meals;

//     return _meals.where((meal) => meal.strArea == _selectedArea).toList();
//   }

//   /// دالة لجلب الوجبات حسب التصنيف (مثل: Beef, Chicken...)
//   Future<void> fetchMealsByCategory(String category) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await apiService.getMealsByCategory(category);
//       final mealsData = response['meals'] as List<dynamic>;

//       _meals = mealsData.map((json) => MealModel.fromJson(json)).toList();
//     } catch (e) {
//       print('خطأ في جلب الوجبات حسب التصنيف: $e');
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   /// دالة لجلب وجبة واحدة بالتفاصيل الكاملة حسب ID
//   Future<MealModel?> getMealDetails(String id) async {
//     try {
//       final response = await apiService.getMealById(id);
//       final mealsData = response['meals'] as List<dynamic>;

//       return MealModel.fromJson(mealsData.first);
//     } catch (e) {
//       print('خطأ في جلب تفاصيل الوجبة: $e');
//       return null;
//     }
//   }

//   /// دالة للبحث عن وجبات حسب الاسم
//   Future<void> searchMeals(String query) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await apiService.getMealsByName(query);
//       final mealsData = response['meals'] as List<dynamic>?;

//       if (mealsData != null) {
//         _meals = mealsData.map((json) => MealModel.fromJson(json)).toList();
//       } else {
//         _meals = []; // لا توجد نتائج
//       }
//     } catch (e) {
//       print('خطأ في البحث عن الوجبة: $e');
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:meal_app/Featuers/book_market/data/book_marked_meal.dart';
import 'package:meal_app/Featuers/home/data/meal_model.dart';
import 'package:meal_app/core/servers/api_servers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService apiService;

  HomeProvider(this.apiService);
  List<BookmarkedMeal> savedMeals = [];

  List<MealModel> _meals = [];
  List<MealModel> get meals => _meals;

  List<String> _areas = [];
  List<String> get areas => _areas;

  String _selectedArea = '';
  String get selectedArea => _selectedArea;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadMore = false;
  bool get isLoadMore => _isLoadMore;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  int _currentPage = 1;
  final int _limit = 10;

  String _searchQuery = '';
  Timer? _debounce;

  // ✅ Filtered meals by selected area
  List<MealModel> get filteredMeals {
    if (_selectedArea.isEmpty || _selectedArea == "All") {
      return _meals;
    } else {
      return _meals.where((meal) => meal.strArea == _selectedArea).toList();
    }
  }

  // ✅ Change selected area
  void changeSelectedArea(String area) {
    _selectedArea = area;
    notifyListeners();
  }

  // ✅ Search text
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    _meals.clear();
    _hasMore = true;
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchQuery.isEmpty) {
        fetchAllMeals();
      } else {
        searchMeals(_searchQuery);
      }
    });
  }

  // ✅ Get areas from API
  Future<void> fetchAreas() async {
    final result = await apiService.getAreas();
    _areas = ["All", ...result]; // أول تبقى "All" لعرض الكل
    _selectedArea = "All";
    notifyListeners();
  }

  Future<void> fetchAllMeals() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await apiService.getMeals(
        page: _currentPage,
        limit: _limit,
      );
      _meals = result;
      if (result.length < _limit) {
        _hasMore = false;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchMeals(String query) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await apiService.searchMeals(
        query,
        page: _currentPage,
        limit: _limit,
      );
      _meals = result;
      if (result.length < _limit) {
        _hasMore = false;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreMeals() async {
    if (_isLoadMore || !_hasMore) return;

    _isLoadMore = true;
    _currentPage++;
    notifyListeners();

    try {
      final result = _searchQuery.isEmpty
          ? await apiService.getMeals(page: _currentPage, limit: _limit)
          : await apiService.searchMeals(
              _searchQuery,
              page: _currentPage,
              limit: _limit,
            );

      if (result.isEmpty) {
        _hasMore = false;
      } else {
        _meals.addAll(result);
      }
    } finally {
      _isLoadMore = false;
      notifyListeners();
    }
  }

  Future<List<BookmarkedMeal>> getSavedMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMeals = prefs.getStringList('bookmarkedMeals') ?? [];
    return savedMeals
        .map((jsonStr) => BookmarkedMeal.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  Future<void> saveMealLocally(BookmarkedMeal meal) async {
    final prefs = await SharedPreferences.getInstance();
    final savedMealsList = prefs.getStringList('bookmarkedMeals') ?? [];

    final encodedMeal = jsonEncode(meal.toJson());

    if (!savedMealsList.contains(encodedMeal)) {
      savedMealsList.add(encodedMeal);
      await prefs.setStringList('bookmarkedMeals', savedMealsList);

      await loadSavedMeals(); // ✅ تحديث القائمة بعد الحفظ
    }
  }

  Future<void> loadSavedMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedData = prefs.getStringList('bookmarkedMeals') ?? [];

    savedMeals = savedData
        .map((e) => BookmarkedMeal.fromJson(jsonDecode(e)))
        .toList();

    notifyListeners(); // ✅ علشان UI يتحدث
  }
}
