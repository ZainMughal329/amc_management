

import 'package:amc_management/res/components/custom_tetxField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/services/session_controller.dart';
import '../../../res/colors.dart';
import 'index.dart';
class profileController extends GetxController{
  final state = profileState();
  profileController();
Stream<DocumentSnapshot<Map<String,dynamic>>> getUserData(){
return FirebaseFirestore.instance.collection('users').doc(state.auth.currentUser!.uid.toString()).snapshots();
}

  XFile? _image;
  XFile? get image=>_image;
  Future pickGalleryImage (BuildContext context) async{
    final pickedfile =await state.picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
    if(pickedfile!=null){
      _image=XFile(pickedfile.path);
      uploadimageonDatabase(context);
    }
  }

  Future pickCameraImage (BuildContext context) async{
    final pickedfile =await state.picker.pickImage(source: ImageSource.camera,imageQuality: 100);
    if(pickedfile!=null){
      _image=XFile(pickedfile.path);
      uploadimageonDatabase(context);
    }

  }
  void pickImage(context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content:Container(
          height: 120,
          child: Column(
            //to access the camera must add the dependencies that were added in android manifest file
            children: [
              ListTile(
                onTap: (){
                  pickCameraImage(context);
                  Navigator.pop(context);
                },
                title: Text('Camera'),
                leading: Icon(Icons.camera,color: AppColors.primaryIconColor,),
              ),
              ListTile(
                onTap: (){
                  pickGalleryImage(context);
                  Navigator.pop(context);
                },
                title: Text('Gallery'),
                leading: Icon(Icons.image,color: AppColors.primaryIconColor,),
              ),
            ],
          ),
        ),
      );

    });

  }

  //here we upload pics on database and the reterive it
  void uploadimageonDatabase (BuildContext context) async{
    // state.loading.value=true;
    firebase_storage.Reference storageRef =firebase_storage.FirebaseStorage.instance.ref('/profileimage'+state.auth.currentUser!.uid.toString());
    firebase_storage.UploadTask uploadTask =storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    state.ref.collection('users').doc(state.auth.currentUser!.uid.toString()).update
      ({
      'profile':newUrl.toString()
    }).then((value){
      // state.loading.value;
      // Utils.toatMesage('Profile update');
      _image=null;
    }).onError((error, stackTrace){
      state.loading.value;
      Get.snackbar('Error', error.toString());
    });
  }

  //  here we done work to update the uer other info such a name or number etc

  Future<void> showUserNameDialogAlert(BuildContext context,String name){
    //this line 104 code mean jo user ka already name ho ga wo show ho
    state.namecontroller.text=name;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title:Center(child: Text('update username')) ,
        content: SingleChildScrollView(
          child: Column(
            children: [
              ReuseField(
                  myController:state.namecontroller,
                  focusNode: state.namefocousNode,
                  // onFiledSubmittedValue: (value){
                  // },
                  keyboardType: TextInputType.emailAddress,
                  obsecureText: false,
                  hint:'Enter your name',
                  onvalidator: (value){
                  }

              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('cancel',style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),)),
          TextButton(onPressed: (){
            //this  code will update the name in database
            state.ref.collection('users').doc(state.auth.currentUser!.uid.toString()).update({
              'UserName':state.namecontroller.text.toString()
            }).then((value){
              state.namecontroller.clear();
            });

            Navigator.pop(context);
          }, child: Text('ok',style: Theme.of(context).textTheme.subtitle2,))
        ],
      );

    });

  }


  Future<void> showUserEmailDialogAlert(BuildContext context,String email){
    //this line 104 code mean jo user ka already email ho ga wo show ho
   state.emailcontroller.text=email;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title:Center(child: Text('update email')) ,
        content: SingleChildScrollView(
          child: Column(
            children: [
              ReuseField(myController:state. emailcontroller,
                  focusNode:state. emailfocousNode,
                  // onFiledSubmittedValue: (value){
                  //
                  // },
                  keyboardType: TextInputType.emailAddress,
                  obsecureText: false,
                  hint:'Enter your email',
                  onvalidator: (value){

                  })


            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('cancel',style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),)),
          TextButton(onPressed: (){
            //this  code will update the name in database
            state.ref.collection('users').doc(state.auth.currentUser!.uid.toString()).update({
              'Email':state.emailcontroller.text.toString()
            }).then((value){
             state.emailcontroller.clear();
            });
            Navigator.pop(context);
          }, child: Text('ok',style: Theme.of(context).textTheme.subtitle2,))
        ],
      );
    });
  }
}