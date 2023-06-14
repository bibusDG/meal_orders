import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meal_orders/controllers/cart_controller.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/models/meal_model.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController _user = Get.find();
    CartController cartController = Get.find();

    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
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
              SizedBox(
                height: 600,
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10.0),
                    // itemExtent: 110.0,
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
                        return SizedBox(
                          height: 140.0,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
                                child: SizedBox(
                                  height: 100,
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                    elevation: 20.0,
                                    child: Center(
                                      child:
                                        Row(
                                          children: [
                                            const SizedBox(width: 10.0,),
                                            Text(_productList[index].mealName),
                                            const SizedBox(width: 120.0,),
                                            IconButton(onPressed: () {
                                              if(_productList[index].productCounter >1){
                                                _productList[index].productCounter --;
                                                cartController.totalPrice.value -= int.parse(_productList[index].mealPrice);
                                                _user.refreshUserModel();
                                              }null;
                                            }, icon: const Icon(Icons.remove)),
                                            // SizedBox(width: 10.0,),
                                            Text(_productList[index].productCounter.toString()),
                                            IconButton(onPressed: () {
                                              _productList[index].productCounter ++;
                                              cartController.totalPrice.value += int.parse(_productList[index].mealPrice);
                                              _user.refreshUserModel();
                                            }, icon: const Icon(Icons.add)),
                                            // Text((int.parse(_productList[index].mealPrice)*_productList[index].productCounter).toString()),
                                          ],
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(productSummary),
                                  const SizedBox(width: 5.0,),
                                  const Text('PLN'),
                                  const SizedBox(width: 20.0,)
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
              Text(cartController.totalPrice.value.toString()),
            ],
          );
        }),
      ),
    );
  }
}
