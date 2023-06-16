import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/start_page.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
              onTap: (){
                Get.back();
                Get.to(()=>StartPage());
              },
              child: Icon(Icons.home)),
        ],
      ),
      width: 220.0,
    );
  }
}