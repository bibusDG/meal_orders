import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/controllers/meal_controller.dart';
import 'package:meal_orders/myWidgets/custom_cupertino_text_field.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AddMealPage extends StatelessWidget {
  const AddMealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MealController mealController = Get.put(MealController());

    return ResponsiveScaledBox(
      width: 360,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Dodaj potrawę'),
            centerTitle: true,
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
                        child: const Text('...kategoria...'), onPressed: (){}
                    ),
                    const SizedBox(height: 30.0,),
                    const Text('Podaj cenę potrawy/produktu'),
                    const SizedBox(height: 15.0,),
                    CustomCupertinoTextField(
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
                    mealController.newMeal.mealAvailability == true ?
                    Column(
                      children: [
                        const SizedBox(height: 30.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text('Ilość'),
                                const SizedBox(height: 10.0,),
                                SizedBox(
                                    width: 60,
                                    child: CustomCupertinoTextField(
                                        textAlignment: TextAlignVertical.center,
                                        keyboardType: TextInputType.number,
                                        placeholder: '1',
                                        controller: mealController,
                                        suffixText: '')
                                )
                              ],
                            ),

                            Column(
                              children: [
                                const Text('Miara'),
                                const SizedBox(height: 40.0,),
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
                                                          fontSize: mealController.newMeal.unitMeasure == 'szt.' ?
                                                          30 : 15
                                                      ),),
                                                      onTap: () {
                                                        mealController.newMeal.unitMeasure = 'szt.';
                                                        mealController.refreshNewMealModel();
                                                      },
                                                    ),
                                                    GestureDetector(child: Text('litr', style: TextStyle(
                                                        fontSize: mealController.newMeal.unitMeasure == 'ltr.' ?
                                                        30 : 15
                                                    ),),
                                                      onTap: () {
                                                        mealController.newMeal.unitMeasure = 'ltr.';
                                                        mealController.refreshNewMealModel();
                                                      },
                                                    ),
                                                    GestureDetector(child: Text('porcja', style: TextStyle(
                                                        fontSize: mealController.newMeal.unitMeasure == 'prc.' ?
                                                        30 : 15
                                                    ),),
                                                      onTap: () {
                                                        mealController.newMeal.unitMeasure = 'prc.';
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
                    )
                        :
                    const SizedBox(),
                    const SizedBox(height: 30.0,),
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
                            title: const Text('Wege'),
                              value: mealController.veganCheckBox.value, onChanged: (newValue){
                              mealController.veganCheckBox.value = newValue!;
                              if(mealController.veganCheckBox.value == false && mealController.newMeal.mealVariants.contains('vegan') ){
                                mealController.newMeal.mealVariants.remove('vegan');
                              }else{
                                mealController.newMeal.mealVariants.add('vegan');
                              }
                          }),
                        ),
                        SizedBox(
                          width: 140,
                          height: 40,
                          child: CheckboxListTile(
                            activeColor: Colors.black,
                              title: const Text('Mięso'),
                              value: mealController.meatCheckBox.value, onChanged: (newValue){
                              mealController.meatCheckBox.value = newValue!;
                              if(mealController.meatCheckBox.value == false && mealController.newMeal.mealVariants.contains('meat') ){
                                mealController.newMeal.mealVariants.remove('meat');
                              }else{
                                mealController.newMeal.mealVariants.add('meat');
                              }
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
                        textAlignment: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        placeholder: '...szczegółowy opis...',
                        key: const Key('MealDescription'),
                        controller: mealController,
                        suffixText: '',
                      ),
                    ),
                    const SizedBox(height: 30.0,),
                    const Text('Dodaj zdjęcie produktu'),
                    const SizedBox(height: 15.0,),
                    CupertinoButton(
                      borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black,
                        child: const Text('Dodaj'), onPressed: (){}),
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
}
