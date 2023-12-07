import 'package:get/get.dart';

import 'state.dart';

class receivedFilesListController extends GetxController{
  final state =receivedFilesState();

  Future<void> deleteFile(String id)async{
    try{
      await state.ref.doc(id).delete().then((value){
        print('File Deleted');
      }).onError((error, stackTrace){
        Get.snackbar('Error', error.toString());
      });
    }catch(e){
      Get.snackbar('error', e.toString());
    }

  }
}