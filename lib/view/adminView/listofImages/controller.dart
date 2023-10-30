import 'dart:io';

import 'package:amc_management/view/adminView/listofImages/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ListOfFileController extends GetxController{


  final picker =ImagePicker();
  XFile? _image;
  XFile? get image=>_image;
  List<String> images = [];
  final state = ListOfFileState();



  Future pickCameraImage(BuildContext context)async{
    final image = await picker.pickImage(source: ImageSource.camera,imageQuality: 100);
    if(image!=null){
      _image = XFile(image.path);
      images.add(image.path);
      update();
    }
  }
  Future pickGalleryImage(BuildContext context)async{

    final image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
    if(image!=null){
      _image = XFile(image.path);
      images.add(image.path);
      update();
    }
  }


  Future uploadimageonDatabase (String timeStamp,var imagePath) async{
    try{
      firebase_storage.Reference storageRef =firebase_storage.FirebaseStorage.instance.ref('/addFile'+timeStamp);
      firebase_storage.UploadTask uploadTask =storageRef.putFile(File(imagePath).absolute);
      await Future.value(uploadTask);
      final imageUrl = await storageRef.getDownloadURL();
      print("Downloaded Image Url is "+ imageUrl.toString());
      // state.ref.doc(timeStamp).update({
      //   'image': imageUrl,
      // }).then((value){
      //   print('File uploaded and stored');
      // });
    }catch(e){
      print(e.toString());
    }

  }


}