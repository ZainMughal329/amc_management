

import 'package:amc_management/view/adminView/diaryNumRegister/searchView/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class diaryFilesSearchController extends GetxController{
final state = diarySearchState();
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
      'diaryNumberRegister').get();
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
      data['Date'].toString().toLowerCase().contains(lowerCaseQuery) ||
          data['receiverName'].toString().toLowerCase().contains(lowerCaseQuery) ||
          data['serialNum'].toString().toLowerCase().contains(lowerCaseQuery) ||
          data['senderName'].toString().toLowerCase().contains(lowerCaseQuery) ||
          data['senderAddress'].toString().toLowerCase().contains(lowerCaseQuery) ||
          data['fileDispatchDate'].toString().toLowerCase().contains(lowerCaseQuery) ||
          data['Dept'].toString().toLowerCase().contains(lowerCaseQuery)
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