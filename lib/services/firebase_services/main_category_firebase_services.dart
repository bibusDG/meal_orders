import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meal_orders/models/main_category_model.dart';

class MainCategoryFirebaseServices{

  addNewMainCategory(MainCategoryModel newCategory){
    try{
      FirebaseFirestore.instance
          .collection('Companies').doc('martaSudol')
          .collection('mainCategories').add(newCategory.toJson());
    }
    catch(error){print(error);}
  }

}