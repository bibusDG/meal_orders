import 'package:get/get.dart';
import 'package:meal_orders/models/user_model.dart';

class UserController extends GetxController {

  RxString repeatedPassword = ''.obs;
  RxBool userLoggedIn = false.obs;

  final _user = UserModel(
      userName: '',
      userSurName: '',
      userLogin: '',
      userPassword: '',
      userBasket: [],
      userListOfOrders: [],
      // userLoggedIn: false,
      isAdmin: false
  ).obs;

  UserModel get user => _user.value;


  @override
  void onInit() {
    super.onInit();
    var user = UserModel(
        userName: '',
        userSurName: '',
        userLogin: '',
        userPassword: '',
        userBasket: [],
        userListOfOrders: [],
        // userLoggedIn: false,
        isAdmin: false,
    );
    _user(user);
  }

  void updateUserController(UserModel user){
    _user(user);
    _user.refresh();
  }


  void refreshUserModel(){
    _user.refresh();
  }
}