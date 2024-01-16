import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class diaryNumFileDetailsState{

  List<String> imageUrls = [];
  RxInt imageNo = 0.obs;
  final loading = false.obs;
  RxBool loaded = false.obs;
  final ref = FirebaseFirestore.instance.collection('diaryNumberRegister');
  RxList<String> fetchedImageUrls = <String>[].obs;
  RxBool fetchedLoading = true.obs;
  List<String> images = [];
  RxString serialNum = ''.obs;
  RxString dept = ''.obs;
  RxString senderName = ''.obs;
  RxString senderAddress = ''.obs;
  RxString subject =''.obs;
  RxString receiverName = ''.obs;
  final length= 0.obs ;


}