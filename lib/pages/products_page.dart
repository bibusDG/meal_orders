import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:meal_orders/models/main_category_model.dart';
import 'package:meal_orders/models/meal_model.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:meal_orders/myWidgets/custom_drawer.dart';
import 'package:meal_orders/services/firebase_services/product_firebase_services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../controllers/user_controller.dart';
import 'detailed_product_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainCategoryModel _category = Get.arguments;
    UserController _user = Get.find();

    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
        // drawer: MyCustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: CustomAppBarWidget(user: _user, appBarText: _category.categoryName, arguments: _category,),
        ),
        body: FutureBuilder(
          future: ProductFirebaseServices().fetchProducts(_category.categoryName) ,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.hasData){
              if(snapshot.data.docs.length == 0){
                return const Center(
                  child: Text('Brak produktów w tej kategorii'),
                );
              }else{
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index){
                    MealModel mealModel = MealModel.fromJson(Map<String, dynamic>.from(snapshot.data.docs[index].data()));
                  return SizedBox(
                    height: 150,
                    child: Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.3,
                        motion: const BehindMotion(),
                        children: [
                          IconButton(
                              iconSize: 30.0,
                              color: Colors.white,
                              onPressed: (){},
                              icon: const Icon(Icons.delete_forever_outlined)),
                          IconButton(
                            iconSize: 30.0,
                              color: Colors.white,
                              onPressed: (){},
                              icon: const Icon(Icons.edit))
                        ],),
                      enabled: _user.user.isAdmin == true && _user.userLoggedIn.value == true ? true : false,
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=>const DetailedProductPage(), arguments: mealModel);
                        },
                        child: Card(
                          margin: const EdgeInsets.only(top: 20.0, left: 30, right: 30.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // SizedBox(width: 10.0,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)),
                                width: 110,
                                height: 110,
                                // color: Colors.black,
                              ),
                              // SizedBox(width: 5.0,),
                              Center(child: Text(mealModel.mealName,)),
                              const SizedBox(width: 20.0,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
              }
            }else{
              return const Center(child: CircularProgressIndicator());
            }
        }
        ),
      ),
    );
  }
}
