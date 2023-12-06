import 'dart:io';

import 'package:amc_management/res/components/SessionViewComponents/custom_tetxField.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/adminView/ReceivedFile/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../model/ReceivedFile_model/ReceivedFile_model.dart';
import '../../../res/colors.dart';
import 'components/listofImages/view.dart';
import 'package:dio/dio.dart' as dio; // Alias the dio package

class receivedFileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final state = receivedFileState();
  late TabController tabController;

  receivedFileController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.dateController.dispose();
    state.serialNumController.dispose();
    state.receivedfromController.dispose();
    state.detailFocusNode.dispose();
  }

  ReceivedFileModel? addFileModel;
  DocumentSnapshot? documentSnapshot;
  // for updation of data
  fetchDataOfFiles(String id) async {
    try{
      documentSnapshot =
      await FirebaseFirestore.instance.collection('Received Files').doc(id).get();
      if (documentSnapshot!.exists) {
        print('id' + id);

        addFileModel = ReceivedFileModel(
            id: id,
            // name: documentSnapshot!['Name'],
            // dept: documentSnapshot!['dept'],
            receivereName: documentSnapshot!['receiverName'],
            receivedAddress: documentSnapshot!['receivedAddress'],
            receivedFrom: documentSnapshot!['From'],
            SerialNum: documentSnapshot!['serialNum'],
            images: images);
        // state.nameFile.value = documentSnapshot!['Name'];
        state.serialNum.value = documentSnapshot!['serialNum'];
        state.loaded.value = true;

        // print('value of name : ' +state.nameFile.value.toString(),);
        print('value of file number : ' +state.serialNum.value.toString(),);

      } else {
        print('empty');
      }
    } catch(e){
      print('exception : ' + e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    // for image list
    getImageUrls().then((urls) => {state.imageUrls = urls});
  }

  void setLoading(value) {
    state.loading.value = value;
  }

  final picker = ImagePicker();
  XFile? _image;

  XFile? get image => _image;
  List<String> images = [];
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();

  Future pickCameraImage(BuildContext context) async {
    final image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (image != null) {
      _image = XFile(image.path);
      update();
    }
  }

  Future pickGalleryImage(BuildContext context) async {
    final image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image != null) {
      _image = XFile(image.path);
      update();
    }
  }

  Future uploadimageonDatabase(String timeStamp) async {
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref('/Received Files' + timeStamp);
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final imageUrl = await storageRef.getDownloadURL();
    state.ref.doc(timeStamp).update({
      'image': imageUrl,
    }).then((value) {
      print('File uploaded and stored');
    });
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
                color: AppColors.lightActiveIconColor,
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
                color: AppColors.lightActiveIconColor,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> uploadReceivedFileOnFirebase(

    String timeStamp,
    // String dept,
    String image,
    String date,
    String serialNum,
    String receivedfrom,
      String receivereName,
      String receivereAddress
  ) async {
    setLoading(true);
    try {
      await state.ref.doc(timeStamp).set({

        // 'Dept': dept,
        // 'Name': name,
        'receivedFrom': receivedfrom,
        'receivedAddress':receivereAddress,
        'receiverName':receivereName,
        'FileNum': serialNum,
        'Date': date,
      }).then((value) {
        setLoading(false);
        Get.snackbar('Success', 'File Added');
        // Get.back();
      }).onError((error, stackTrace) {
        setLoading(false);
        Get.snackbar('Error', error.toString());
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void storeData(
    String timeStamp,
    ReceivedFileModel addFile,
    BuildContext context,
    // String name,
    // String dept,
      String image,
      String date,
      String serialNum,
    String receivedfrom,
    String receiverAddress,
      String receivereName,
  ) async {
    setLoading(true);
    uploadReceivedFileOnFirebase( timeStamp,
        // dept,
        image, date, serialNum, receivedfrom,receiverAddress,receivereName)
        .then((value) {
      uploadimageonDatabase(timeStamp);
      setLoading(false);
      clearDateFromScreen();
    }).onError((error, stackTrace) {
      setLoading(false);
      Get.snackbar('Error', error.toString());
    });
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

  clearDateFromScreen() {
    state.dateController.clear();
    state.receivedfromController.clear();
    // state.nameController.clear();
    state.serialNumController.clear();
    // state.deptName.value = "Select";
    state.detailController.clear();
    state.receiverAddressController.clear();
    state.receiverNameController.clear();
    images=[];
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getFIleData() {
    return state.ref.doc(state.auth.currentUser!.uid.toString()).snapshots();
  }

//   here we create function to vaLidate THE FORM

  void validateForm() {
    state.isFormValid.value =
        state.dateController.text.isNotEmpty &&
        state.serialNumController.text.isNotEmpty &&
        state.receivedfromController.text.isNotEmpty &&
        state.detailController.text.isNotEmpty ;
        // state.deptName.value.isNotEmpty;
  }

  Future<void> uploadimagelistonDatabase(
      int imageId, String docId, String timeStamp, var imagePath) async {
    final imageUrl;
    try {
      setLoading(true);
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref('/Received Files' + timeStamp);
      firebase_storage.UploadTask uploadTask =
          storageRef.putFile(File(imagePath).absolute);
      await Future.value(uploadTask);
      imageUrl = await storageRef.getDownloadURL();
      // List<String> imageUrls = imageUrl;
      print('img 12' + imageUrl.toString());
      print('id Is : ' + documentId);
      await state.ref.doc(documentId).update(
        {
          'images': FieldValue.arrayUnion([imageUrl]),
          // imageId.toString() : imageUrl,
        },

        // SetOptions(merge: false),
      ).then((value) {
        print("image no is" + imageId.toString());
        print("image url is" + imageUrl.toString());
        clearDateFromScreen();
        // images = [];
        Get.toNamed(RouteNames.homeview);

        setLoading(false);

      }).onError((error, stackTrace) {
        print(error.toString());
        setLoading(false);
        
      });
    } catch (e) {
      print(e.toString());
      setLoading(false);

    }
  }

  Future<void> uploadReceivedFileDataOnFirebase(
      String id,
      // String name,
      final DateTime date,
      String serialNum,
      // String deptName,
      String receiverName,
      String receiverAddress,
      String recieverFrom,
      ) async {
    try {
      setLoading(true);
      print('inside try');
      await state.ref
          .doc(id)
          .set(ReceivedFileModel(
                  id: id,
                  images: [],
                  // name: name,
                  // dept: deptName,
                  date: date,
                  receivedAddress: receiverAddress,
                  receivereName: receiverName,
                  receivedFrom: recieverFrom,
                  SerialNum: serialNum,
                  )
              .toJson())
          .then((value) {
        print('inside then');
        Get.to(() => ListOfFileView(
          details: state.detailController.text
              .trim(),
          date:state.selectedDate,
          fileNo: state.serialNumController.text
              .trim(),
          recieverName:
          state.receivedfromController.text.trim(),
          // FileName:
          // state.nameController.text.trim(),
          // deptName: state.deptName.value,
        ));

        setLoading(false);

      }).onError((error, stackTrace) {
        print("Error" + error.toString());

        setLoading(false);

      });
    } catch (e) {
      setLoading(false);

    }
  }

//   here we manage the section of update the file data

  // Future<void> showFileNameDialogAlert(
  //     BuildContext context, String filename, String id) {
  //   //this line 104 code mean jo user ka already name ho ga wo show ho
  //   state.nameController.text = filename;
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Center(child: Text('update filename')),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 ReuseField(
  //                     myController: state.nameController,
  //                     focusNode: state.nameFocusNode,
  //                     lableText: 'Enter your Filename',
  //                     onFiledSubmittedValue: (value) {},
  //                     keyboardType: TextInputType.emailAddress,
  //                     obsecureText: false,
  //                     onvalidator: (value) {})
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   'cancel',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .subtitle2!
  //                       .copyWith(color: AppColors.warningColor),
  //                 )),
  //             TextButton(
  //                 onPressed: () {
  //                   print('id' + id);
  //                   //this  code will update the name in database
  //                   state.ref.doc(id).update({
  //                     'Name': state.nameController.text.toString()
  //                   }).then((value) {
  //                     fetchDataOfFiles(id);
  //                     state.nameController.clear();
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   'ok',
  //                   style: Theme.of(context).textTheme.subtitle2,
  //                 ))
  //           ],
  //         );
  //       });
  // }

  Future<void> showserialNumDialogAlert(
      BuildContext context, String filenum, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    state.serialNumController.text = filenum;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('update serial Number')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: state.serialNumController,
                      focusNode: state.serialNumFocusNode,
                      lableText: 'Enter your Serial Num',
                      onFiledSubmittedValue: (value) {},
                      keyboardType: TextInputType.emailAddress,
                      obsecureText: false,
                      onvalidator: (value) {})
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.warningColor),
                  )),
              TextButton(
                  onPressed: () {
                    //this  code will update the name in database
                    state.ref.doc(id).update({
                      'serialNum': state.serialNumController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      state.serialNumController.clear();
                    });

                    Navigator.pop(context);
                  },
                  child: Text(
                    'ok',
                    style: Theme.of(context).textTheme.subtitle2,
                  ))
            ],
          );
        });
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

  List<String> fetchedImageUrls = [];
  RxBool fetchedLoading = true.obs;

  setFetchLoading(bool val) {
    fetchedLoading.value = val;
  }

  Future<List<String>> fetchImageUrls(String docId) async {
    setFetchLoading(true);
    final snapshot = await FirebaseFirestore.instance
        .collection('Received Files')
        .doc(docId)
        .get();

    final List<String> imageUrls =
        List<String>.from(snapshot.data()!['images']);
    return imageUrls;
  }

//   here we create a function to delelete files

  Future<void> deleteFile(String id)async{
    try{
      await state.ref.doc(id).delete().then((value){
        print('File Deleted');
      }).onError((error, stackTrace){
        Get.snackbar('Error', error.toString());
      });
    }catch(e){
      Get.snackbar('error', e.toString());
    }

  }

//   function to download images
  Future<void> downloadImages(List<String> imageUrls) async {
    dio.Dio dioInstance = dio.Dio(); // Use the aliased dio package

    for (int i = 0; i < imageUrls.length; i++) {
      try {
        dio.Response response = await dioInstance.get(
          imageUrls[i],
          options: dio.Options(responseType: dio.ResponseType.bytes),
        );

        // Get the local app directory
        String directory = (await getApplicationDocumentsDirectory()).path;

        // Save the image to local storage
        String filePath = '$directory/image_$i.png';
        await File(filePath).writeAsBytes(response.data!);

        // Save the image to the gallery
        GallerySaver.saveImage(filePath).then((value) {
          print('Image saved to gallery: $value');
        });

        Get.snackbar('Success', 'Image Downloaded');
      } catch (error) {
        print('Error downloading image: $error');
        Get.snackbar('Error', 'Failed to download image');
      }
    }
  }

}
