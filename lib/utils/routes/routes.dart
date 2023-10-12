import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/home/addFile/bindings.dart';
import 'package:amc_management/view/home/dispatchFile/bindings.dart';
import 'package:amc_management/view/home/dispatchFile/view.dart';
import 'package:amc_management/view/scanimages/bindings.dart';
import 'package:amc_management/view/scanimages/view.dart';
import 'package:amc_management/view/userView/bindings.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../view/forgot/bindings.dart';
import '../../view/forgot/view.dart';
import '../../view/home/addFile/fileshow.dart';
import '../../view/home/addFile/view.dart';
import '../../view/home/dispatchFile/fileshow.dart';
import '../../view/home/home_view/bindings.dart';
import '../../view/home/home_view/view.dart';
import '../../view/home/profile/bindings.dart';
import '../../view/home/profile/view.dart';
import '../../view/home/sendFile/index.dart';
import '../../view/home/sendFile/view.dart';
import '../../view/home/users/bindings.dart';
import '../../view/home/users/view.dart';
import '../../view/login/bindings.dart';
import '../../view/login/view.dart';
import '../../view/signUp/bindings.dart';
import '../../view/signUp/view.dart';
import '../../view/splash/bindings.dart';
import '../../view/splash/view.dart';
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
    GetPage(name: RouteNames.addfileshowcontainer, page:()=> addFileShowContainer(date: "",
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

