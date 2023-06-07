import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_orders/models/main_category_model.dart';

class MainCategoryFirebaseServices{

  addNewMainCategory(MainCategoryModel newCategory){
    try{
      FirebaseFirestore.instance
          .collection('Companies').doc('martaSudol')
          .collection('mainCategories').add(newCategory.toJson());
    }
    catch(error){}
  }

  streamMainCategories() {

    var mainCategories = FirebaseFirestore.instance
    .collection('Companies')
    .doc('martaSudol')
    .collection('mainCategories').snapshots();

    return mainCategories;

  }

  // getMainCategories(){
  //   var mainCategories = FirebaseFirestore.instance
  //       .collection('Companies')
  //       .doc('martaSudol')
  //       .collection('mainCategories').get();
  //   return mainCategories;
  // }

}