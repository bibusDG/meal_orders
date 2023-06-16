// To parse this JSON data, do
//
//     final mealModel = mealModelFromJson(jsonString);

import 'dart:convert';

import 'package:meal_orders/models/main_category_model.dart';

class MealModel extends MainCategoryModel{
  int productCounter;
  String unitMeasure;
  String mealName;
  String mealPicture;
  String mealDescription;
  String mealPrice;
  String chosenVariant;
  bool mealAvailability;
  List<dynamic> mealContent;
  List<dynamic> mealVariants;

  MealModel({
    required super.categoryName,
    required super.categoryPicture,
    required this.chosenVariant,
    required this.productCounter,
    required this.unitMeasure,
    required this.mealName,
    required this.mealPicture,
    required this.mealDescription,
    required this.mealPrice,
    required this.mealAvailability,
    required this.mealContent,
    required this.mealVariants,
  });

  @override
  MealModel copyWith({
    String? chosenVariant,
    String? categoryName,
    String? categoryPicture,
    int? productCounter,
    String? unitMeasure,
    String? mealName,
    String? mealPicture,
    String? mealDescription,
    String? mealPrice,
    bool? mealAvailability,
    List<dynamic>? mealContent,
    List<dynamic>? mealVariants,
  }) =>
      MealModel(
        chosenVariant: chosenVariant ??  this.chosenVariant,
        categoryName: categoryName ?? this.categoryName,
        categoryPicture: categoryPicture ?? this.categoryPicture,
        productCounter: productCounter ?? this.productCounter,
        unitMeasure: unitMeasure ?? this.unitMeasure,
        mealName: mealName ?? this.mealName,
        mealPicture: mealPicture ?? this.mealPicture,
        mealDescription: mealDescription ?? this.mealDescription,
        mealPrice: mealPrice ?? this.mealPrice,
        mealAvailability: mealAvailability ?? this.mealAvailability,
        mealContent: mealContent ?? this.mealContent,
        mealVariants: mealVariants ?? this.mealVariants,
      );

  factory MealModel.fromRawJson(String str) => MealModel.fromJson(json.decode(str));

  @override
  String toRawJson() => json.encode(toJson());

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
    chosenVariant: json["chosenVariant"],
    categoryName: json['categoryName'],
    categoryPicture: json['categoryPicture'],
    productCounter: json['productCounter'],
    unitMeasure: json['unitMeasure'],
    mealName: json["mealName"],
    mealPicture: json["mealPicture"],
    mealDescription: json["mealDescription"],
    mealPrice: json["mealPrice"],
    mealAvailability: json["mealAvailability"],
    mealContent: List<dynamic>.from(json["mealContent"].map((x) => x)),
    mealVariants: List<dynamic>.from(json["mealVariants"].map((x) => x)),
  );

  @override
  Map<String, dynamic> toJson() => {
    "chosenVariant": chosenVariant,
    "categoryName": categoryName,
    "categoryPicture": categoryPicture,
    "productCounter": productCounter,
    "unitMeasure":unitMeasure,
    "mealName": mealName,
    "mealPicture": mealPicture,
    "mealDescription": mealDescription,
    "mealPrice": mealPrice,
    "mealAvailability": mealAvailability,
    "mealContent": List<dynamic>.from(mealContent.map((x) => x)),
    "mealVariants": List<dynamic>.from(mealVariants.map((x) => x)),
  };
}
