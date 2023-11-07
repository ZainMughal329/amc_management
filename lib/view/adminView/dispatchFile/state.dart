import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class dispatchState {
  final detailController = TextEditingController();
  final detailFocousNode = FocusNode();
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();
  final dateController = TextEditingController();
  final dateFocusNode =FocusNode();
  final fileNumcontroller = TextEditingController();
  final filenumFocousNode = FocusNode();
  final markByController = TextEditingController();
  final markByFocusNode =FocusNode();
  DateTime selectedDate = DateTime.now();
  final recievedByController = TextEditingController();
  final recievedByFocusNode =FocusNode();
  final notificationToController = TextEditingController();
  final notificationToFocusNode =FocusNode();
  final ref = FirebaseFirestore.instance.collection('dispatchFile');
  var deptName = 'Select'.obs;
  RxInt imageNo = 0.obs;
  final loading = false.obs;
  final auth = FirebaseAuth.instance;
  final RxBool isFormValid = false.obs;
  // Widget _buildCatList() {
//     return Obx(
//       () => Expanded(
//         flex: 0,
//         child: DropdownButton(
//           iconEnabledColor: AppColors.lightActiveIconColor,
//           dropdownColor: AppColors.lightBgColor,
//           style: TextStyle(color: AppColors.lightTextColor),
//           iconSize: 40.0.h,
//           hint: controller.state.catValue.value == ""
//               ? Text(
//                   "Category",
//                   style: TextStyle(color: AppColors.lightTextColor),
//                 )
//               : Text(
//                   controller.state.catValue.value,
//                   style: TextStyle(color: AppColors.lightTextColor),
//                 ),
//           items: [
//             DropdownMenuItem(
//               child: Text("Adventure"),
//               value: "Adventure",
//             ),
//             DropdownMenuItem(
//               child: Text("Cultural"),
//               value: "Cultural",
//             ),
//             DropdownMenuItem(
//               child: Text("Hiking"),
//               value: "Hiking",
//             ),
//             DropdownMenuItem(
//               child: Text("Mountains"),
//               value: "Mountains",
//             ),
//           ],
//           onChanged: (String? value) {
//             controller.state.catValue.value = value!;
//           },
//         ),
//       ),
//     );
//   }

  // final List<String> listItem = [
  //   "Principle",
  //   "It",
  //   "Math",
  //   "English",
  //   "Urdu",
  //   "Physics",
  //   "Chemistry",
  //   "Ecnomics",
  //   "Biology"
  // ];
  // List<DropdownMenuItem> listDepts = <DropdownMenuItem>[
  //   DropdownMenuItem(
  //     value: 'principle',
  //     child: Text('Principle'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'IT',
  //     child: Text('IT'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'english',
  //     child: Text('English'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'math',
  //     child: Text('Math'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'physics',
  //     child: Text('Physics'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'economics',
  //     child: Text('Economics'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'biology',
  //     child: Text('Biology'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'urdu',
  //     child: Text('Urdu'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'chemistry',
  //     child: Text('Chemistry'),
  //   ),
  // ];
}
