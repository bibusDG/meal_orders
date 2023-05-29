import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/controllers/main_category_controller.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../myWidgets/custom_cupertino_text_field.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainCategoryController mainCategoryController = Get.put(MainCategoryController());

    return ResponsiveScaledBox(
      width: 370,
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Dodaj kategorię'),
            centerTitle: true,
          ),
          body: Center(
            child: Obx(() {
              return Column(
                children: [
                  const SizedBox(height: 30.0,),
                  const Text('Podaj nazwę nowej kategorii: '),
                  const SizedBox(height: 15.0,),
                  CustomCupertinoTextField(
                    textAlignment: TextAlignVertical.center,
                    keyboardType: TextInputType.text,
                    placeholder: 'Zupy',
                    suffixText: '',
                    key: const Key("CategoryName"),
                    controller: mainCategoryController
                  ),
                  const SizedBox(height: 50.0,),
                  const Text('Dodaj zdjęcie kategorii'),
                  const SizedBox(height: 15.0,),
                  IconButton(onPressed: () {
                    mainCategoryController.newCategory.categoryPicture = 'dd';
                    mainCategoryController.refreshNewCategoryModel();
                  }, icon: const Icon(Icons.photo_library_outlined, size: 50.0,), padding: const EdgeInsets.all(0.0),),
                  const SizedBox(height: 40.0,),
                  mainCategoryController.newCategory.categoryName != '' && mainCategoryController.newCategory.categoryPicture != ''?
                  Column(
                    children: [
                      CupertinoButton(child: const Text('Dodaj'), onPressed: () {}),
                      CupertinoButton(child: const Text('Anuluj'), onPressed: () {})
                    ],
                  ) : const SizedBox(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}


