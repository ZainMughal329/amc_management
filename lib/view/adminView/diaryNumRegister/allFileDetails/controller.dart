import 'dart:io';
import 'dart:typed_data';

import 'package:amc_management/res/components/adminViewComponents/sharedComponents/detailTextForm.dart';
import 'package:amc_management/view/adminView/diaryNumRegister/allFileDetails/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../model/diaryNum_model/diaryNum_model.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/SessionViewComponents/custom_tetxField.dart';
import '../dataUplaodForm/state.dart';
import 'package:dio/dio.dart' as dio; // Alias the dio package
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';



class diaryFilesDetailController extends GetxController {
  final state=diaryNumFileDetailsState();

  final uplaodFormState = dataUploadState();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // for image list
    getImageUrls().then((urls) => {state.imageUrls = urls});
  }
  List<String> images = [];
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();

  setFetchLoading(bool val) {
    state.fetchedLoading.value = val;
  }
  void setLoading(value) {
    state.loading.value = value;
  }

  List<String> fetchedImageUrls = [];
  RxBool fetchedLoading = true.obs;

  Future<List<String>> fetchImageUrls(String docId) async {
    setFetchLoading(true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('diaryNumberRegister')
          .doc(docId)
          .get();
      print("Firestore Snapshot: ${snapshot.data()}");

      if (snapshot.exists) {
        final dynamic imagesData = snapshot.data()!['images'];

        if (imagesData is List<dynamic>) {
          final List<String> imageUrls = List<String>.from(imagesData.map((e) => e.toString()));
          return imageUrls;
        } else {
          return [];
        }
      } else {
        print('Document does not exist');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }

    // final List<dynamic> dynamicImageUrls = snapshot.data()!['images'];
    // final List<String> imageUrls = List<String>.from(dynamicImageUrls.map((e) => e.toString()));
    // return imageUrls;
  }

  // Future<List<String>> fetchImageUrls(String docId) async {
  //   setFetchLoading(true);
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('diaryNumberRegister')
  //       .doc(docId)
  //       .get();
  //
  //   final List<String> imageUrls =
  //   List<String>.from(snapshot.data()!['images']);
  //   return imageUrls;
  // }
  Future<List<String>> getImageUrls() async {
    final QuerySnapshot querySnapshot = await state.ref.get();
    final List<String> imageUrls = [];
    querySnapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('imageUrl')) {
        final imageUrl = data[
        'images'];
        imageUrls.add(imageUrl);
      }
    });

    return imageUrls;
  }



    DocumentSnapshot? documentSnapshot;
    DiaryNumModel?diaryFileModel;

 // for updation of data
  fetchDataOfFiles(String id) async {
    try{
      setFetchLoading(true);

      documentSnapshot =
      await FirebaseFirestore.instance.collection('diaryNumberRegister').doc(id).get();
      if (documentSnapshot!.exists) {
        print('id' + id);

        diaryFileModel = DiaryNumModel(
            id: id,
            // subject: documentSnapshot![''],
            images: images,
            dept: documentSnapshot!['Dept'],
            senderName:  documentSnapshot!['senderName'],
            receiverName:  documentSnapshot!['receiverName'],
            senderAddress:  documentSnapshot!['senderAddress'],
            serialNum:  documentSnapshot!['serialNum']
        );
         state.serialNum.value = documentSnapshot!['serialNum'];
        state.senderAddress.value = documentSnapshot!['senderAddress'];
        state.receiverName.value = documentSnapshot!['receiverName'];
        // state.dept.value = documentSnapshot!['Dept'];
        state.senderName.value = documentSnapshot!['senderName'];
        state.loaded.value = true;
        // print('value of file number : ' +state.serialNum.value.toString(),);
      } else {
        print('empty');
      }
    } catch(e){
      print('exception : ' + e.toString());
    }finally{
      setFetchLoading(false);
    }

  }



  Future<void> showserialNumDialogAlert(
      BuildContext context, String serialNum, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    uplaodFormState.serialNumController.text = serialNum;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('update serial Number')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: uplaodFormState.serialNumController,
                      focusNode: uplaodFormState.serialNumFocus,
                      lableText: 'Enter your Serial Num',
                      onFiledSubmittedValue: (value) {},
                      keyboardType: TextInputType.number,
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
                      'serialNum': uplaodFormState.serialNumController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      uplaodFormState.serialNumController.clear();
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
  Future<void> senderNameDialogAlert(
      BuildContext context, String senderName, String id) {
    uplaodFormState.senderNameController.text = senderName;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('update sender Name')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: uplaodFormState.senderNameController,
                      focusNode: uplaodFormState.senderNameFocus,
                      lableText: 'Enter your sender Name',
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
                      'senderName': uplaodFormState.senderNameController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      uplaodFormState.senderNameController.clear();
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

  Future<void> receiverNameDialogAlert(
      BuildContext context, String receiverName, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    uplaodFormState.receiverNameController.text = receiverName;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('update receiver Name')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: uplaodFormState.receiverNameController,
                      focusNode: uplaodFormState.receiverNameFocus,
                      lableText: 'Enter your receiver name',
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
                      'receiverName': uplaodFormState.receiverNameController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      uplaodFormState.receiverNameController.clear();
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

  Future<void> senderAddressDialogAlert(
      BuildContext context, String senderAddress, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    uplaodFormState.senderAddressController.text = senderAddress;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('update sender Address')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  detailTextFormField(
                      controller: uplaodFormState.senderAddressController,
                      focusNode: uplaodFormState.senderAddressFocus,
                      lableText: 'Enter your Sender Address',
                      onFiledSubmittedValue: (value) {},
                      keyboardType: TextInputType.emailAddress,
                      onvalidator: (value) {}
                  )

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
                      'serialNum': uplaodFormState.senderAddressController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      uplaodFormState.senderAddressController.clear();
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

  // Function to generate PDF from images
  Future<void> generatePDF(List<String> imageUrls) async {
    // Check and request permission
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, proceed with PDF generation
      final pdf = pw.Document();

      for (var imageUrl in imageUrls) {
        final response = await dio.Dio().get<List<int>>(
          imageUrl,
          options: dio.Options(responseType: dio.ResponseType.bytes),
        );

        final imageBytes = Uint8List.fromList(response.data!);
        final image = pw.MemoryImage(imageBytes);

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(image),
              );
            },
          ),
        );
      }

      final output = await getExternalStorageDirectory();
      final file = File('${output!.path}/images.pdf');
      await file.writeAsBytes(await pdf.save());

      print('File Path: ${file.path}');

      // Open the PDF with the default PDF viewer (you can use another PDF viewer package)
      // This assumes you have a package like 'open_file' to open files
      OpenFile.open(file.path);
    } else {
      // Permission denied
      print('Permission denied');
    }
  }




}


