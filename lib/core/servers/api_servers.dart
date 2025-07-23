// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:meal_app/Featuers/home/data/meal_model.dart';
import 'package:meal_app/core/servers/failuers.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);
  Future<List<MealModel>> getMeals({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _dio.get(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=',
      );

      final meals = response.data['meals'] as List<dynamic>?;

      if (meals == null) return [];

      final start = (page - 1) * limit;
      final end = start + limit;

      // ✅ تحقق مهم حتى لا نحاول الوصول لعناصر خارج النطاق
      if (start >= meals.length) return [];

      final paginated = meals.sublist(
        start,
        end > meals.length ? meals.length : end,
      );

      return paginated.map((e) => MealModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerFailers.fromDioError(e);
    } catch (e) {
      throw ServerFailers('Unexpected Error: $e');
    }
  }

  Future<List<MealModel>> searchMeals(
    String query, {
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _dio.get(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=$query',
      );

      final meals = response.data['meals'] as List<dynamic>?;

      if (meals == null || meals.isEmpty) return [];

      final start = (page - 1) * limit;

      if (start >= meals.length) return [];

      final end = (start + limit).clamp(0, meals.length);

      final paginated = meals.sublist(start, end);

      return paginated.map((e) => MealModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerFailers.fromDioError(e);
    } catch (e) {
      throw ServerFailers('Unexpected Error: $e');
    }
  }

  Future<List<String>> getAreas() async {
    final response = await _dio.get(
      "https://www.themealdb.com/api/json/v1/1/list.php?a=list",
    );
    final areasJson = response.data['meals'] as List;
    return areasJson.map((e) => e['strArea'].toString()).toList();
  }
}
