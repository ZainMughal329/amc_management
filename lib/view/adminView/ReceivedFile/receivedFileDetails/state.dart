import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class receivedFilesDetailState{

  List<String> imageUrls = [];
  RxInt imageNo = 0.obs;
  final loading = false.obs;
  RxBool loaded = false.obs;
  final ref = FirebaseFirestore.instance.collection('ReceivedFiles');
  RxList<String> fetchedImageUrls = <String>[].obs;
  RxBool fetchedLoading = true.obs;
  List<String> images = [];
  RxString serialNum = ''.obs;
  RxString receiverFrom = ''.obs;
  RxString receiverAddress = ''.obs;
  RxString receiverName = ''.obs;






}