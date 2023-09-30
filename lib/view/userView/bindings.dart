


import 'package:get/get.dart';

import 'index.dart';

class userViewBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<userViewController>(() =>userViewController());
  }



}