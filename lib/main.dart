import 'package:amc_management/res/components/adminViewComponents/addFileDisplay.dart';
import 'package:amc_management/utils/routes/routes.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform
  );
  // Get.put(ListOfFileController());
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      builder: (context,child){
        return
          GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: addFileDisplay(
          //   receiverName: 'wahab',
          //   fileName: 'Abcd',
          //   deptName: 'it',
          //   fileNumber: '101',
          // ),
          initialRoute: RouteNames.loginview,
          getPages:AppPages.routes,
        );

      },
    );
  }
}
