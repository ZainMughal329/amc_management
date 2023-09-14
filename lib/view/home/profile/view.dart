// // import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/services/session_controller.dart';
import '../../../res/colors.dart';
import '../../../res/components/custom_button.dart';
import '../../../utils/routes/routes_name.dart';
import 'index.dart';
class profileView extends GetView<profileController> {
  const profileView({super.key});
  @override
  Widget build(BuildContext context) {
    // MobileScannerController cameraController = MobileScannerController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        // actions: [
        //   IconButton(
        //     color: Colors.white,
        //     icon: ValueListenableBuilder(
        //       valueListenable: cameraController.torchState,
        //       builder: (context, state, child) {
        //         switch (state as TorchState) {
        //           case TorchState.off:
        //             return const Icon(Icons.flash_off, color: Colors.grey);
        //           case TorchState.on:
        //             return const Icon(Icons.flash_on, color: Colors.yellow);
        //         }
        //       },
        //     ),
        //     iconSize: 32.0,
        //     onPressed: () => cameraController.toggleTorch(),
        //   ),
        //   IconButton(
        //     color: Colors.white,
        //     icon: ValueListenableBuilder(
        //       valueListenable: cameraController.cameraFacingState,
        //       builder: (context, state, child) {
        //         switch (state as CameraFacing) {
        //           case CameraFacing.front:
        //             return const Icon(Icons.camera_front);
        //           case CameraFacing.back:
        //             return const Icon(Icons.camera_rear);
        //         }
        //       },
        //     ),
        //     iconSize: 32.0,
        //     onPressed: () => cameraController.switchCamera(),
        //   ),
        // ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
               stream: controller.getUserData(),
              // stream: ref.child(SessionController().userid.toString()).onValue,
              builder: ( context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  //here we get the daTA in the form of map such as it name email etc
                  //dynamic sy jo bhi data ki type ho gae khud hi adjust kr le ga
                  // Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.primaryTextTextColor,
                                      )),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:controller.image==null ?
                                        snapshot.data!['profile'].toString()==""
                                        ? Icon(Icons.percent_outlined, size: 35)
                                        : Image(
                                      image: NetworkImage(
                                        snapshot.data!['profile'].toString(),
                                        // map['profile'].toString(),
                                      ),
                                      fit: BoxFit.cover,
                                      // loadingBuilder:
                                      //     (context, child, loadingProgres) {
                                      //   if (loadingProgres == null) return child;
                                      //   return Center(
                                      //     child: CircularProgressIndicator(),
                                      //   );
                                      // },
                                      errorBuilder: (context, object, stack) {
                                        return Container(
                                          child: Icon(
                                            Icons.error_outline,
                                            color: AppColors.alertColor,
                                          ),
                                        );
                                      },
                                    ):
                                    Stack(
                                      children: [
                                        Image.file(
                                            File(controller.image!.path).absolute
                                        ),
                                        Center(
                                            child: CircularProgressIndicator())
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                controller.pickImage(context);
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.primaryIconColor,
                                child: Icon(
                                  Icons.add,size: 18,color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.showUserNameDialogAlert(context,
                                snapshot.data!['UserName'].toString());
                            // controller.showUserNameDialogAlert(context,map['username']);

                          },
                          child: ReuseableRow(
                              title: 'UserName',
                              iconData: Icons.percent_outlined,
                              value: snapshot.data!['UserName'].toString()),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.showUserEmailDialogAlert(context,
                                snapshot.data!['Email'].toString()

                                // map['email']
                                );
                          },
                          child: ReuseableRow(
                              title: 'Email',
                              iconData: Icons.email_rounded,
                              value:snapshot.data!['Email']
                              // map['email']
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(height: 50,),
                        ReuseButton(tittle: 'logout', onpress:(){
                          FirebaseAuth auth =FirebaseAuth.instance;
                          auth.signOut().then((value){
                            //here we logout user and clear its ud
                            SessionController().userid='';
                            Get.toNamed(RouteNames.loginview);
                          }).onError((error, stackTrace){
                            Get.snackbar('Error', error.toString());
                          });

                        })
                      ],
                    ),
                  );
                } else {
                  return Center(
                      child: Text(
                        'Something went wrong',
                        style: Theme.of(context).textTheme.subtitle1,
                      ));
                }
              },
            ),
          ),
        ),
      )
    );
  }
}
class ReuseableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  ReuseableRow(
      {Key? key,
        required this.title,
        required this.iconData,
        required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
          trailing: Text(value, style: Theme.of(context).textTheme.subtitle2),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.4),
        )
      ],
    );
  }
}
//MobileScanner(
//               controller: MobileScannerController(
//                 // detectionSpeed: DetectionSpeed.normal,
//                 // facing: CameraFacing.front,
//                 torchEnabled: true,
//               ),
//               // fit: BoxFit.contain,
//               onDetect: (capture) {
//                 final List<Barcode> barcodes = capture.barcodes;
//                 final Uint8List? image = capture.image;
//                 for (final barcode in barcodes) {
//                   debugPrint('Barcode found! ${barcode.rawValue}');
//                 }
//                 if (image != null) {
//                   showDialog(
//                     context: context,
//                     builder: (context) =>
//                         Image(image: MemoryImage(image)),
//                   );
//                   Future.delayed(const Duration(seconds: 5), () {
//                     Navigator.pop(context);
//                   });
//                 }
//               },
//             ),