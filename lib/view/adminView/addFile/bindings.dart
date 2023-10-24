

import 'package:get/get.dart';

import 'index.dart';

class addFileBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<addFileController>(() =>addFileController());
  }

}