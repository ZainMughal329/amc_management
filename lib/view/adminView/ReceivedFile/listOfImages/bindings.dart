

import 'package:get/get.dart';

import 'controller.dart';

class listOfImagesBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<listOfImagesController>(() => listOfImagesController());
  }
  }