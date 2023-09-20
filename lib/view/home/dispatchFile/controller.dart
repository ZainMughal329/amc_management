import 'package:amc_management/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'index.dart';
import 'package:amc_management/model/dispatch_model/dispatch_model.dart';

class dispatchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final state = dispatchState();
  late TabController tabController;

  dispatchController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.nameController.dispose();
    // state.dateController.dispose();
    state.notificationToController.dispose();
    state.recievedByController.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    // state.selectedDate;
  }

  RxString imagePath = ''.obs;

  Future pickCameraImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }

  Future pickGalleryImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }

  void pickImage(context) {
    Get.dialog(AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                pickCameraImage(context);
                Get.back();
              },
              title: Text('Camera'),
              leading: Icon(
                Icons.camera,
                color: AppColors.primaryIconColor,
              ),
            ),
            ListTile(
              onTap: () {
                pickGalleryImage(context);
                Get.back();
              },
              title: Text('Gallery'),
              leading: Icon(
                Icons.image,
                color: AppColors.primaryIconColor,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> DispatchModelFile(String name, String image, String date,
      String recievedBy, String notificationTo) async {
    try {
      await state.ref.add({
        'Image': image,
        'Name': name,
        'RecievedBy': recievedBy,
        'NotificationTo': notificationTo,
        'Date': date,
      }).then((value) {
        Get.snackbar('Sucess', 'File Uploaded');
        Get.back();
      }).onError((error, stackTrace) {
        Get.snackbar('Error', error.toString());
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  void storeData(
      DispatchModel dispatch,
      BuildContext context,
      String image,
      String name,
      String recievedBy,
      String notificationTo,
      String date) async {
    DispatchModelFile(name, image, date, recievedBy, notificationTo)
        .then((value) {
          clearDateFromScreen();
    });
  }
  clearDateFromScreen(){
    state.dateController.clear();
    state.recievedByController.clear();
    state.nameController.clear();
    state.notificationToController.clear();
    imagePath.value="";
  }

  getDateFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1978),
        lastDate: DateTime(2099));
    if (pickerDate != null) {
      state.selectedDate = pickerDate;
      update();
    } else {
      print('select a date ');
    }
  }
}
