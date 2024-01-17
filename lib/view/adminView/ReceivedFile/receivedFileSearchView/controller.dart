import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        'ReceivedFiles').get();
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
        data['serialNum'].toString().toLowerCase().contains(lowerCaseQuery) ||
            data['receivedFrom'].toString().toLowerCase().contains(lowerCaseQuery) ||
            data['receiverName'].toString().toLowerCase().contains(lowerCaseQuery) ||
            data['receivedAddress'].toString().toLowerCase().contains(lowerCaseQuery)
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
        Get.snackbar('Error', error.toString(),backgroundColor:Colors.white ,colorText: Colors.blueGrey.withOpacity(.8));
      });
    }catch(e){
      Get.snackbar('error', e.toString(),backgroundColor:Colors.white ,colorText: Colors.blueGrey.withOpacity(.8));
    }

  }

}

