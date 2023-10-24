import 'package:get/get.dart';

import 'index.dart';

class userBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<userController>(() => userController());
  }
}