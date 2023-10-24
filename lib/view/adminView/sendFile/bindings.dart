
import 'package:get/get.dart';

import 'controller.dart';

class sendFileBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<sendFileController>(() => sendFileController());
  }

}