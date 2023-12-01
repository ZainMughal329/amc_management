

import 'dart:io';

import 'package:amc_management/view/adminView/diaryNumRegister/listOfImages/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:get/get.dart';

import '../../../../utils/routes/routes_name.dart';
import '../dataUplaodForm/state.dart';

class listOfImagesController extends GetxController{
  final state = listOfImagesState();
  final uploadFormState = dataUploadState();
  List<String> images = [];
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // for image list
    getImageUrls().then((urls) => {state.imageUrls = urls});
  }

  setFetchLoading(bool val) {
    state.fetchedLoading.value = val;
  }
  void setLoading(value) {
    state.loading.value = value;
  }

  Future<List<String>> getImageUrls() async {
    final QuerySnapshot querySnapshot = await state.ref.get();

    final List<String> imageUrls = [];
    querySnapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('imageUrl')) {
        final imageUrl = data[
        'images']; // Assuming 'imageUrl' is the field name where you store image URLs.
        imageUrls.add(imageUrl);
      }
    });

    return imageUrls;
  }

  Future<List<String>> fetchImageUrls(String docId) async {
    setFetchLoading(true);
    final snapshot = await FirebaseFirestore.instance
        .collection('diaryNumberRegister')
        .doc(docId)
        .get();

    final List<String> imageUrls =
    List<String>.from(snapshot.data()!['images']);
    return imageUrls;
  }


  // Future<void> uploadimagelistonDatabase(
  //     int imageId, String docId, String timeStamp, var imagePath) async {
  //   final imageUrl;
  //   try {
  //     setLoading(true);
  //     firebase_storage.Reference storageRef =
  //     firebase_storage.FirebaseStorage.instance.ref('/diaryNumberRegister' + timeStamp);
  //     firebase_storage.UploadTask uploadTask =
  //     storageRef.putFile(File(imagePath).absolute);
  //     await Future.value(uploadTask);
  //     imageUrl = await storageRef.getDownloadURL();
  //     // List<String> imageUrls = imageUrl;
  //     print('img 12' + imageUrl.toString());
  //     print('id Is : ' + documentId);
  //     await state.ref.doc(documentId).update(
  //       {
  //         'images': FieldValue.arrayUnion([imageUrl]),
  //         // imageId.toString() : imageUrl,
  //       },
  //
  //       // SetOptions(merge: false),
  //     ).then((value) {
  //       print("image no is" + imageId.toString());
  //       print("image url is" + imageUrl.toString());
  //       clearDateFromScreen();
  //       // images = [];
  //       Get.toNamed(RouteNames.homeview);
  //
  //       setLoading(false);
  //
  //     }).onError((error, stackTrace) {
  //       print(error.toString());
  //       setLoading(false);
  //
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     setLoading(false);
  //
  //   }
  // }
  //
  // clearDateFromScreen() {
  //   uploadFormState.serialNumController.clear();
  //   uploadFormState.receiverNameController.clear();
  //   uploadFormState.fileSubjectController.clear();
  //   uploadFormState.deptName.value = "Select";
  //   uploadFormState.fileDispatchDateController.clear();
  //   uploadFormState.senderAddressController.clear();
  //   uploadFormState.receiverNameController.clear();
  //   state.images=[];
  // }
}