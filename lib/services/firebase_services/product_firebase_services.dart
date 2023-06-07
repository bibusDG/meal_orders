import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_orders/models/meal_model.dart';

class ProductFirebaseServices{

  addProduct(MealModel newMeal){
    try{
      FirebaseFirestore.instance
          .collection('Companies')
          .doc('martaSudol')
          .collection('product').add(newMeal.toJson());
    }catch(error){}
  }
  
  fetchProducts(String? productCategory) async{
    var products = await FirebaseFirestore.instance
        .collection('Companies')
        .doc('martaSudol')
        .collection('product').where('categoryName', isEqualTo: productCategory).get();
    return products;
  }

}