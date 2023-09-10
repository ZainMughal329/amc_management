



import 'package:amc_management/view/home/addFile/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/addFile_model/addFile_model.dart';

class addFileController extends GetxController{
  final state = addFileState();
  addFileController();
  RxString imagePath =''.obs;
  Future getImage()async{
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      imagePath.value  = image.path.toString();
    }
  }
  Future<void> addFileOnFirebase(String name,String image,String date,String fileNum,String from)async{
    try{
      await state.ref.add({
        'Image':image,
        'Name':name,
        'From':from,
        'FileNum':fileNum,
        'Date':date
      }).then((value) {
        Get.snackbar('Sucess', 'File Added');
        Get.back();
      }).onError((error, stackTrace) {
        Get.snackbar('Error', error.toString());
      });
    }catch(e){
      Get.snackbar('Error',e.toString());
    }
  }
  void storeData(
  AddFileModel addFile,
      BuildContext context,String name ,String from,String image,String fileNum,String date
      )async{
    addFileOnFirebase(name, image, date, fileNum, from);
  }
}