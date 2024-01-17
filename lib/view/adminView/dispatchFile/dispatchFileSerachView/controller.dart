

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'state.dart';

class dispatchSearchController extends GetxController{

  final state = dispatchSearchState();
  RxList<DocumentSnapshot> allFiles = RxList<DocumentSnapshot>();
  RxList<DocumentSnapshot> filteredFiles = RxList<DocumentSnapshot>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllFiles();
  }
  void fetchAllFiles()async{
    final querySnapshot = await FirebaseFirestore.instance.collection('dispatchFile').get();
    print('length : ' + querySnapshot.docs.length.toString());
    allFiles.assignAll(querySnapshot.docs);
  }
  fetchFilteredFiles(String query) async{
    final lowerCaseQuery = query.toLowerCase();
    List<DocumentSnapshot> results = [];
    try{
      if(query.isEmpty){
        results =[];
      }else{
        results = allFiles.where((data) =>
        data['serialNum'].toString().toLowerCase().contains(lowerCaseQuery) ||
            data['letterNum'].toString().toLowerCase().contains(lowerCaseQuery) ||
            data['recieverName'].toString().toLowerCase().contains(lowerCaseQuery) ||
            data['subject'].toString().toLowerCase().contains(lowerCaseQuery)
        ).toList();
      }
      filteredFiles.value = results;
      update();

    }catch(e){

    }

  }

}