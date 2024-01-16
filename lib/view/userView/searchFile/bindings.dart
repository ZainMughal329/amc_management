

import 'package:get/get.dart';

import 'contoller.dart';

class userSearchBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<userSerachController>(() => userSerachController());
    // TODO: implement dependencies
  }

}