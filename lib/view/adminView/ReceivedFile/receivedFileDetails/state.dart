import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class receivedFilesDetailState{

  List<String> imageUrls = [];
  RxInt imageNo = 0.obs;
  final loading = false.obs;
  RxBool loaded = false.obs;
  final ref = FirebaseFirestore.instance.collection('Received Files');
  RxList<String> fetchedImageUrls = <String>[].obs;
  RxBool fetchedLoading = true.obs;
  List<String> images = [];




}