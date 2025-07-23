import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BookmarkedMeal {
  final String id;
  final String name;
  final String image;

  BookmarkedMeal({required this.id, required this.name, required this.image});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': image};

  factory BookmarkedMeal.fromJson(Map<String, dynamic> json) {
    return BookmarkedMeal(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
