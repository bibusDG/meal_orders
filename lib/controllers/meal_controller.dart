import 'package:get/get.dart';
import 'package:meal_orders/models/meal_model.dart';

class MealController extends GetxController{

  // final mealNameTextController = TextEditingController();

  RxBool veganCheckBox = false.obs;
  RxBool meatCheckBox = false.obs;

  final _newMeal = MealModel(
      unitMeasure: '',
      mealName: '',
      mealPicture: '',
      mealDescription: '',
      mealPrice: '',
      mealAvailability: false,
      mealContent: [],
      mealVariants: []).obs;
  MealModel get newMeal => _newMeal.value;

  @override
  void onInit(){
    super.onInit();
    var newMeal =  MealModel(
        unitMeasure: 'szt.',
        mealName: '',
        mealPicture: '',
        mealDescription: '',
        mealPrice: '',
        mealAvailability: false,
        mealContent: [],
        mealVariants: []);
    _newMeal(newMeal);
  }

  void refreshNewMealModel(){
    _newMeal.refresh();
  }

}