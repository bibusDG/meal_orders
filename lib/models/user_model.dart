// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meal_orders/models/meal_model.dart';
import 'dart:convert';

class UserModel {
  String userName;
  String userSurName;
  String userLogin;
  String userPassword;
  List<MealModel> userBasket;
  List<dynamic> userListOfOrders;
  // bool userLoggedIn;
  bool isAdmin;

  UserModel({
    required this.userName,
    required this.userSurName,
    required this.userLogin,
    required this.userPassword,
    required this.userBasket,
    required this.userListOfOrders,
    // required this.userLoggedIn,
    required this.isAdmin,
  });

  UserModel copyWith({
    String? userName,
    String? userSurName,
    String? userLogin,
    String? userPassword,
    List<MealModel>? userBasket,
    List<dynamic>? userListOfOrders,
    // bool? userLoggedIn,
    bool? isAdmin,
  }) =>
      UserModel(
        userName: userName ?? this.userName,
        userSurName: userSurName ?? this.userSurName,
        userLogin: userLogin ?? this.userLogin,
        userPassword: userPassword ?? this.userPassword,
        userBasket: userBasket ?? this.userBasket,
        userListOfOrders: userListOfOrders ?? this.userListOfOrders,
        // userLoggedIn: userLoggedIn ?? this.userLoggedIn,
        isAdmin: isAdmin ?? this.isAdmin,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["userName"],
    userSurName: json["userSurName"],
    userLogin: json["userLogin"],
    userPassword: json["userPassword"],
    userBasket: List<MealModel>.from(json["userBasket"].map((x) => x)),
    userListOfOrders: List<dynamic>.from(json["userListOfOrders"].map((x) => x)),
    // userLoggedIn: json["userLoggedIn"],
    isAdmin: json["isAdmin"]
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "userSurName": userSurName,
    "userLogin":userLogin,
    "userPassword": userPassword,
    "userBasket": List<MealModel>.from(userBasket.map((x) => x)),
    "userListOfOrders": List<dynamic>.from(userListOfOrders.map((x) => x)),
    // "userLoggedIn": userLoggedIn,
    "isAdmin": isAdmin,
  };
}
