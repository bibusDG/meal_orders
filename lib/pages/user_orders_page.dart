import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/controllers/order_controller.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/models/meal_model.dart';
import 'package:meal_orders/models/order_model.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:meal_orders/services/firebase_services/order_firebase_services.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserOrdersPage extends StatelessWidget {
  const UserOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController _user = Get.find();
    OrderController orderController = Get.put(OrderController());
    Map pictures = {};

    return ResponsiveScaledBox(
        width: 360,
        child: Obx(() {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: orderController.bottomBarIndex.value,
              type: BottomNavigationBarType.fixed,
              onTap: _onTap,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.snooze), label: 'Oczekujące'),
                BottomNavigationBarItem(icon: Icon(Icons.timelapse_outlined,), label: 'Realizowane'),
                BottomNavigationBarItem(icon: Icon(Icons.waving_hand), label: 'Do odbioru'),
                BottomNavigationBarItem(icon: Icon(Icons.all_inclusive_rounded), label: 'Wszystkie')
              ],
            ),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: CustomAppBarWidget(
                user: _user,
                appBarText: 'Moje zamówienia',

              ),
            ),
            body: StreamBuilder(
                stream: orderController.bottomBarIndex.value == 0 ?
                OrderFirebaseServices().streamChosenUserOrders(userLogin: _user.user.userLogin, sortText: 'Oczekuje na realizację') :
                orderController.bottomBarIndex.value == 1 ?
                OrderFirebaseServices().streamChosenUserOrders(userLogin: _user.user.userLogin, sortText: 'W przygotowaniu') :
                orderController.bottomBarIndex.value == 2 ?
                OrderFirebaseServices().streamChosenUserOrders(userLogin: _user.user.userLogin, sortText: 'Do odbioru') :
                OrderFirebaseServices().streamAllUserOrders(userLogin: _user.user.userLogin),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length > 0) {
                      return ListView.builder(
                          itemExtent: 180,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index){
                            OrderModel userOrder = OrderModel.fromJson(Map<String, dynamic>.from(snapshot.data.docs[index].data()));
                            List items = [];

                            ///setting gallery of meal pictures
                            ///Image.memory(const Base64Decoder().convert(mealController.newMeal.mealPicture)).image,)

                            for(var item in userOrder.articlesList){
                              items.add(Image.memory(const Base64Decoder().convert(item['mealPicture'])).image);
                            }
                            pictures[index] = items;
                            // items = [];

                            ///
                            return GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                    titleStyle: const TextStyle(color: Colors.tealAccent),
                                    title: userOrder.orderNumber.toString(),
                                    content: Column(
                                      children: [
                                        const SizedBox(height: 20.0,),
                                        const Text('Zamówione produkty:'),
                                        const SizedBox(height: 20.0,),
                                        SizedBox(
                                          height: 250,
                                          width: 300,
                                          child: ListView.builder(
                                              itemExtent: 75,
                                              itemCount: userOrder.articlesList.length,
                                              itemBuilder: (BuildContext context, int counter) {
                                                MealModel product = MealModel.fromJson(Map<String, dynamic>.from(userOrder.articlesList[counter]));
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(product.productCounter.toString(), style: const TextStyle(fontSize: 30.0),),
                                                        const Text(' X '),
                                                        Text(product.mealName, style: const TextStyle(fontSize: 25.0),),
                                                      ],
                                                    ),
                                                    Text('wariant: ${product.chosenVariant}')
                                                  ],
                                                );
                                              }),
                                        ),
                                        Text('data zam. ${userOrder.orderDate.substring(0, 16)}'),
                                        Text('status zam. ${userOrder.orderStatus}'),
                                        Text('całkowity koszt: ${userOrder.orderTotalPrice} PLN')
                                      ],
                                    )
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.only(top: 20.0, left: 30, right: 30.0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                // color: Colors.white,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const SizedBox(height: 5.0,),
                                    SizedBox(
                                      width: 250,
                                      height: 110,
                                      child: Swiper(
                                        viewportFraction: 0.8,
                                        scale: 0.8,
                                        loop: false,
                                        itemBuilder: (BuildContext context, int ind){
                                          return Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: pictures[index][ind],
                                                    fit: BoxFit.fill
                                                ),
                                                color: Colors.black,
                                                borderRadius: BorderRadius.circular(10.0)),
                                            // width: 110,
                                            // height: 110,
                                            // color: Colors.black,
                                          );
                                        },
                                          itemCount: pictures[index].length),
                                    ),
                                    // Text(pictures[index].toString()),
///done
                                    const SizedBox(height: 20.0,),
                                    // SizedBox(width: 5.0,),
                                    Center(child: Text(userOrder.orderStatus, style: TextStyle(
                                      color: userOrder.orderStatus == "Do odbioru" ? Colors.lightGreenAccent : Colors.white,
                                        fontSize: 15),)),
                                    const SizedBox(width: 20.0,)
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    else {
                      return const Center(child: Text('Brak zamówień w danej kategorii'));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                }
            ),

          );
        }));
  }
  void _onTap(int index){
    OrderController orderController = Get.find();
    orderController.bottomBarIndex.value = index;
  }
}
