import 'package:get/get.dart';
import 'package:meal_orders/models/meal_model.dart';

class MealController extends GetxController{

  // final mealNameTextController = TextEditingController();

  RxBool veganCheckBox = false.obs;
  RxBool meatCheckBox = false.obs;
  RxString chosenVariant = 'vegan'.obs;

  final _newMeal = MealModel(
      unitMeasure: '',
      mealName: '',
      mealPicture: '',
      mealDescription: '',
      mealPrice: '',
      mealAvailability: false,
      mealContent: [],
      mealVariants: [],
      categoryName: '',
      categoryPicture: '').obs;
  MealModel get newMeal => _newMeal.value;

  @override
  void onInit(){
    super.onInit();
    var newMeal =  MealModel(
        unitMeasure: 'sztuka',
        mealName: '',
        mealPicture: '',
        mealDescription: '',
        mealPrice: '',
        mealAvailability: false,
        mealContent: [],
        mealVariants: [],
        categoryName: '...kategoria..',
        categoryPicture: '');
    _newMeal(newMeal);
  }

  void refreshNewMealModel(){
    _newMeal.refresh();
  }

}