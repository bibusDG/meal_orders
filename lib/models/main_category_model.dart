// To parse this JSON data, do
//
//     final mainCategoryModel = mainCategoryModelFromJson(jsonString);

import 'dart:convert';

class MainCategoryModel {
  String categoryName;
  String categoryPicture;

  MainCategoryModel({
    required this.categoryName,
    required this.categoryPicture,
  });

  MainCategoryModel copyWith({
    String? categoryName,
    String? categoryPicture,
  }) =>
      MainCategoryModel(
        categoryName: categoryName ?? this.categoryName,
        categoryPicture: categoryPicture ?? this.categoryPicture,
      );

  factory MainCategoryModel.fromRawJson(String str) => MainCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MainCategoryModel.fromJson(Map<String, dynamic> json) => MainCategoryModel(
    categoryName: json["category_name"],
    categoryPicture: json["category_picture"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "category_picture": categoryPicture,
  };
}
