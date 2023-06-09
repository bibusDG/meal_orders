import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:meal_orders/myWidgets/custom_cupertino_text_field.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserController _user = Get.find();

    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: CustomAppBarWidget(
            user: _user, appBarText: 'Logowanie'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCupertinoTextField(
                  obscureText: false,
                  textAlignment: TextAlignVertical.center,
                  keyboardType: TextInputType.text,
                  placeholder: 'login',
                  controller: _user,
                  suffixText: ''),
              const SizedBox(height: 20.0,),
              CustomCupertinoTextField(
                  obscureText: true,
                  textAlignment: TextAlignVertical.center,
                  keyboardType: TextInputType.name,
                  placeholder: 'hasło',
                  controller: _user,
                  suffixText: ''),
              const SizedBox(height: 40.0,),
              CupertinoButton(
                  color: Colors.teal,
                  child: const Text('Zaloguj'),
                  onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}

