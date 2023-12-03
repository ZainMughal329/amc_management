// multi_select_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

// multi_select_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiSelectBottomSheet extends StatelessWidget {
  final List<String> items;
  final RxList<String> selectedItems;

  MultiSelectBottomSheet(this.items, this.selectedItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Obx(() {
        return ListView(
          children: items.map((item) {
            return CheckboxListTile(
              title: Text(item),
              value: selectedItems.contains(item),
              onChanged: (value) {
                if (value!) {
                  selectedItems.add(item);
                } else {
                  selectedItems.remove(item);
                }
              },
            );
          }).toList(),
        );
      }),
    );
  }
}
// multi_select_dropdown.dart

class MultiSelectDropdown extends StatelessWidget {
  final MultiSelectDropdownController controller = Get.put(MultiSelectDropdownController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: Text("Select Depts"),
            trailing: Icon(Icons.arrow_drop_down),
            onTap: () => controller.showMultiSelectBottomSheet(),
          ),
          SizedBox(height: 10),
          Obx(
                () => Text("Selected Items: ${controller.selectedItems.join(', ')}"),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MultiSelectDropdown(),
  ));
}
