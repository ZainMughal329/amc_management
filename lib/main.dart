import 'package:amc_management/utils/routes/routes.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/adminView/listofImages/controller.dart';
import 'package:amc_management/view/adminView/listofImages/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform
  );
  Get.put(ListOfFileController());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      builder: (context,child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: ListOfFileView(),
          initialRoute: RouteNames.homeview,
          getPages:AppPages.routes,
        );

      },
    );
  }
}
