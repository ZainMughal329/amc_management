import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class diaryNumFileDetailsState{

  List<String> imageUrls = [];
  RxInt imageNo = 0.obs;
  final loading = false.obs;
  RxBool loaded = false.obs;
  final ref = FirebaseFirestore.instance.collection('diaryNumberRegister');
  List<String> fetchedImageUrls = [];
  RxBool fetchedLoading = true.obs;
  List<String> images = [];
  RxString serialNum = ''.obs;
  RxString dept = ''.obs;
  RxString senderName = ''.obs;
  RxString senderAddress = ''.obs;
  RxString receiverName = ''.obs;


}