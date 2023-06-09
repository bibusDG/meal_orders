import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../pages/account_page.dart';
import '../pages/registration_page.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    Key? key,
    required UserController user,
    required this.appBarText,
  }) : _user = user, super(key: key);

  final UserController _user;
  final String appBarText;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      actions: [
        IconButton(onPressed: (){
          showCupertinoModalPopup(context: context, builder: (_){
            return _user.user.userLoggedIn == false ?
            CupertinoActionSheet(
              title: const Text('Wybierz opcję'),
              actions:
              [
                CupertinoActionSheetAction(onPressed: (){
                  Get.back();
                  Get.to(()=> const AccountPage());
                }, child: const Text('Zaloguj się')),
                CupertinoActionSheetAction(onPressed: (){
                  Get.back();
                  Get.to(()=> const RegistrationPage());
                }, child: Text('Zarejestruj się')),
              ],
            ) :
            _user.user.isAdmin == true && _user.user.userLoggedIn == true ?
            CupertinoActionSheet(
              title: const Text('Wybierz opcję'),
              actions:
              [
                CupertinoActionSheetAction(onPressed: (){}, child: Text('Wyloguj się')),
                CupertinoActionSheetAction(onPressed: (){}, child: Text('Zmień swój login')),
                CupertinoActionSheetAction(onPressed: (){}, child: Text('Panel administratora')),
              ],
            ):
            CupertinoActionSheet(
              title: const Text('Wybierz opcję'),
              actions:
              [
                CupertinoActionSheetAction(onPressed: (){}, child: Text('Wyloguj się')),
                CupertinoActionSheetAction(onPressed: (){}, child: Text('Zmień swój login')),
              ],
            );
          });
          // Get.to(()=>const AccountPage());
        }, icon: const Icon(Icons.account_circle_outlined)),
      ],
      centerTitle: true,
      title: Text(appBarText),
    );
  }
}