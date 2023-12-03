// multi_select_dropdown_controller.dart
import 'package:amc_management/view/scanimages/view.dart';
import 'package:get/get.dart';

class MultiSelectDropdownController extends GetxController {
  RxList<String> selectedItems = <String>[].obs;

  List<String> items = [
    'Principle',
    'Vice_Principle',
    'Staff',
    'IT',
    'English',
    'Math',
    'Physics',
    'Economics',
    'Biology',
    'Urdu',
    'Chemistry',
  ];

  void showMultiSelectBottomSheet() async {
    List<String> selectedValues = await Get.bottomSheet(
      MultiSelectBottomSheet(items, selectedItems),
    );

    if (selectedValues != null) {
      selectedItems.assignAll(selectedValues);
      // Send the list to the database or perform any other action here
      print('Selected Items: $selectedItems');
    }
  }
}
