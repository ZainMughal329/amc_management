

import 'package:amc_management/view/home/sendFile/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class sendFileController extends GetxController{
  final state = sendFileState();

  // void sendMessage()async{
  //   String messageText = state.messageController.text.trim();
  //     if(messageText.isNotEmpty){
  //       await state.ref.collection('Message').add({
  //         'text':messageText,
  //         'timestamp':FieldValue.serverTimestamp(),
  //       });
  //       state.messageController.clear();
  //     }
  // }


  sendMessage(){
    if(state.messageController.text.isEmpty){
      Get.snackbar('Message', 'Enter a message ');
    }else{
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      state.ref.collection(timestamp).add({
        'isSeen':false,
        'message':state.messageController.text.toString(),
        'sender':state.auth.currentUser!.uid.toString(),
        'receiver':"",
        'type':'text',
        'time':timestamp.toString()
      }).then((value){
       state.messageController.clear();
      });
    }

  }

}