import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/firebase_options.dart';
import 'package:khouyot/khouyot.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/di/Dependency_inj.dart';
import 'package:khouyot/core/routing/app_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await CashHelper.init();
   await ScreenUtil.ensureScreenSize();
  await setupGetIt();
  
 
 

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('fa3aa017-116d-4aa3-be3f-2eae5aa014b3');
  OneSignal.Notifications.requestPermission(true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 
  
  runApp(khouyot(
    appRouter: AppRouter(),
  ));
}

