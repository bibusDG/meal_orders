import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoTextField extends StatelessWidget {
  const CustomCupertinoTextField({
    Key? key,
    required this.textAlignment,
    required this.keyboardType,
    required this.placeholder,
    required this.controller,
    required this.suffixText
  }) : super(key: key);

  final TextAlignVertical textAlignment;
  final TextInputType keyboardType;
  final String? placeholder;
  final dynamic controller;
  final String? suffixText;

  @override
  Widget build(BuildContext context) {
    TextInputType _keyboardType = keyboardType;
    TextAlignVertical _textAlignment = textAlignment;
    return SizedBox(
      height: 50,
      width: 300,
      child: CupertinoTextField(
        keyboardType: _keyboardType,
        suffix: Text(suffixText!),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.black),
        textAlignVertical: _textAlignment,
        cursorColor: Colors.white,
        maxLines: null,
        placeholder: placeholder,
        cursorHeight: 20.0,
        onChanged: (text) {
          if(key == const Key('CategoryName')){
            controller.newCategory.categoryName = text;
            controller.refreshNewCategoryModel();
            print(text);
          }else if(key == const Key('MealName')){
            controller.newMeal.mealName = text;
            controller.refreshNewMealModel();
            print(text);
          }else if(key == const Key('MealPrice')){
            controller.newMeal.mealPrice = text;
            controller.refreshNewMealModel();
          }else if(key == const Key('MealDescription')){
            controller.newMeal.mealDescription = text;
            controller.refreshNewMealModel();
          }

        },
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}