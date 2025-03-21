import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:safe_ride/view/users_home_screen/home_screen.dart';
import 'package:safe_ride/view/users_home_screen/setting_screen.dart';
import 'package:safe_ride/view/users_home_screen/drivers_scrceen/driver_screen.dart';

class AppController extends GetxController{

  final _currentIndex=RxInt(0);

  final _screens=RxList<Widget>([
    HomeScreen(),
    DriverScreen(),
    SettingScreen()
  ]);

  void changeScreen(final int currentIndex){
    _currentIndex(currentIndex);
  }


  int get currentIndex=>_currentIndex.value;

  List<Widget> get screens=>_screens;




}