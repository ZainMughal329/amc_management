

import 'package:get/get.dart';

import 'index.dart';

class Forgotbindinsg implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ForgotController>(() => ForgotController());
  }
}