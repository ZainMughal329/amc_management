import 'package:amc_management/view/home/users/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class userController extends GetxController with GetSingleTickerProviderStateMixin{
  final state = userState();
  late TabController tabController;
  userController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
  RxList<DocumentSnapshot> data = RxList<DocumentSnapshot>();
  final db = FirebaseFirestore.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  final firestore = FirebaseFirestore.instance.collection('users').where('status', isEqualTo: 'false').snapshots();
  final _db = FirebaseFirestore.instance;
  updateUserData(String id) async {
    print('Inside update');
    print('update id : ' + id);
    await ref.doc(id).update({
      'status': 'true',
    }).then((value) {
      Get.snackbar('St', 'Congrats');
    }).onError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong');
    });
  }
  deleteUserData(String id) async {
    await ref.doc(id).delete().then((value) {
      Get.snackbar('Delete', 'Successfully Deleted');
    }).onError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong');
    });
  }
  Future<void> deleteUsers(String id)async{
    try{
     await state.ref.collection('users').doc(id).delete().then((value) {
        print('user deleted');
      }).onError((error, stackTrace) {
        print('error is : ' + error.toString());
      });
      // state.dbref.doc('id').delete();
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }
}