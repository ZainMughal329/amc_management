import 'package:get/get.dart';

import 'controller.dart';


class dataUplaodBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<uploadFormController>(() => uploadFormController());
    // TODO: implement dependencies
  }

}