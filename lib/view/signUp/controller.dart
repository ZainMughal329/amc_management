





import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../model/services/session_Controller.dart';
import '../../model/userModel/user_model.dart';
import 'index.dart';

class SignupController extends GetxController {
  final state = SignupState();

  SignupController();
  final auth = FirebaseAuth.instance;

  signUpwithemailandpass(UserModel userInfo, String email, password) async {
    // state.loading(true);
    try {
      print('inside try');
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print('inside then');

        createUser(userInfo);
      }).onError((error, stackTrace) {
        // state.loading.value = false;
        print("Error is : " + error.toString());
      });
    } catch (e) {
      // state.loading(false);
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> storeUser(UserModel user) async {
    signUpwithemailandpass(user, user.email, user.password);
    // Get.toNamed(RouteNames.loginview);
  }

  createUser(UserModel user) async {
    // state.loading.value = true;
    await state.dbFireStore
        .doc(SessionController().userid.toString())
        .set(user.toJson())
        .whenComplete(() {
      Get.snackbar("success", 'Successfully created account');

      // state.loading.value = false;
      // StorePrefrences sp = StorePrefrences();
      // sp.setIsFirstOpen(true);
      // Get.offAllNamed(AppRoutes.Application);
    }).catchError((error, stackTrace) {
      // toastInfo(msg: "Error occurred");
      // state.loading.value = false;
      Get.snackbar("Error", 'Error occurred : ${error.toString()}');
    });
  }

// void SignUp(BuildContext context,String username , String email , String password)async{
//
//     try{
//       state.auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
//
//         SessionController().userid=value.user!.uid.toString();
//
//          state.dbFireStore.contains(value.user!.uid.toString()).set({
//           'uid':value.user!.uid.toString(),
//           'email':value.user!.email.toString(),
//            'username':username
//         })
//         ;
//
//       }).onError((error, stackTrace){
//         Get.snackbar('Error',error.toString());
//       });
//
//     }catch(e){
//       Get.snackbar('Error',e.toString());
//     }
//
// }
}
