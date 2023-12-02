import 'package:amc_management/view/adminView/diaryNumRegister/allFileDetails/controller.dart';
import 'package:get/get.dart';

class diaryFilesDetailBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<diaryFilesDetailController>(() => diaryFilesDetailController());
  }

}