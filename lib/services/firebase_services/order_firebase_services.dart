import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/order_model.dart';

class OrderFirebaseServices {

  addOrder(OrderModel order){
    try{
      FirebaseFirestore.instance
          .collection('Companies')
          .doc('martaSudol')
          .collection('orders').add(order.toJson());
    }
    catch(error){}
  }

  fetchOrdersFromUser(userLogin) async{
    try{
      var userOrders = await FirebaseFirestore.instance
          .collection('Companies')
          .doc('martaSudol')
          .collection('orders')
          .where('userLogin', isEqualTo: userLogin).get();
      return userOrders;
    }catch(error){}

  }

  streamChosenUserOrders({userLogin, sortText}){
    try{
      var chosenOrders = FirebaseFirestore.instance.collection('Companies')
          .doc('martaSudol')
          .collection('orders')
          .where('userLogin', isEqualTo: userLogin)
          .where('orderStatus', isEqualTo: sortText).snapshots();
      return chosenOrders;
    }catch(error){}
  }

  streamAllUserOrders({userLogin}){
    try{
      var allOrders = FirebaseFirestore.instance.collection('Companies')
          .doc('martaSudol')
          .collection('orders')
          .where('userLogin', isEqualTo: userLogin).snapshots();
      return allOrders;
    }catch(error){}
  }

  streamAllOrders(){
    try{
      var streamAllOrders = FirebaseFirestore.instance
          .collection('Companies')
          .doc('martaSudol')
          .collection('orders').snapshots();
      return streamAllOrders;
    }catch(error){}
  }

}