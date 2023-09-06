


import 'package:get/get.dart';

import 'controller.dart';

class SignupBindings implements Bindings{
  @override
  void dependencies() {

    // TODO: implement dependencies
    Get.lazyPut<SignupController>(() =>SignupController());
  }
}