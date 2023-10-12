import 'package:amc_management/view/home/addFile/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
  RxString imagePath =''.obs;
  // final fileId=DateTime.now().toString().obs;
  Future pickCameraImage(BuildContext context)async{
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      imagePath.value  = image.path.toString();
    }
  }
  Future pickGalleryImage(BuildContext context)async{
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      imagePath.value=image.path.toString();
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
  Future<void> addFileOnFirebase(String name,String image,String date,String fileNum,String from,)async{
    try{
      await state.ref.add({
        'Image':image,
        'Name':name,
        'From':from,
        'FileNum':fileNum,
        'Date':date,
        // 'Id':FileId
      }).then((value) {
        Get.snackbar('Sucess', 'File Added');
        // Get.back();
      }).onError((error, stackTrace) {
        Get.snackbar('Error', error.toString());
      });
    }catch(e){
      Get.snackbar('Error',e.toString());
    }
  }
  void storeData(
  AddFileModel addFile,
      BuildContext context,String name ,String from,String image,String fileNum,String date,
      )async{
    addFileOnFirebase(name, image, date, fileNum, from).then((value){
      clearDateFromScreen();
    });
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
    imagePath.value="";
  }
  Stream<DocumentSnapshot<Map<String,dynamic>>> getFIleData(){
    return state.ref.doc(state.auth.currentUser!.uid.toString()).snapshots();
  }
}





