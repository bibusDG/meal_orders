import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:meal_orders/myWidgets/custom_cupertino_text_field.dart';
import 'package:meal_orders/pages/start_page.dart';
import 'package:meal_orders/services/firebase_services/user_firebase_services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../models/user_model.dart';

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
                  key: const Key('accountLogin'),
                  obscureText: false,
                  textAlignment: TextAlignVertical.center,
                  keyboardType: TextInputType.text,
                  placeholder: 'login',
                  controller: _user,
                  suffixText: ''),
              const SizedBox(height: 20.0,),
              CustomCupertinoTextField(
                  key: const Key('accountPassword'),
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
                  onPressed: () async{
                    try{
                      var userExist = await UserFirebaseServices().checkIfUserExist(_user.user);
                      if(userExist == true) {
                        _user.userLoggedIn.value = true;
                        var fetchedUser = await UserFirebaseServices().fetchUser(userLogin: _user.user.userLogin, userPassword: _user.user.userPassword);
                        // print(_user.user);
                        UserModel user = UserModel.fromJson(Map<String, dynamic>.from(fetchedUser.docs[0].data()));
                        _user.updateUserController(user);
                        Get.offAll(()=>const StartPage());
                      }
                    }catch(error){}
                  })
            ],
          ),
        ),
      ),
    );
  }
}

