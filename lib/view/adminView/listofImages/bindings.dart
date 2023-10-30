import 'package:amc_management/view/adminView/listofImages/controller.dart';
import 'package:get/get.dart';

class ListOfFileBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ListOfFileController>(() => ListOfFileController());
  }

}