

import 'package:get/get.dart';

import 'controller.dart';


class dispatchBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<dispatchController>(() => dispatchController());
  }

}