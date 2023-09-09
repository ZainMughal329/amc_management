import 'package:amc_management/view/home/users/controller.dart';
import 'package:get/get.dart';

class userBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<userController>(() => userController());
  }
}