import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:school_hub/controller/authcontroller.dart';
import 'package:school_hub/view/admin_home.dart';
import 'package:school_hub/view/admin_login.dart';
import 'package:school_hub/view/homeView.dart';
import 'package:school_hub/view/loginScreen.dart';
import 'package:school_hub/view/otp_screen.dart';
import 'package:school_hub/view/profileView.dart';
import 'package:school_hub/view/roleSelectionView.dart';
import 'package:school_hub/view/signupScreen.dart';
import 'package:school_hub/view/stundent_approval.dart';
import 'package:school_hub/view/upload_result.dart';

import 'controller/adminController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyC0x0RlW7B6BJAQuuk-BvOLRVKoJHcqW5o',
          appId: '1:744175678777:android:457ab4d35150dd7a2ba4e8',
          messagingSenderId: '744175678777',
          projectId: "schoolhub-3ea9d",
          storageBucket: "schoolhub-3ea9d.appspot.com"));
  Get.put(AuthController());
  Get.put(AdminController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'School Management System',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

class AppPages {
  static const INITIAL = Routes.ROLE_SELECTION;

  static final routes = [
    GetPage(name: Routes.ROLE_SELECTION, page: () => RoleSelectionView()),
    GetPage(name: Routes.STUDENT_LOGIN, page: () => StudentLoginView()),
    GetPage(name: Routes.STUDENT_SIGNUP, page: () => SignupView()),
    GetPage(name: Routes.STUDENT_HOME, page: () => HomeView()),
    GetPage(name: Routes.STUDENT_PROFILE, page: () => ProfileView()),
    GetPage(name: Routes.ADMIN_HOME, page: () => AdminHomeView()),
    GetPage(name: Routes.STUDENT_APPROVAL, page: () => StudentApprovalView()),
    GetPage(name: Routes.UPLOAD_RESULT, page: () => UploadResultView()),
    //  GetPage(name: Routes.OTP_VERIFICATION, page: () => OTPVerificationView()),
  ];
}

abstract class Routes {
  static const ROLE_SELECTION = '/';
  static const STUDENT_LOGIN = '/student/login';
  static const STUDENT_SIGNUP = '/student/signup';
  static const STUDENT_HOME = '/student/home';
  static const STUDENT_PROFILE = '/student/profile';
  static const ADMIN_HOME = '/admin/home';
  static const STUDENT_APPROVAL = '/admin/student-approval';
  static const UPLOAD_RESULT = '/admin/upload-result';
  static const String OTP_VERIFICATION = '/otp-verification';
}
