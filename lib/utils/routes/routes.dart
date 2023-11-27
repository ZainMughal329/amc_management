import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/SearchView/dispatchFileSearchView/index.dart';
import 'package:amc_management/view/scanimages/bindings.dart';
import 'package:amc_management/view/scanimages/view.dart';
import 'package:amc_management/view/userView/bindings.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../../view/SearchView/addFilesearchView/bindings.dart';
import '../../view/SearchView/addFilesearchView/view.dart';
import '../../view/SessionView/forgot/bindings.dart';
import '../../view/SessionView/forgot/view.dart';
import '../../view/SessionView/login/bindings.dart';
import '../../view/SessionView/login/view.dart';
import '../../view/SessionView/signUp/bindings.dart';
import '../../view/SessionView/signUp/view.dart';
import '../../view/SessionView/splash/bindings.dart';
import '../../view/SessionView/splash/view.dart';
import '../../view/adminView/addFile/bindings.dart';
import '../../view/adminView/addFile/components/addfileshow.dart';
import '../../view/adminView/addFile/view.dart';
import '../../view/adminView/dispatchFile/bindings.dart';
import '../../view/adminView/dispatchFile/dispatchfileshow.dart';
import '../../view/adminView/dispatchFile/view.dart';
import '../../view/adminView/home_view/bindings.dart';
import '../../view/adminView/home_view/view.dart';
import '../../view/adminView/sendFile/bindings.dart';
import '../../view/adminView/sendFile/view.dart';
import '../../view/adminView/users/bindings.dart';
import '../../view/adminView/users/view.dart';
import '../../view/userView/profile/bindings.dart';
import '../../view/userView/profile/view.dart';
import '../../view/userView/view.dart';
class AppPages {
  static final List<GetPage> routes = [
    GetPage(
        name: RouteNames.splashview,
        page: () => SplashView(),
        binding: SplashBindings(),
      transition: Transition.zoom,



    ),
    GetPage(
        name: RouteNames.loginview,
        page: () => LoginView(),
        binding: LoginBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
        name: RouteNames.forgotview,
        page: () => Forgotview(),
        binding: Forgotbindinsg(),
      transition: Transition.zoom,
    ),
    GetPage(
        name: RouteNames.homeview,
        page: () => HomeView(),
        binding: HomeBindings(),
      transition: Transition.zoom,
    ),

    GetPage(
        name: RouteNames.signupview,
        page: () => SignUpView(),
        binding: SignupBindings(),
      transition: Transition.zoom,
    ),

    GetPage(
        name: RouteNames.profileview,
        page: ()=>ProfileView(),
        binding: profileBindings(),
      transition: Transition.zoom,
    ),

    GetPage(
        name: RouteNames.searchView,
        page: ()=>SearchView(),
        binding: SearchBindings(),
      transition: Transition.zoom,
    ),
    GetPage(name: RouteNames.disptchsearchView, page: ()=>dispatchSearchView(),
    binding: dispatchBindings(),
      transition: Transition.zoom,
    ),

    GetPage(
        name: RouteNames.userlistview,
        page: () => userListView(),
        binding: userBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
        name: RouteNames.addfileview,
        page: () => addFileView(),
        binding: addFileBindings(),
      transition: Transition.zoom,

    ),
    GetPage(name: RouteNames.addfileshowcontainer, page:()=> addFileShowContainer(
        details: "",
        id: "",
        dept: "",
         date: "",
        name: "",
        fileNum: "",
        from: ""),
    binding: addFileBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
        name: RouteNames.dispatchview,
        page: () => dispatchView(),
        binding: dispatchBindings(),
      transition: Transition.zoom,
    ),
    GetPage(name: RouteNames.dispatchfileshowcontainer, page: ()=>dispatchFileShowContainer(
      id: "",
     date: "",
     filenum: "",
     Dept: "",
     details: '',
      recievedBy: "",
      notificationTo: "",
      // img: "",
      // date: "",
      name: "",
    ),
    binding: dispatchBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
        name: RouteNames.scanImage,
        page: () => ScannImageView(),
        binding: ScanImageBindings(),
      transition: Transition.zoom,
    ),
    GetPage(name: RouteNames.chatScreen, page:()=>sendFile(
      name: "",
      img: "",
      recieverId: "",
      email: "",
    ),
    binding: sendFileBindings(),
      transition: Transition.zoom,
    ),

    GetPage(name: RouteNames.userView, page:()=>userView(
      deptName: "",
    ),
    binding: userViewBindings(),
      transition: Transition.zoom,
    )
  ];
}

