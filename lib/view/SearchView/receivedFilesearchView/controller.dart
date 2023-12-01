import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../model/userModel/user_model.dart';
import 'index.dart';

class SearchBarController extends GetxController {

  final state = SearchState();
  RxList<DocumentSnapshot> allFiles = RxList<DocumentSnapshot>();
  RxList<DocumentSnapshot> filteredFiles = RxList<DocumentSnapshot>();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllFiles();
  }

  void fetchAllFiles() async {
    final querySnapshot = await FirebaseFirestore.instance.collection(
        'addFiles').get();
    print('length : ' + querySnapshot.docs.length.toString());
    allFiles.assignAll(querySnapshot.docs);
  }

  fetchFilteredFiles(String query) async {
    final lowerCaseQuery = query.toLowerCase();
    List<DocumentSnapshot> results = [];
    try {
      if (query.isEmpty) {
        results = [];
      } else {
        results = allFiles.where((data) =>
        data['FileNum'].toString().toLowerCase().contains(lowerCaseQuery) ||
            data['From'].toString().toLowerCase().contains(lowerCaseQuery) ||
            data['Name'].toString().toLowerCase().contains(lowerCaseQuery) ||
            data['dept'].toString().toLowerCase().contains(lowerCaseQuery)
        ).toList();
      }
      filteredFiles.value = results;
      update();
    }catch(e) {

    }
  }
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

}

