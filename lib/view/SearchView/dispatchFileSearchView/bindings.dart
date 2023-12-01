

import 'package:amc_management/view/SearchView/dispatchFileSearchView/controller.dart';
import 'package:get/get.dart';

class searchBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<dispatchSearchController>(() => dispatchSearchController());
  }

}