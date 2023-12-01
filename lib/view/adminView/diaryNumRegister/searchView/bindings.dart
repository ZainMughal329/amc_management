
import 'package:get/get.dart';

import 'controller.dart';

class diarySearchBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<diaryFilesSearchController>(() => diaryFilesSearchController());
  }

}