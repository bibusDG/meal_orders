import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_orders/controllers/order_controller.dart';

import '../../models/order_model.dart';

class OrderFirebaseServices {

  addOrder(OrderModel order){
    try{
      FirebaseFirestore.instance
          .collection('Companies')
          .doc('martaSudol')
          .collection('orders').add(order.toJson());
    }
    catch(error){print(error);}
  }

}