import 'package:amc_management/view/userView/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../model/userModel/user_model.dart';
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
}

