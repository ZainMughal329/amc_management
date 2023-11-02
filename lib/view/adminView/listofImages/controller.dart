import 'dart:io';

import 'package:amc_management/model/addFile_model/addFile_model.dart';
import 'package:amc_management/view/adminView/listofImages/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../res/colors.dart';

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
  void pickImage(context){
    Get.dialog(AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          children: [
            ListTile(
              onTap: (){
                pickCameraImage(context);
                Get.back();
              },
              title: Text('Camera'),
              leading: Icon(Icons.camera,color: AppColors.lightActiveIconColor,),
            ),
            ListTile(
              onTap: (){
                pickGalleryImage(context);
                Get.back();
              },
              title: Text('Gallery'),
              leading: Icon(Icons.image,color: AppColors.lightActiveIconColor,),
            ),
          ],
        ),
      ),
    ));
  }




  Future
  uploadimageonDatabase (int imageId, String docId , String timeStamp,var imagePath) async{
    final imageUrl;

    try{
      firebase_storage.Reference storageRef =firebase_storage.FirebaseStorage.instance.ref('/addFile'+timeStamp);
      firebase_storage.UploadTask uploadTask =storageRef.putFile(File(imagePath).absolute);
      await Future.value(uploadTask);
      imageUrl = await storageRef.getDownloadURL();
      // List<String> imageUrls = imageUrl;
      print('img 12'+imageUrl.toString());
      await state.ref.doc(docId).update(
        {
          'images' : FieldValue.arrayUnion([imageUrl]),
        },

        // SetOptions(merge: false),

      ).then((value){
        print("image no is" + imageId.toString());
        print("image url is" + imageUrl.toString());
      }).onError((error, stackTrace){
        print(error.toString());
      });





    }catch(e){
      print(e.toString());
    }

  }

  Future<void> addFileDataOnFirebase (String id,String name, String date, String fileNo , String deptName, String recieverName, String details) async{
    try{
      print('inside try');
      await state.ref.doc(id).set(AddFileModel(images: [
        '0' : 0,

      ],name: name, dept: deptName, date: date, from: recieverName, filenum: fileNo,
      detail: details
      ).toJson()).then((value){
        print('inside then');

      }).onError((error, stackTrace){
        print("Error"+error.toString());
      });


    }catch(e){

    }
  }



}


