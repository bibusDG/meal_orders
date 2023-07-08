import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/controllers/cart_controller.dart';
import 'package:meal_orders/controllers/meal_controller.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/models/main_category_model.dart';
// import 'package:meal_orders/pages/admin_panel_page.dart';
import 'package:meal_orders/pages/products_page.dart';
import 'package:meal_orders/services/firebase_services/main_category_firebase_services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../models/user_model.dart';
import '../myWidgets/custom_AppBar_widget.dart';
import '../myWidgets/custom_drawer.dart';
import 'account_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserController _user = Get.put(UserController());
    CartController cartController = Get.put(CartController());

    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
        // drawer: const MyCustomDrawer(),
       appBar: PreferredSize(
         preferredSize: const Size.fromHeight(70.0),
        child: CustomAppBarWidget(
          user: _user, appBarText: 'Sudołki',),),
        body: StreamBuilder(
          stream: MainCategoryFirebaseServices().streamMainCategories(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.hasData){
              if(snapshot.data.docs.length == 0){
                return const Center(
                  child: SizedBox(
                    child: Text('Aktualnie brak kategorii')
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(30.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index){
                  MainCategoryModel mainCategory = MainCategoryModel.fromJson(Map<String, dynamic>.from(snapshot.data.docs[index].data()));
                  final mainCategoryPicture = const Base64Decoder().convert(mainCategory.categoryPicture);
                  Image img = Image.memory(mainCategoryPicture);
                  return SizedBox(
                    height: 280,
                    child: GestureDetector(
                      onTap: ()=> Get.to(()=>const ProductsPage(), arguments: mainCategory),
                      child: Stack(
                        children: [
                          Card(
                            // shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          margin: const EdgeInsets.all(30.0),
                          // color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              // shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: img.image,
                                fit: BoxFit.fill
                              ),
                            ),
                          ),
                        ),
                          Align(
                            alignment: const Alignment(0,1.15),
                            child: Text(mainCategory.categoryName, style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                          ),
                      ]),
                    ),
                  );
              });
            }else{
              return const CircularProgressIndicator(color: Colors.white,);
            }
          },
        )
      ),
    );
  }
}


// child: ListView.builder(
// padding: const EdgeInsets.all(30.0),
// itemCount: 10,
// itemBuilder: (BuildContext context, int index){
// return const SizedBox(
// height: 280,
// child: Card(
// margin: EdgeInsets.all(10.0),
// color: Colors.white,
// ),
// );
// }),