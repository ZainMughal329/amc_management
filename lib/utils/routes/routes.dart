import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/scanimages/bindings.dart';
import 'package:amc_management/view/scanimages/view.dart';
import 'package:amc_management/view/userView/bindings.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../view/SessionView/forgot/bindings.dart';
import '../../view/SessionView/forgot/view.dart';
import '../../view/SessionView/login/bindings.dart';
import '../../view/SessionView/login/view.dart';
import '../../view/SessionView/signUp/bindings.dart';
import '../../view/SessionView/signUp/view.dart';
import '../../view/SessionView/splash/bindings.dart';
import '../../view/SessionView/splash/view.dart';
import '../../view/adminView/addFile/bindings.dart';
import '../../view/adminView/addFile/components/fileshow.dart';
import '../../view/adminView/addFile/view.dart';
import '../../view/adminView/dispatchFile/bindings.dart';
import '../../view/adminView/dispatchFile/fileshow.dart';
import '../../view/adminView/dispatchFile/view.dart';
import '../../view/adminView/home_view/bindings.dart';
import '../../view/adminView/home_view/view.dart';
import '../../view/adminView/profile/bindings.dart';
import '../../view/adminView/profile/view.dart';
import '../../view/adminView/sendFile/bindings.dart';
import '../../view/adminView/sendFile/view.dart';
import '../../view/adminView/users/bindings.dart';
import '../../view/adminView/users/view.dart';
import '../../view/userView/view.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
        name: RouteNames.splashview,
        page: () => SplashView(),
        binding: SplashBindings()),
    GetPage(
        name: RouteNames.loginview,
        page: () => LoginView(),
        binding: LoginBindings()),
    GetPage(
        name: RouteNames.forgotview,
        page: () => Forgotview(),
        binding: Forgotbindinsg()),
    GetPage(
        name: RouteNames.homeview,
        page: () => HomeView(),
        binding: HomeBindings()),
    GetPage(
        name: RouteNames.signupview,
        page: () => SignUpView(),
        binding: SignupBindings()),
    GetPage(name: RouteNames.profileview, page: ()=>profileView(),
    binding: profileBindings()
    ),
    GetPage(
        name: RouteNames.userlistview,
        page: () => userListView(),
        binding: userBindings()),
    GetPage(
        name: RouteNames.addfileview,
        page: () => addFileView(),
        binding: addFileBindings()),
    GetPage(name: RouteNames.addfileshowcontainer, page:()=> addFileShowContainer(
        img: "",
        details: "",
        dept: "",
        date: "",
        name: "",
        fileNum: "",
        from: ""),
    binding: addFileBindings()
    ),
    GetPage(
        name: RouteNames.dispatchview,
        page: () => dispatchView(),
        binding: dispatchBindings()),
    GetPage(name: RouteNames.dispatchfileshowcontainer, page: ()=>dispatchFileShowContainer(
      recievedFrom: "",
      notificationTo: "",
      img: "",
      date: "",
      name: "",
    ),
    binding: dispatchBindings()
    ),
    GetPage(
        name: RouteNames.scanImage,
        page: () => ScannImageView(),
        binding: ScanImageBindings(),),
    GetPage(name: RouteNames.chatScreen, page:()=>sendFile(
      name: "",
      img: "",
      recieverId: "",
      email: "",
    ),
    binding: sendFileBindings()
    ),

    GetPage(name: RouteNames.userView, page:()=>userView(
      deptName: "",
    ),
    binding: userViewBindings())
  ];
}

