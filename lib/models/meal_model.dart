// To parse this JSON data, do
//
//     final mealModel = mealModelFromJson(jsonString);

import 'dart:convert';

class MealModel {
  String unitMeasure;
  String mealName;
  String mealPicture;
  String mealDescription;
  String mealPrice;
  bool mealAvailability;
  List<dynamic> mealContent;
  List<dynamic> mealVariants;

  MealModel({
    required this.unitMeasure,
    required this.mealName,
    required this.mealPicture,
    required this.mealDescription,
    required this.mealPrice,
    required this.mealAvailability,
    required this.mealContent,
    required this.mealVariants,
  });

  MealModel copyWith({
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

  String toRawJson() => json.encode(toJson());

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
    unitMeasure: json['unitMeasure'],
    mealName: json["mealName"],
    mealPicture: json["mealPicture"],
    mealDescription: json["mealDescription"],
    mealPrice: json["mealPrice"],
    mealAvailability: json["mealAvailability"],
    mealContent: List<dynamic>.from(json["mealContent"].map((x) => x)),
    mealVariants: List<dynamic>.from(json["mealVariants"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
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
