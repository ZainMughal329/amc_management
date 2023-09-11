
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'index.dart';
import 'package:amc_management/model/dispatch_model/dispatch_model.dart';
class dispatchController extends GetxController{

  final state = dispatchState();
  dispatchController();
  RxString imagePath =''.obs;
  Future getImage()async{
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      imagePath.value  = image.path.toString();
    }
  }


  Future<void> DispatchModelFile(String name , String image,String date, String recievedBy,String notificationTo) async{
    try{
      await state.ref.add({
        'Image':image,
        'Name': name,
        'RecievedBy':recievedBy,
        'NotificationTo':notificationTo,
        'Date': date,
      }).then((value) {
        Get.snackbar('Sucess', 'File Uploaded');
        Get.back();
      }).onError((error, stackTrace) {
        Get.snackbar('Error', error.toString());

      });
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }
  void storeData(
      DispatchModel dispatch , BuildContext context , String image , String name , String recievedBy,
      String notificationTo , String date
      )async{
    DispatchModelFile(name, image, date, recievedBy, notificationTo);
  }

}