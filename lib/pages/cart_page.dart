import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meal_orders/controllers/cart_controller.dart';
import 'package:meal_orders/controllers/order_controller.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/models/meal_model.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:meal_orders/myWidgets/custom_drawer.dart';
import 'package:meal_orders/pages/start_page.dart';
import 'package:meal_orders/services/firebase_services/order_firebase_services.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    OrderController _order = Get.put(OrderController());
    UserController _user = Get.find();
    CartController cartController = Get.find();

    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
        // drawer: MyCustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomAppBarWidget(
            user: _user,
            appBarText: 'Koszyk',
          ),
        ),
        body: Obx(() {
          return Column(
            children: [
              Flexible(
                flex: 3,
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10.0),
                    itemExtent: 150.0,
                    itemCount: _user.user.userBasket.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<MealModel> _productList = _user.user.userBasket;
                      // RxInt summaryPrice = cartController.summaryPrice;
                      if (_productList.isEmpty) {
                        return const Center(
                          child: Text('Brak produktów w koszyku'),
                        );
                      } else {
                        var productSummary = (int.parse(_productList[index].mealPrice)*_productList[index].productCounter).toString();
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0, right: 10.0, left: 10.0),
                          child: Stack(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                elevation: 20.0,
                                child: Center(
                                  child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(_productList[index].mealName.capitalize!),
                                            const SizedBox(height: 10.0,),
                                            Text(_productList[index].chosenVariant, style: TextStyle(color: Colors.blue),),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(productSummary, style: const TextStyle(fontSize: 30.0, color: Colors.tealAccent),),
                                                const SizedBox(width: 2.0,),
                                                const Text('PLN'),
                                              ],
                                            ),
                                            Text('/ ${_productList[index].unitMeasure}', style: const TextStyle(fontSize: 10.0),)
                                          ],
                                        ),
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // SizedBox(width: 10.0,),
                                            IconButton(onPressed: () {
                                              _productList[index].productCounter ++;
                                              cartController.totalPrice.value += int.parse(_productList[index].mealPrice);
                                              _user.refreshUserModel();
                                            }, icon: const Icon(Icons.add)),
                                            Text(_productList[index].productCounter.toString()),
                                            IconButton(onPressed: () {
                                              if(_productList[index].productCounter >1){
                                                _productList[index].productCounter --;
                                                cartController.totalPrice.value -= int.parse(_productList[index].mealPrice);
                                                _user.refreshUserModel();
                                              }null;
                                            }, icon: const Icon(Icons.remove)),
                                          ],
                                        ),
                                      ],
                                    ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment(1.02,-1.2),
                                  child: GestureDetector(
                                      child: Icon(Icons.delete),
                                    onTap: (){
                                        cartController.itemList.remove(_productList[index].mealName+_productList[index].chosenVariant);
                                        _user.user.userBasket.remove(_productList[index]);
                                        cartController.totalPrice.value -= int.parse(productSummary);
                                        _user.refreshUserModel();
                                    },
                                  ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
              Flexible(flex: 1,
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0,),
                      const Text('Całkowity koszt zamówienia: '),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text('${cartController.totalPrice.value.toString()} PLN', style: TextStyle(fontSize: 30.0, color: Colors.tealAccent),),
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      CupertinoButton(
                        color: Colors.black,
                          child: Text('Zamów'),
                          onPressed: (){
                          var lst = [];
                          for(var item in _user.user.userBasket){
                            lst.add(item.toJson());
                          }
                          _order.newOrder.articlesList = lst;
                          _order.newOrder.orderNumber = random.nextInt(90000000) + 10000000;
                          _order.newOrder.orderDate = DateTime.now().toString();
                          _order.newOrder.orderTotalPrice = cartController.totalPrice.value;
                          try {
                            OrderFirebaseServices().addOrder(_order.newOrder);
                            Get.snackbar(
                              "GeeksforGeeks",
                              "Hello everyone",
                              icon: Icon(Icons.person, color: Colors.white),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                            );
                            _user.user.userBasket = [];
                            _user.refreshUserModel();
                            cartController.itemList.value = [];
                            cartController.totalPrice.value = 0;
                            // Get.to(()=>const StartPage());
                          }catch(error){}


                          // print(random.nextInt(90000000) + 10000000);
                          })
                    ],
                  )),
            ],
          );
        }),
      ),
    );
  }
}
