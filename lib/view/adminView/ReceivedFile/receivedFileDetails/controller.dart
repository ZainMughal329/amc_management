import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../model/ReceivedFile_model/ReceivedFile_model.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/SessionViewComponents/custom_tetxField.dart';
import '../../../../res/components/adminViewComponents/sharedComponents/detailTextForm.dart';
import '../../../../res/components/textWidget.dart';
import '../receivedFileUploadForm/state.dart';
import 'state.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:dio/dio.dart' as dio;


class receivedFileDetailController extends GetxController {


  final state = receivedFilesDetailState();
  final uplaodFormState = dataUploadState();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // for image list
    getImageUrls().then((urls) => {state.imageUrls = urls});
  }

  ReceivedFileModel? receivedFileModel;
  DocumentSnapshot? documentSnapshot;
  List<String> images = [];
  List<String> imageUrls = [];

  void setLoading(value) {
    state.loading.value = value;
  }

  setFetchLoading(bool val) {
    state.fetchedLoading.value = val;
  }

  Future<List<String>> fetchImageUrls(String docId) async {
    setFetchLoading(true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('ReceivedFiles')
          .doc(docId)
          .get();
      print("Firestore Snapshot: ${snapshot.data()}");

      if (snapshot.exists) {
        final dynamic imagesData = snapshot.data()!['images'];


        print('data:' + imagesData.toString());

        final List<String> imageUrls =
        List<String>.from(snapshot.data()!['images']);
        print(imageUrls.length.toString());


        return imageUrls;
      } else {
        print('Document does not exist');


        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');


      return [];
    }
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

  // for updation of data
  fetchDataOfFiles(String id) async {
    try {
      documentSnapshot =
      await FirebaseFirestore.instance.collection('ReceivedFiles')
          .doc(id)
          .get();
      if (documentSnapshot!.exists) {
        print('id' + id);

        receivedFileModel = ReceivedFileModel(
            id: id,
            receivereName: documentSnapshot!['receiverName'],
            receivedAddress: documentSnapshot!['receivedAddress'],
            receivedFrom: documentSnapshot!['From'],
            SerialNum: documentSnapshot!['serialNum'],
            images: images);
        state.serialNum.value = documentSnapshot!['serialNum'];
        state.receiverName.value = documentSnapshot!['receiverName'];
        state.receiverFrom.value = documentSnapshot!['From'];
        state.receiverAddress.value = documentSnapshot!['receivedAddress'];
        uplaodFormState.loaded.value = true;

        // print('value of name : ' +state.nameFile.value.toString(),);
        print('value of file number : ' +
            uplaodFormState.serialNum.value.toString(),);
      } else {
        print('empty');
      }
    } catch (e) {
      print('exception : ' + e.toString());
    }
    //   function to download images





  }

  Future<void> showserialNumDialogAlert(BuildContext context,
      String serialNum, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    uplaodFormState.serialNumController.text = serialNum;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(child: TextWidget(
              title: 'update serial number',
              textColor: AppColors.tittleColour,)),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: uplaodFormState.serialNumController,
                      focusNode:
                      uplaodFormState.serialNumFocusNode,
                      lableText: 'Enter your serial number',
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.warningColor),
                  )),
              TextButton(
                  onPressed: () {
                    //this  code will update the name in database
                    state.ref.doc(id).update({
                      'serialNum':
                      uplaodFormState.serialNumController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      uplaodFormState.serialNumController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ok',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2,
                  ))
            ],
          );
        });
  }
  Future<void> showreceiverAddressDialogAlert(BuildContext context,
      String receiverAddress, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    uplaodFormState.receiverAddressController.text = receiverAddress;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(child: Text('update Receiver Address')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  detailTextFormField(
                      controller: uplaodFormState.receiverAddressController,
                      focusNode: uplaodFormState.receiverAddressFocusNode,
                      lableText: 'Enter your Receiver Address',
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.warningColor),
                  )),
              TextButton(
                  onPressed: () {
                    //this  code will update the name in database
                    state.ref.doc(id).update({
                      'receivedAddress': uplaodFormState
                          .receiverAddressController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      uplaodFormState.receiverAddressController.clear();
                    });

                    Navigator.pop(context);
                  },
                  child: Text(
                    'ok',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2,
                  ))
            ],
          );
        });
  }

  Future<void> showrecievedfromDialogAlert(BuildContext context,
      String recievedFrom, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    uplaodFormState.receivedfromController.text = recievedFrom;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(child: TextWidget(title: 'update Receiver From',
              textColor: AppColors.tittleColour,)),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: uplaodFormState.receivedfromController,
                      focusNode:
                      uplaodFormState.receivedFromFocusNode,
                      lableText: 'Enter your ReceiverFrom Name',
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.warningColor),
                  )),
              TextButton(
                  onPressed: () {
                    //this  code will update the name in database
                    state.ref.doc(id).update({
                      'From':
                      uplaodFormState.receivedfromController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      uplaodFormState.receivedfromController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ok',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2,
                  ))
            ],
          );
        });
  }

  Future<void> showrecievednameDialogAlert(BuildContext context,
      String recievedName, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    uplaodFormState.receiverNameController.text = recievedName;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(child: TextWidget(title: 'update Receiver Name',
              textColor: AppColors.tittleColour,)),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: uplaodFormState.receiverNameController,
                      focusNode:
                      uplaodFormState.receiverNameFocusNode,
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.warningColor),
                  )),
              TextButton(
                  onPressed: () {
                    //this  code will update the name in database
                    state.ref.doc(id).update({
                      'receiverName':
                      uplaodFormState.receiverNameController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      uplaodFormState.receiverNameController.clear();
                    });

                    Navigator.pop(context);
                  },
                  child: Text(
                    'ok',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2,
                  ))
            ],
          );
        });
  }





}