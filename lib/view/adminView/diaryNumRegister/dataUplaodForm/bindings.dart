import 'package:amc_management/view/adminView/diaryNumRegister/dataUplaodForm/controller.dart';
import 'package:get/get.dart';

class dataUplaodBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<dataUplaodController>(() => dataUplaodController());
    // TODO: implement dependencies
  }

}