import 'package:get/get.dart';
import 'index.dart';
class profileBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<profileController>(() => profileController());
  }


}