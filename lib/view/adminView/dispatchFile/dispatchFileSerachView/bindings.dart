

import 'package:get/get.dart';

import 'controller.dart';

class searchBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<dispatchSearchController>(() => dispatchSearchController());
  }

}