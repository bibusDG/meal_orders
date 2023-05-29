import 'package:get/get.dart';
import 'package:meal_orders/models/main_category_model.dart';

class MainCategoryController extends GetxController{

  // final categoryNameTextController = TextEditingController();
  final _newCategory = MainCategoryModel(
      categoryName: '',
      categoryPicture: '').obs;
  MainCategoryModel get newCategory => _newCategory.value;

  @override
  void onInit(){
    super.onInit();
    var newCategory = MainCategoryModel(
        categoryName: '',
        categoryPicture: ''
    );
    _newCategory(newCategory);
  }
  refreshNewCategoryModel(){
    _newCategory.refresh();
  }
}