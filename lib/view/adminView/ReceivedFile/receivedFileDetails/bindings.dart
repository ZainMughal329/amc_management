
import 'package:get/get.dart';

import 'controller.dart';

class receivedFileDetailsBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<receivedFileDetailController>(() => receivedFileDetailController());
  }

}