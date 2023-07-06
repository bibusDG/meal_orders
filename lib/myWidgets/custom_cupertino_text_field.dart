import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_orders/models/user_model.dart';

class CustomCupertinoTextField extends StatelessWidget {
  const CustomCupertinoTextField({
    Key? key,
    required this.obscureText,
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
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    TextInputType _keyboardType = keyboardType;
    TextAlignVertical _textAlignment = textAlignment;

    TextEditingController _textController = TextEditingController();
    if(key == const Key('CategoryName')){
      _textController.text = controller.newCategory.categoryName;
    }else if(key == const Key('MealName')){
      _textController.text = controller.newMeal.mealName;
    }else if(key == const Key('MealPrice')){
      _textController.text = controller.newMeal.mealPrice;
    }else if(key == const Key('MealDescription')){
      _textController.text = controller.newMeal.mealDescription;
    }

    return SizedBox(
      height: 50,
      width: 300,
      child: CupertinoTextField(
        controller: _textController,
        obscuringCharacter: '*',
        obscureText: obscureText,
        keyboardType: _keyboardType,
        suffix: Text(suffixText!),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.black),
        textAlignVertical: _textAlignment,
        cursorColor: Colors.white,
        maxLines: obscureText == false ? null : 1,
        placeholder: placeholder,
        cursorHeight: 20.0,
        onChanged: (text) {
          if(key == const Key('CategoryName')){
            controller.newCategory.categoryName = text;
            // controller.refreshNewCategoryModel();
          }else if(key == const Key('MealName')){
            controller.newMeal.mealName = text;
            // controller.refreshNewMealModel();
          }else if(key == const Key('MealPrice')){
            controller.newMeal.mealPrice = text;
            // controller.refreshNewMealModel();
          }else if(key == const Key('MealDescription')){
            controller.newMeal.mealDescription = text;
            // controller.refreshNewMealModel();
          }else if(key == const Key('registrationUserName')){
            controller.user.userName = text;
            // controller.refreshUserModel;
          }else if(key == const Key('registrationUserSurname')){
            controller.user.userSurName = text;
            // controller.refreshUserModel;
          }else if(key == const Key('registrationLogin')){
            controller.user.userLogin = text;
            // controller.refreshUserModel;
          }else if(key == const Key('registrationPassword')){
            controller.user.userPassword = text;
            // controller.refreshUserModel;
          }else if(key == const Key('registrationRepeatPassword')){
            controller.repeatedPassword.value = text;
            // controller.refreshUserModel;
          }else if(key == const Key('accountLogin')){
            controller.user.userLogin = text;
            // controller.refreshUserModel;
          }else if(key == const Key('accountPassword')){
            controller.user.userPassword = text;
            // controller.refreshUserModel;
          }

        },
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}