import 'package:get/get.dart';

import 'index.dart';

class SearchBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SearchBarController>(() => SearchBarController());
  }
}
