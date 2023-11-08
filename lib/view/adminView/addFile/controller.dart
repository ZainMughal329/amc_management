import 'dart:io';

import 'package:amc_management/res/components/SessionViewComponents/custom_tetxField.dart';
import 'package:amc_management/view/adminView/addFile/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/addFile_model/addFile_model.dart';
import '../../../res/colors.dart';

class addFileController extends GetxController with GetSingleTickerProviderStateMixin{
  final state = addFileState();
  late TabController tabController;
  addFileController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.dateController.dispose();
    state.filenoController.dispose();
    state.fromController.dispose();
    state.nameController.dispose();
    state.detailFocusNode.dispose();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    // for image list
    getImageUrls().then((urls) =>{
      state.imageUrls=urls
    });
  }
  void setLoading(bool value){
    state.loading.value = value;
  }
  final picker =ImagePicker();
  XFile? _image;
  XFile? get image=>_image;
  List<String> images = [];
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();





  Future pickCameraImage(BuildContext context)async{
    final image = await picker.pickImage(source: ImageSource.camera,imageQuality: 100);
    if(image!=null){
      _image = XFile(image.path);
      update();
    }
  }
  Future pickGalleryImage(BuildContext context)async{

    final image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
    if(image!=null){
      _image = XFile(image.path);
      update();
    }
  }

  Future uploadimageonDatabase (String timeStamp) async{
    firebase_storage.Reference storageRef =firebase_storage.FirebaseStorage.instance.ref('/addFile'+timeStamp);
    firebase_storage.UploadTask uploadTask =storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final imageUrl = await storageRef.getDownloadURL();
    state.ref.doc(timeStamp).update({
      'image': imageUrl,
    }).then((value){
      print('File uploaded and stored');
    });

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
  Future<void> addFileOnFirebase(String detail,String timeStamp, String name,String dept,String image,String date,String fileNum,String from,)async{
     setLoading(true);
    try{
      await state.ref.doc(timeStamp).set({
        'Detail':detail,
        'Dept':dept,
        'Name':name,
        'From':from,
        'FileNum':fileNum,
        'Date':date,
        // 'Id':FileId
      }).then((value) {
        setLoading(false);
        Get.snackbar('Success', 'File Added');
        // Get.back();
      }).onError((error, stackTrace) {
        setLoading(false);
        Get.snackbar('Error', error.toString());
      });
    }catch(e){
      Get.snackbar('Error',e.toString());
    }
  }
  void storeData(
      String detail,
      String timeStamp,
  AddFileModel addFile,
      BuildContext context,String name ,
      String dept,
      String from,String image,String fileNum,String date,
      )async{
    setLoading(true);
    addFileOnFirebase(detail,timeStamp,name,dept, image, date, fileNum, from).then((value){
      uploadimageonDatabase(timeStamp);
      setLoading(false);
      clearDateFromScreen();
    }).onError((error, stackTrace){
      setLoading(false);
      Get.snackbar('Error', error.toString());    });
  }
  getDateFromUser(BuildContext context)async{
    DateTime? pickerDate= await  showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1978),
        lastDate: DateTime(2099));
    if(pickerDate!=null){
      state.selectedDate=pickerDate;
      update();
    }else{
      print('select a date ');
    }
  }
  clearDateFromScreen(){
    state.dateController.clear();
    state.fromController.clear();
    state.nameController.clear();
    state.filenoController.clear();
    state.deptName.value="Select";
    state.detailController.clear();
  }
  Stream<DocumentSnapshot<Map<String,dynamic>>> getFIleData(){
    return state.ref.doc(state.auth.currentUser!.uid.toString()).snapshots();
  }


