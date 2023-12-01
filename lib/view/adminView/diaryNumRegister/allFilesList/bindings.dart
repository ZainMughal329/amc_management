

import 'package:amc_management/view/adminView/diaryNumRegister/allFilesList/controller.dart';
import 'package:get/get.dart';

class allFilesBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<allFilesController>(() => allFilesController());
  }

}