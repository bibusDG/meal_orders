import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:meal_orders/pages/actual_orders_page.dart';
import 'package:meal_orders/pages/add_category_page.dart';
import 'package:meal_orders/pages/add_meal_page.dart';
import 'package:meal_orders/pages/edit_meal_page.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserController _user = Get.find();

    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomAppBarWidget(
            user: _user,
            appBarText: 'Panel administratora',
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 50.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(onPressed: (){
                      Get.to(()=>const EditMealPage());
                    }, icon: const Icon(Icons.edit, color: Colors.teal,)),
                    const SizedBox(height: 10.0,),
                    const Text('Edytuj potrawę/produkt', style: TextStyle(decoration: TextDecoration.underline))
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: (){
                      Get.to(()=>const AddMealPage());
                    }, icon: const Icon(Icons.add, color: Colors.lightGreen),),
                    const SizedBox(height: 10.0,),
                    const Text('Dodaj potrawę/produkt', style: TextStyle(decoration: TextDecoration.underline),)
                  ],
                )
              ],
            ),
            const SizedBox(height: 50.0,),
            Column(
              children: [
                IconButton(onPressed: (){
                  Get.to(()=>const AddCategoryPage());
                }, icon: const Icon(Icons.add_box_outlined, color: Colors.deepOrange,)),
                const SizedBox(height: 10.0,),
                const Text('Dodaj kategorię', style: TextStyle(decoration: TextDecoration.underline))

            ],
            ),
            const SizedBox(height: 50.0,),
            Column(
              children: [
                IconButton(onPressed: (){
                  Get.to(()=>const ActualOrdersPage());
                }, icon: const Icon(Icons.bookmark_border, color: Colors.yellowAccent,)),
                const SizedBox(height: 10.0,),
                const Text('Aktualne zamówienia', style: TextStyle(decoration: TextDecoration.underline))

              ],
            ),
          ],
        ),
      ),
    );
  }
}
