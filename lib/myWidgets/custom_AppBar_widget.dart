import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/pages/admin_panel_page.dart';
import 'package:meal_orders/pages/cart_page.dart';
import 'package:meal_orders/pages/detailed_product_page.dart';
import 'package:meal_orders/pages/products_page.dart';
import 'package:meal_orders/pages/start_page.dart';
import '../controllers/user_controller.dart';
import '../pages/account_page.dart';
import '../pages/registration_page.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    Key? key,
    this.arguments,
    required UserController user,
    required this.appBarText,
  })
      : _user = user,
        super(key: key);

  final UserController _user;
  final String appBarText;
  final dynamic arguments;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: Get.currentRoute == '/StartPage' ? false : true,
      leading:Get.currentRoute != '/' && Get.currentRoute != '/StartPage'? GestureDetector(
        onTap: (){
          Get.back();
        },
          child: Icon(Icons.arrow_back_ios)) : SizedBox(),
      actions: [
        IconButton(onPressed: () {
          showCupertinoModalPopup(context: context, builder: (_) {
            return _user.userLoggedIn.value == false ?
            CupertinoActionSheet(
              title: const Text('Wybierz opcję'),
              actions:
              [
                CupertinoActionSheetAction(onPressed: () {
                  Get.back();
                  Get.to(() => const AccountPage());
                }, child: const Text('Zaloguj się')),
                CupertinoActionSheetAction(onPressed: () {
                  Get.back();
                  Get.to(() => const RegistrationPage());
                }, child: const Text('Zarejestruj się')),
              ],
            ) :
            _user.user.isAdmin == true && _user.userLoggedIn.value == true ?
            CupertinoActionSheet(
              title: const Text('Wybierz opcję'),
              actions:
              [
                CupertinoActionSheetAction(onPressed: () {
                  _user.userLoggedIn.value = false;
                  Get.offAll(() => const StartPage());
                }, child: Text('Wyloguj się')),
                CupertinoActionSheetAction(onPressed: () {}, child: Text('Zmień swój login')),
                CupertinoActionSheetAction(onPressed: () {
                  Get.back();
                  Get.to(() => const AdminPanelPage());
                }, child: Text('Panel administratora')),
              ],
            ) :
            CupertinoActionSheet(
              title: const Text('Wybierz opcję'),
              actions:
              [
                CupertinoActionSheetAction(onPressed: () {
                  _user.userLoggedIn.value = false;
                  Get.offAll(() => const StartPage());
                }, child: const Text('Wyloguj się')),
                CupertinoActionSheetAction(onPressed: () {}, child: const Text('Zmień swój login')),
              ],
            );
          });
          // Get.to(()=>const AccountPage());
        }, icon: const Icon(Icons.account_circle_outlined)),
        _user.userLoggedIn.value == true ?
        IconButton(onPressed: () {
          if(Get.currentRoute == '/ProductsPage'){
            Get.to(()=> const CartPage(), arguments: arguments);
          }else if(Get.currentRoute == '/DetailedProductPage'){
            Get.to(()=> const CartPage(), arguments: arguments);
          }
          Get.to(()=> const CartPage());
        },
          icon: Obx(() {
            return Stack(
              alignment: Alignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  Align(
                    alignment: const Alignment(1, -1.4),
                    child: Text(_user.user.userBasket.length.toString()),
                  ),
                ]
            );
          }),
        )
            : const SizedBox(),
        const SizedBox(width: 10.0,)
      ],
      centerTitle: true,
      title: Text(appBarText),
    );
  }
}