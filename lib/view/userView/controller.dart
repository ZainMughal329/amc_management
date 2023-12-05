import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:dio/dio.dart' as dio; // Alias the dio package
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import '../../../model/userModel/user_model.dart';
import 'index.dart';
class userViewController extends GetxController{
  final auth = FirebaseAuth.instance;
  final state = userViewState();
  final db = FirebaseFirestore.instance.collection('users');
  Future<UserModel> getUserData(String id )async{
    final snapshot= await db.where('id', isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }
  getUsersData() async {
    print('INSIDE FUNC');
    state.id = auth.currentUser!.uid.toString();
    if (state.id != '') {
      print('object');
      final data = await getUserData(state.id.toString());
      return data;
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  List<String> fetchedImageUrls = [];
  RxBool fetchedLoading = true.obs;

  setFetchLoading(bool val) {
    fetchedLoading.value = val;
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


// ... other imports ...

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

  // ... Other imports ...

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

