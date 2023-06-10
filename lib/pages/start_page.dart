import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/models/main_category_model.dart';
// import 'package:meal_orders/pages/admin_panel_page.dart';
import 'package:meal_orders/pages/products_page.dart';
import 'package:meal_orders/services/firebase_services/main_category_firebase_services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../models/user_model.dart';
import '../myWidgets/custom_AppBar_widget.dart';
import 'account_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserController _user = Get.put(UserController());

    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
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
                  return SizedBox(
                    height: 280,
                    child: GestureDetector(
                      onTap: ()=> Get.to(()=>const ProductsPage(), arguments: mainCategory),
                      child: Stack(
                        children: [
                          Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          margin: const EdgeInsets.all(10.0),
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: mainCategory.categoryName == "Chleby" ? const AssetImage(
                                    'assets/images/chleby.jpg') : const AssetImage(
                                    'assets/images/zupy.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(mainCategory.categoryName, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
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