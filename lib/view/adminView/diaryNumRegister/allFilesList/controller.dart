import 'package:amc_management/view/adminView/diaryNumRegister/allFilesList/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class allFilesController extends GetxController{
final state = allFilesState();
Future<void> deleteFile(String id)async{
  try{
    await state.ref.doc(id).delete().then((value){
      Get.snackbar('Deleted', 'SucessFully deleted',backgroundColor:Colors.white ,colorText: Colors.blueGrey.withOpacity(.8));

      print('File Deleted');
    }).onError((error, stackTrace){
      Get.snackbar('Error', error.toString(),backgroundColor:Colors.white ,colorText: Colors.blueGrey.withOpacity(.8));
    });
  }catch(e){
    Get.snackbar('error', e.toString(),backgroundColor:Colors.white ,colorText: Colors.blueGrey.withOpacity(.8));
  }

}

}