import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserController _user = Get.find();

    return ResponsiveScaledBox(
      width: 360,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: CustomAppBarWidget(
                  user: _user,
                  appBarText: 'Rejestracja')),
        )
    );
  }
}
