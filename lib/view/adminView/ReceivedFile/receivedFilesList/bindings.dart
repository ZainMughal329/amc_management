 import 'package:get/get.dart';

import 'controller.dart';

class receivedFilesListBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<receivedFilesListController>(() => receivedFilesListController());
  }

}