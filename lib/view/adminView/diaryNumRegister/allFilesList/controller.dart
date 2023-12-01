import 'package:amc_management/view/adminView/diaryNumRegister/allFilesList/state.dart';
import 'package:get/get.dart';

class allFilesController extends GetxController{
final state = allFilesState();
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