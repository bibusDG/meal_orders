import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/controllers/meal_controller.dart';
import 'package:meal_orders/models/meal_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DetailedProductPage extends StatelessWidget {
  const DetailedProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MealController mealController = Get.put(MealController());
    MealModel _product = Get.arguments;
    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(_product.mealName),
          ),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0,),
              Center(
                child: Container(
                  color: Colors.red,
                  width: 200,
                  height: 200,
                  child: const Center(child: Text('Photo')),
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
                              Text(_product.mealName.toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 22.0),),
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
                                            mealController.chosenVariant.value = _product.mealVariants[index];
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black),
                                              color: mealController.chosenVariant.value == _product.mealVariants[index] ?
                                              Colors.amberAccent : Colors.white,
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
