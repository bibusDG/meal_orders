import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/pages/admin_panel_page.dart';
import 'package:responsive_framework/responsive_framework.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
       appBar: AppBar(
         actions: [
           IconButton(onPressed: (){
             Get.to(()=>const AdminPanelPage());
           }, icon: const Icon(Icons.admin_panel_settings)),
         ],
         centerTitle: true,
         title: const Text('Deal with Meal'),
       ),
        body: ListView.builder(
          padding: const EdgeInsets.all(30.0),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index){
          return const SizedBox(
            height: 280,
            child: Card(
              margin: EdgeInsets.all(10.0),
              color: Colors.white,
            ),
          );
        })
      ),
    );
  }
}
