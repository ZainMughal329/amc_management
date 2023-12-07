import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../model/ReceivedFile_model/ReceivedFile_model.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/SessionViewComponents/custom_tetxField.dart';
import '../receivedFileUploadForm/state.dart';
import 'state.dart';
import 'package:dio/dio.dart' as dio;


class receivedFileDetailController extends GetxController{


  final state = receivedFilesDetailState();
  final uplaodFormState =dataUploadState();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // for image list
    getImageUrls().then((urls) => {state.imageUrls = urls});
  }
  ReceivedFileModel? addFileModel;
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
    final snapshot = await FirebaseFirestore.instance
        .collection('Received Files')
        .doc(docId)
        .get();

    final List<String> imageUrls =
    List<String>.from(snapshot.data()!['images']);
    return imageUrls;
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
        uplaodFormState.serialNum.value = documentSnapshot!['serialNum'];
        uplaodFormState.loaded.value = true;

        // print('value of name : ' +state.nameFile.value.toString(),);
        print('value of file number : ' +uplaodFormState.serialNum.value.toString(),);

      } else {
        print('empty');
      }
    } catch(e){
      print('exception : ' + e.toString());
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



    Future<void> showserialNumDialogAlert(
        BuildContext context, String filenum, String id) {
      //this line 104 code mean jo user ka already name ho ga wo show ho
      uplaodFormState.serialNumController.text = filenum;
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
                        focusNode:
                            uplaodFormState.serialNumFocusNode,
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
                      style: Theme.of(context).textTheme.subtitle2,
                    ))
              ],
            );
          });
    }




  }





























}