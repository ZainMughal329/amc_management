
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SearchState{
  TextEditingController searchController = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('Received Files');
  }