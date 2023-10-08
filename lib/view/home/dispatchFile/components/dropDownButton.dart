


import 'package:amc_management/res/colors.dart';
import 'package:amc_management/res/components/custom_tetxField.dart';
import 'package:amc_management/view/home/dispatchFile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DropDownList extends GetView<dispatchController> {

  DropDownList({super.key});
  String deptChoose ="";
  List<String> listItem=[
    "Principle","It","Math","English","Urdu","Physics","Chemistry","Ecnomics","Biology"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: DropdownButton(
            iconEnabledColor: AppColors.primaryIconColor,
            dropdownColor: AppColors.lightGrayColor,
            borderRadius: BorderRadius.circular(10),
            // isDense: true,
            // isExpanded: true,
            // iconSize: 40,
            hint: controller.state.deptName.value == ""
                ? Text("Select Package")
                : Text(controller.state.deptName.value),
            items: [
              DropdownMenuItem(
                child: Text("IT"),
                value: "1",
              ),
              DropdownMenuItem(
                child: Text("URDU"),
                value: "2",
              ),
              DropdownMenuItem(
                child: Text("PHYSICS"),
                value: "3",
              ),
              DropdownMenuItem(
                child: Text("ECNOMICS"),
                value: "4",
              ),
              DropdownMenuItem(
                child: Text("CHEMISTRY"),
                value: "5",
              ),
              DropdownMenuItem(
                child: Text("ENGLISH"),
                value: "6",
              ),
              DropdownMenuItem(
                child: Text("BIOLOGY"),
                value: "7",
              ),
              DropdownMenuItem(
                child: Text("MATH"),
                value: "8",
              ),
            ],
            onChanged: (String? value) {
              controller.state.deptName.value = value!;
            },
          ),
        )
    );
  }
}


// Center(
//         child: customTextField(hintText: 'select Dept',
//         suffixIcon: Icons.keyboard_arrow_down,
//           onPressSufix: (){
//           DropdownButton(
//             elevation: 4,
//             underline: Container(
//               height: 0,
//             ),
//             onChanged: (String? newValue){
//               setState(
//                   (){
//                     deptChoose=newValue!;
//
//                   }
//               );
//
//             },
//             items: listItem.map<DropdownMenuItem<String>>(
//                 (String value){
//                   return DropdownMenuItem<String>(
//                     value: value.toString(),
//                     child: Text(value.toString()),
//                   );
//
//                 }
//
//             ).toList()
//           );
//           },
//         )
//       ),