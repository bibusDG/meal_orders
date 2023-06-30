import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_orders/models/order_model.dart';
import 'package:meal_orders/services/firebase_services/order_firebase_services.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ActualOrdersPage extends StatelessWidget {
  const ActualOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 360,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aktualne zamówienia'),
        ),
        body: StreamBuilder(
            stream: OrderFirebaseServices().streamAllOrders(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot, ){
              if(snapshot.hasData){
                if(snapshot.data.docs.length > 0){
                  return ListView.builder(
                    itemExtent: 180,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index){
                    OrderModel order = OrderModel.fromJson(Map<String, dynamic>.from(snapshot.data.docs[index].data()));
                    return Card(
                      margin: const EdgeInsets.only(top: 20.0, left: 30, right: 30.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      child: Text(order.orderStatus),
                    );
                  });
                }else{
                  return const Center(child: Text('Brak danych'),);
                }
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            })
      ),
    );
  }
}
/// TODO order status update
/// TODO actual orders and historical orders (think about when pass order to historical)