//   here we create function to vaLidate THE FORM

  void validateForm() {
    state.isFormValid.value = state.nameController.text.isNotEmpty &&
       state.dateController.text.isNotEmpty &&
        state.filenoController.text.isNotEmpty &&
        state.fromController.text.isNotEmpty &&
        state.detailController.text.isNotEmpty &&
        state.deptName.value.isNotEmpty;
  }


  Future
  uploadimagelistonDatabase (int imageId, String docId , String timeStamp,var imagePath) async{
    final imageUrl;

    try{
      firebase_storage.Reference storageRef =firebase_storage.FirebaseStorage.instance.ref('/addFile'+timeStamp);
      firebase_storage.UploadTask uploadTask =storageRef.putFile(File(imagePath).absolute);
      await Future.value(uploadTask);
      imageUrl = await storageRef.getDownloadURL();
      // List<String> imageUrls = imageUrl;
      print('img 12'+imageUrl.toString());
      print('id Is : ' + documentId);
      await state.ref.doc(documentId).update(
        {
          'images' : FieldValue.arrayUnion([imageUrl]),
          // imageId.toString() : imageUrl,
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

  Future<void> addFileDataOnFirebase (String id,
      String name,
      final DateTime date,
      String fileNo ,
      String deptName,
      String recieverName,
      String details) async{
    try{
      print('inside try');
      await state.ref.doc(id).set(AddFileModel(id: id,
          images: [],name: name, dept: deptName,

          date:date,

          from: recieverName, filenum: fileNo,
          detail: details
      ).toJson()).then((value){
        print('inside then');
      }).onError((error, stackTrace){
        print("Error"+error.toString());
      });


    }catch(e){

    }
  }
//   here we manage the section of update the file data

  Future<void> showFileNameDialogAlert(BuildContext context,String filename){
    //this line 104 code mean jo user ka already name ho ga wo show ho
    state.nameController.text=filename;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title:Center(child: Text('update filename')) ,
        content: SingleChildScrollView(
          child: Column(
            children: [
              ReuseField(
                  myController:state.nameController,
                  focusNode: state.nameFocusNode,
                  lableText: 'Enter your Filename',
                  onFiledSubmittedValue: (value){
                  },
                  keyboardType: TextInputType.emailAddress,
                  obsecureText: false,
                  onvalidator: (value){
                  }

              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('cancel',style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.warningColor),)),
          TextButton(onPressed: (){
            //this  code will update the name in database
            state.ref.doc(state.auth.currentUser!.uid.toString()).update({
              'Name':state.nameController.text.toString()
            }).then((value){
              state.nameController.clear();
            });

            Navigator.pop(context);
          }, child: Text('ok',style: Theme.of(context).textTheme.subtitle2,))
        ],
      );

    });

  }


  Future<void> showFileNumDialogAlert(BuildContext context,String filenum){
    //this line 104 code mean jo user ka already name ho ga wo show ho
    state.filenoController.text=filenum;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title:Center(child: Text('update username')) ,
        content: SingleChildScrollView(
          child: Column(
            children: [
              ReuseField(
                  myController:state.filenoController,
                  focusNode: state.filenoFocusNode,
                  lableText: 'Enter your FileNum',
                  onFiledSubmittedValue: (value){
                  },
                  keyboardType: TextInputType.emailAddress,
                  obsecureText: false,
                  onvalidator: (value){
                  }

              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('cancel',style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.warningColor),)),
          TextButton(onPressed: (){
            //this  code will update the name in database
            state.ref.doc(state.auth.currentUser!.uid.toString()).update({
              'FileNum':state.filenoController.text.toString()
            }).then((value){
              state.filenoController.clear();
            });

            Navigator.pop(context);
          }, child: Text('ok',style: Theme.of(context).textTheme.subtitle2,))
        ],
      );

    });

  }


  Future<List<String>> getImageUrls() async {
    final QuerySnapshot querySnapshot = await state.ref.get();

    final List<String> imageUrls = [];
    querySnapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      if(data.containsKey('imageUrl'))
      {
        final imageUrl = data['images']; // Assuming 'imageUrl' is the field name where you store image URLs.
        imageUrls.add(imageUrl);
      }
    });

    return imageUrls;
  }


}





