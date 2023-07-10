import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/controllers/cart_controller.dart';
import 'package:meal_orders/controllers/meal_controller.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/models/main_category_model.dart';
import 'package:meal_orders/models/meal_model.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:meal_orders/myWidgets/custom_drawer.dart';
import 'package:meal_orders/pages/cart_page.dart';
import 'package:meal_orders/pages/products_page.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DetailedProductPage extends StatelessWidget {
  const DetailedProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MealController mealController = Get.put(MealController());
    CartController _cartItems = Get.find();
    UserController _user = Get.find();
    MealModel _product = Get.arguments;
    _product.chosenVariant = mealController.newMeal.chosenVariant;
    final mealPicture = const Base64Decoder().convert(_product.mealPicture);
    Image img = Image.memory(mealPicture);

    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
        // drawer: MyCustomDrawer(),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: CustomAppBarWidget(user: _user, appBarText: _product.mealName, arguments: _product,),
          ),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0,),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: img.image,
                          fit: BoxFit.cover
                      ),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0)),
                  // width: 210,
                  height: 200,
                  // color: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0,),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0))),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 10.0,),
                          Row(
                            children: [
                              const SizedBox(width: 10.0,),
                              Text(_product.mealName.toUpperCase(), style: const TextStyle(color: Colors.black, fontSize: 22.0),),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('PLN', style: TextStyle(color: Colors.amber, fontSize: 20.0),),
                              const SizedBox(width: 10.0,),
                              Text(_product.mealPrice, style: const TextStyle(color: Colors.black, fontSize: 40.0),),
                              Text(_product.unitMeasure, style: const TextStyle(color: Colors.black),),
                              const SizedBox(width: 10.0,)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              SizedBox(width: 10.0,),
                              Text('Możliwe warianty ', style: TextStyle(color: Colors.black),),
                            ],
                          ),
                          Row(
                            children:[
                              _product.mealAvailability == true ?
                              const Text('Dostępny', style: TextStyle(color: Colors.green)) :
                              const Text('Niedostępny', style: TextStyle(color: Colors.redAccent)),
                              const SizedBox(width: 10.0,)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0,),
                      _product.mealVariants.isEmpty ?
                      const Text('Brak możliwości wyboru') :
                      Obx(() {
                        return Row(
                            children: List<Widget>.generate(_product.mealVariants.length, (int index) {
                              return Center(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0,),
                                      GestureDetector(
                                        onTap: () {
                                            mealController.newMeal.chosenVariant = _product.mealVariants[index];
                                            _product.chosenVariant = mealController.newMeal.chosenVariant;
                                            mealController.refreshNewMealModel();
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black),
                                              color: mealController.newMeal.chosenVariant == _product.mealVariants[index] ?
                                              Colors.grey[400] : Colors.white,
                                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                            ),
                                            width: 60,
                                            height: 30,
                                            child: Center(child: Text(_product.mealVariants[index], style: const TextStyle(color: Colors.black),))),
                                      ),
                                    ],
                                  )
                              );
                            })
                        );
                      }),
                      const SizedBox(height: 15.0,),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                                  decoration: const BoxDecoration(color: Colors.white),
                                  alignment: Alignment.topLeft,
                                  // height: 240,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Opis produktu', style: TextStyle(color: Colors.black, fontSize: 18),),
                                          const SizedBox(height: 15.0,),
                                          Text(_product.mealDescription, textAlign: TextAlign.justify, style: const TextStyle(color: Colors.black),),
                                          const SizedBox(height: 40.0,),
                                        ],
                                      ),
                                    ),
                                  ),
                              ),
                            Align(
                              alignment: const Alignment(0.9,0.80),
                              child: SizedBox(
                                width: 75,
                                height: 75,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Colors.white,
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      tooltip: "Dodaj do koszyka",
                                      icon: const Icon(Icons.shopping_cart_outlined, size: 30,),
                                      color: Colors.black,
                                      onPressed: () {
                                        if(_user.userLoggedIn.value == false){
                                          Get.defaultDialog(
                                              title: 'Uwaga',
                                              content: Text('Aby dodać produkty do koszyka musisz być zalogowany')
                                          );
                                        }else if(_user.userLoggedIn.value == true && _cartItems.itemList.contains(_product.mealName+_product.chosenVariant)){
                                          Get.defaultDialog(
                                              title: 'UWaga',
                                              content: Text('Produkt znajduje się juz w koszyku')
                                          );
                                        }else{
                                          _cartItems.itemList.add(_product.mealName+_product.chosenVariant);
                                          _product.productCounter =1;
                                          _cartItems.totalPrice.value += int.parse(_product.mealPrice);
                                          _user.user.userBasket.add(_product);
                                          mealController.newMeal.chosenVariant = 'vegan';
                                          _user.refreshUserModel();
                                          // Get.back();
                                          Get.to(()=>const ProductsPage(), arguments: _product);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
