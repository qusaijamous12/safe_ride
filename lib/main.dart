import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_ride/controller/app_controller.dart';
import 'package:safe_ride/controller/map_controller.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/view/splash_screen/splash_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(MapController(),tag: 'map_controller');

  Get.put(UserController(),tag: 'user_controller');
  Get.put(AppController(),tag: 'app_controller');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: const SplashScreen(),
    );
  }
}

