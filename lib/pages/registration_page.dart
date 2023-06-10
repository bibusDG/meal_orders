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
                  appBarText: 'Rejestracja'),
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 20.0,),
                CustomCupertinoTextField(
                    key: const Key('registrationUserName'),
                    obscureText: false,
                    textAlignment: TextAlignVertical.center,
                    keyboardType: TextInputType.name,
                    placeholder: 'imię',
                    controller: _user,
                    suffixText: ''),
                const SizedBox(height: 20.0,),
                CustomCupertinoTextField(
                    key: const Key('registrationUserSurname'),
                    obscureText: false,
                    textAlignment: TextAlignVertical.center,
                    keyboardType: TextInputType.name,
                    placeholder: 'nazwisko',
                    controller: _user,
                    suffixText: ''),
                const SizedBox(height: 20.0,),
                CustomCupertinoTextField(
                    key: const Key('registrationLogin'),
                    obscureText: false,
                    textAlignment: TextAlignVertical.center,
                    keyboardType: TextInputType.text,
                    placeholder: 'login',
                    controller: _user,
                    suffixText: ''),
                const SizedBox(height: 20.0,),
                CustomCupertinoTextField(
                    key: const Key('registrationPassword'),
                    obscureText: true,
                    textAlignment: TextAlignVertical.center,
                    keyboardType: TextInputType.name,
                    placeholder: 'hasło',
                    controller: _user,
                    suffixText: ''),
                const SizedBox(height: 20.0,),
                CustomCupertinoTextField(
                    key: const Key('registrationRepeatPassword'),
                    obscureText: true,
                    textAlignment: TextAlignVertical.center,
                    keyboardType: TextInputType.name,
                    placeholder: 'powtórz hasło',
                    controller: _user,
                    suffixText: ''),
                const SizedBox(height: 30.0,),
                CupertinoButton(
                  color: Colors.teal,
                  onPressed: () async{
                    try{
                      var userExist = await UserFirebaseServices().checkIfUserExist(_user.user);
                      if(userExist == false){
                        if(registrationConditionsPassed() == true && _user.user.userLogin == 'admin' && _user.user.userPassword == 'admin123'){
                          _user.user.isAdmin = true;
                          _user.userLoggedIn.value = true;
                          UserFirebaseServices().registerUser(_user.user);
                          Get.offAll(()=> const StartPage());
                        }else if(registrationConditionsPassed() == true){
                          _user.userLoggedIn.value = true;
                          UserFirebaseServices().registerUser(_user.user);
                          Get.offAll(()=> const StartPage());
                        }else{
                          Get.defaultDialog(
                              title: 'Uwaga',
                              content: Text('Wprowadzono nieprawidłowe dane')
                          );
                        }

                      }else{
                        Get.defaultDialog(
                          title: 'Uwaga',
                          content: const Text('Użytkownik o takim loginie już istnieje'),
                        );
                      }
                    }catch(error){}
                  },
                  child: Text('Zarejestruj'),
                ),
              ],
            ),
          ),
        )
    );
  }

  registrationConditionsPassed({user}){

    UserController _user = Get.find();

    if(
    _user.user.userName.trim() != '' &&
    _user.user.userSurName.trim() != '' &&
    _user.user.userLogin.trim() != '' &&
    _user.user.userPassword.trim() != '' &&
    _user.user.userPassword.length >= 6 &&
    _user.user.userPassword == _user.repeatedPassword.value
    ){
      return true;
    }else{
      return false;
    }
  }

}
