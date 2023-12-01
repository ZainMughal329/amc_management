


import 'package:amc_management/view/adminView/diaryNumRegister/diaryNumView/controller.dart';
import 'package:get/get.dart';

class diaryNumViewBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<diaryNumberController>(() => diaryNumberController());
  }

}