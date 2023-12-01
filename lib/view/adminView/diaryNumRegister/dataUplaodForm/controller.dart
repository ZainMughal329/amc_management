import 'package:amc_management/view/adminView/diaryNumRegister/dataUplaodForm/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class dataUplaodController extends GetxController{
  final state = dataUploadState();

  getDateFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1978),
        lastDate: DateTime(2099));
    if (pickerDate != null) {
      state.selectedDate = pickerDate;
      update();
    } else {
      print('select a date ');
    }
  }
}