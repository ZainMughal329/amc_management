
import 'package:amc_management/view/home/sendFile/controller.dart';
import 'package:get/get.dart';

class sendFileBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<sendFileController>(() => sendFileController());
  }

}