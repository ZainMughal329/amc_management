

import 'package:get/get.dart';

import 'index.dart';

class receivedFileBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<receivedFileController>(() =>receivedFileController());
  }

}