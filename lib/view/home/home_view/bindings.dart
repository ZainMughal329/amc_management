


import 'package:get/get.dart';
import 'index.dart';
class HomeBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController());
  }
}