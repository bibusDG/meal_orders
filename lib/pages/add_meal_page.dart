import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/controllers/meal_controller.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/models/main_category_model.dart';
import 'package:meal_orders/myWidgets/custom_AppBar_widget.dart';
import 'package:meal_orders/myWidgets/custom_cupertino_text_field.dart';
import 'package:meal_orders/pages/products_page.dart';
import 'package:meal_orders/services/firebase_services/product_firebase_services.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AddMealPage extends StatelessWidget {
  const AddMealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserController _user = Get.find();
    MealController mealController = Get.put(MealController());
    var mealDocumentID = Get.arguments;

    const double _itemExtent = 32.0;
    List _mainCategoryList = [];

    /// Setting values for meal variants (check boxes) while editing the meal
    if(mealController.editingMeal.value == true){
      if(mealController.newMeal.mealVariants.contains('vegan')){
        mealController.veganCheckBox.value = true;
      }
      if(mealController.newMeal.mealVariants.contains('mięso')){
        mealController.meatCheckBox.value = true;
      }
    }else{
      mealController.newMeal.mealVariants = [];
    }
    ///


    getCategoryList() async {
      _mainCategoryList = [];
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('Companies')
          .doc('martaSudol')
          .collection('mainCategories')
          .get();
      var listElements = snapshot.docs
          .map((docSnapshot) => MainCategoryModel.fromJson(docSnapshot.data()))
          .toList();
      for (var item in listElements) {
        _mainCategoryList.add(item.categoryName);
      }
    }


    return ResponsiveScaledBox(
      width: 360,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: CustomAppBarWidget(
              user: _user,
              appBarText: mealController.editingMeal.value == false ? 'Dodaj produkt' : 'Edytuj produkt',
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
            child: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if(mealController.editingMeal.value == false){
                      return IconButton(onPressed: addProductConditions() == true ? () async {
                        try{
                          await ProductFirebaseServices().addProduct(mealController.newMeal);
                          Get.to(()=>const ProductsPage(), arguments: mealController.newMeal);
                        }catch(error){print(error);}
                      } : null, icon: const Icon(Icons.add));
                    }else{
                      return IconButton(onPressed: () async{
                        try{
                          await ProductFirebaseServices().updateProduct(newMeal: mealController.newMeal, mealDocumentID: mealDocumentID);
                        }catch(error){}
                      }, icon: const Icon(Icons.refresh));
                    }
                  }),
                ],
              ),
            ),
          ),
          body: Obx(() {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30.0,),
                    const Text('Podaj nazwę potrawy/produktu'),
                    const SizedBox(height: 15.0,),
                    CustomCupertinoTextField(
                        obscureText: false,
                        textAlignment: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        placeholder: 'Zupa cebulowa',
                        suffixText: '',
                        key: const Key('MealName'),
                        controller: mealController),
                    const SizedBox(height: 30.0,),
                    const Text('Wybierz kategorię produktu'),
                    const SizedBox(height: 15.0,),
                    CupertinoButton(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Text(mealController.newMeal.categoryName), onPressed: () async {
                      await getCategoryList();
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
                        context: context, builder: (context) =>
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10.0,),
                              const Text('Wybierz kategorię produktu'),
                              const SizedBox(height: 20.0,),
                              SizedBox(
                                  height: 170,
                                  child: CupertinoPicker(
                                    magnification: 1.3,
                                    // backgroundColor: Colors.white,
                                    itemExtent: _itemExtent,
                                    onSelectedItemChanged: (int value) {
                                      mealController.newMeal.categoryName = _mainCategoryList[value];
                                      mealController.refreshNewMealModel();
                                    },
                                    children: List<Widget>.generate(_mainCategoryList.length, (int index) {
                                      return Center(child: Text(_mainCategoryList[index], style: const TextStyle(color: Colors.white),));
                                    }),)
                              ),
                            ],
                          ),
                      );
                      mealController.newMeal.categoryName = _mainCategoryList[0];
                      mealController.refreshNewMealModel();
                    }
                    ),
                    const SizedBox(height: 30.0,),
                    const Text('Podaj cenę potrawy/produktu'),
                    const SizedBox(height: 15.0,),
                    CustomCupertinoTextField(
                        obscureText: false,
                        textAlignment: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        placeholder: '0',
                        suffixText: 'PLN  ',
                        key: const Key('MealPrice'),
                        controller: mealController),
                    const SizedBox(height: 30.0,),
                    const Text('Dostępność'),
                    const SizedBox(height: 15.0,),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoSwitch(value: mealController.newMeal.mealAvailability,
                              onChanged: (value) {
                                mealController.newMeal.mealAvailability = value;
                                mealController.refreshNewMealModel();
                              })
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 30.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text('Jednostka miary'),
                                const SizedBox(height: 30.0,),
                                GestureDetector(
                                    child: Text(mealController.newMeal.unitMeasure),
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20.0))),
                                          context: context,
                                          builder: (builder) {
                                            return Obx(() {
                                              return SizedBox(
                                                height: 100.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      child: Text('sztuka', style: TextStyle(
                                                          fontSize: mealController.newMeal.unitMeasure == 'sztuka' ?
                                                          30 : 15
                                                      ),),
                                                      onTap: () {
                                                        mealController.newMeal.unitMeasure = 'sztuka';
                                                        mealController.refreshNewMealModel();
                                                      },
                                                    ),
                                                    GestureDetector(child: Text('litr', style: TextStyle(
                                                        fontSize: mealController.newMeal.unitMeasure == 'litr' ?
                                                        30 : 15
                                                    ),),
                                                      onTap: () {
                                                        mealController.newMeal.unitMeasure = 'litr';
                                                        mealController.refreshNewMealModel();
                                                      },
                                                    ),
                                                    GestureDetector(child: Text('porcja', style: TextStyle(
                                                        fontSize: mealController.newMeal.unitMeasure == 'porcja' ?
                                                        30 : 15
                                                    ),),
                                                      onTap: () {
                                                        mealController.newMeal.unitMeasure = 'porcja';
                                                        mealController.refreshNewMealModel();
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                          });
                                    }
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 50.0,),
                    const Text('Możliwe warianty'),
                    const SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 40,
                          child: CheckboxListTile(
                              activeColor: Colors.black,
                              title: const Text('Vege'),
                              value: mealController.veganCheckBox.value,
                              onChanged: (newValue) {
                            mealController.veganCheckBox.value = newValue!;
                            if (mealController.veganCheckBox.value == false && mealController.newMeal.mealVariants.contains('vegan')) {
                              mealController.newMeal.mealVariants.remove('vegan');
                            } else {
                              mealController.newMeal.mealVariants.add('vegan');
                            }
                            mealController.refreshNewMealModel();
                          }),
                        ),
                        SizedBox(
                          width: 140,
                          height: 40,
                          child: CheckboxListTile(
                              activeColor: Colors.black,
                              title: const Text('Mięso'),
                              value: mealController.meatCheckBox.value, onChanged: (newValue) {
                            mealController.meatCheckBox.value = newValue!;
                            if (mealController.meatCheckBox.value == false && mealController.newMeal.mealVariants.contains('mięso')) {
                              mealController.newMeal.mealVariants.remove('mięso');
                            } else {
                              mealController.newMeal.mealVariants.add('mięso');
                            }mealController.refreshNewMealModel();
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0,),
                    const Text('Opisz potrawę/produkt'),
                    const SizedBox(height: 15.0,),
                    SizedBox(
                      height: 400,
                      child: CustomCupertinoTextField(
                        obscureText: false,
                        textAlignment: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        placeholder: '...szczegółowy opis...',
                        key: const Key('MealDescription'),
                        controller: mealController,
                        suffixText: '',
                      ),
                    ),
                    const SizedBox(height: 30.0,),
                    mealController.editingMeal.value == false ? const Text('Dodaj zdjęcie produktu') : const Text('Zmień zdjęcie produktu'),
                    const SizedBox(height: 15.0,),
                    CupertinoButton(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black,
                        child: mealController.editingMeal.value == false ? const Text('Dodaj') : const Text('Zmień'), onPressed: () {
                      mealController.newMeal.mealPicture = 'picture';
                      mealController.refreshNewMealModel();
                    }),
                    const SizedBox(height: 40.0,)

                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  ///TODO add possibility to choose photo from gallery for each meal

  addProductConditions() {
    MealController mealController = Get.find();
    if (
    mealController.newMeal.mealName != '' &&
        mealController.newMeal.categoryName != '...kategoria...' &&
        mealController.newMeal.mealPrice != '' &&
        mealController.newMeal.mealVariants.isNotEmpty &&
        mealController.newMeal.mealDescription != '' &&
        mealController.newMeal.mealPicture != ''
    ) {
      return true;
    } else {
      return false;
    }
  }
}
