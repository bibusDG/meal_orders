// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'package:meal_orders/models/meal_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class OrderModel {
  int orderNumber;
  String orderDate;
  int orderTotalPrice;
  String orderStatus;
  List<dynamic> articlesList;
  String userName;
  String userSurname;
  String userLogin;

  OrderModel({
    required this.orderNumber,
    required this.orderDate,
    required this.orderTotalPrice,
    required this.orderStatus,
    required this.articlesList,
    required this.userName,
    required this.userSurname,
    required this.userLogin,
  });

  OrderModel copyWith({
    int? orderNumber,
    String? orderDate,
    int? orderTotalPrice,
    String? orderStatus,
    List<dynamic>? articlesList,
    String? userName,
    String? userSurname,
    String? userLogin,
  }) =>
      OrderModel(
        orderNumber: orderNumber ?? this.orderNumber,
        orderDate: orderDate ?? this.orderDate,
        orderTotalPrice: orderTotalPrice ?? this.orderTotalPrice,
        orderStatus: orderStatus ?? this.orderStatus,
        articlesList: articlesList ?? this.articlesList,
        userName: userName ?? this.userName,
        userSurname: userSurname ?? this.userSurname,
        userLogin: userLogin ?? this.userLogin,
      );

  factory OrderModel.fromRawJson(String str) => OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderNumber: json["orderNumber"],
    orderDate: json["orderDate"],
    orderTotalPrice: json["orderTotalPrice"],
    orderStatus: json["orderStatus"],
    articlesList: List<dynamic>.from(json["articlesList"].map((x) => x)),
    userName: json["userName"],
    userSurname: json["userSurname"],
    userLogin: json["userLogin"],
  );

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber,
    "orderDate": orderDate,
    "orderTotalPrice": orderTotalPrice,
    "orderStatus": orderStatus,
    "articlesList": List<dynamic>.from(articlesList.map((x) => x)),
    "userName": userName,
    "userSurname": userSurname,
    "userLogin": userLogin,
  };
}
