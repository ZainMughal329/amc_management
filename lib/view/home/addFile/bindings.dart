

import 'package:amc_management/view/home/addFile/controller.dart';
import 'package:get/get.dart';

class addFileBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<addFileController>(() =>addFileController());
  }

}