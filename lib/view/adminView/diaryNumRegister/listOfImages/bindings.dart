


import 'package:amc_management/view/adminView/diaryNumRegister/listOfImages/controller.dart';
import 'package:get/get.dart';

class listofImagesBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<listOfImagesController>(() => listOfImagesController());
  }

}