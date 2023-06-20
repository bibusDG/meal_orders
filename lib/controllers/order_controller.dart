import 'package:get/get.dart';
import 'package:meal_orders/controllers/user_controller.dart';
import 'package:meal_orders/models/meal_model.dart';
import 'package:meal_orders/models/order_model.dart';

class OrderController extends GetxController{

  final _order = OrderModel(
      orderNumber: 0,
      orderDate: '',
      orderTotalPrice: 0,
      orderStatus: '',
      articlesList: [],
      userName: '',
      userSurname: '',
      userLogin: '').obs;

  OrderModel get newOrder => _order.value;

  @override
  void onInit(){
    UserController _user = Get.find();
    super.onInit();
    var newOrder = OrderModel(
        orderNumber: 0,
        orderDate: "",
        orderTotalPrice: 0,
        orderStatus: "Oczekuje na realizację",
        articlesList: [],
        userName: _user.user.userName,
        userSurname: _user.user.userSurName,
        userLogin: _user.user.userLogin);

    _order(newOrder);
  }

  refreshOrderModel(){
    _order.refresh();
  }

}