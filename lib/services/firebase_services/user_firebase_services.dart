import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_orders/models/user_model.dart';

class UserFirebaseServices{

  checkIfUserExist(UserModel user) async{
    var userExist = await FirebaseFirestore.instance
        .collection('Companies')
        .doc('martaSudol')
        .collection('users')
        .where('userLogin', isEqualTo: user.userLogin)
        .where('userPassword', isEqualTo: user.userPassword).get();
    if(userExist.docs.isNotEmpty){
      return true;
    }return false;
  }

  registerUser(UserModel user){
    try{
      FirebaseFirestore.instance
          .collection('Companies')
          .doc('martaSudol')
          .collection('users').add(user.toJson());
    }catch(error){}

  }

  fetchUser({userLogin, userPassword}) async{
    var user = await FirebaseFirestore.instance
        .collection('Companies')
        .doc('martaSudol')
        .collection('users')
        .where('userLogin', isEqualTo: userLogin)
        .where('userPassword', isEqualTo: userPassword).get();
    return user;
  }

}