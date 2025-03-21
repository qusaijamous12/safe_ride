import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:safe_ride/controller/app_controller.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/shared/config/resources/color_manger.dart';
import 'package:safe_ride/shared/widgets/my_app_bar.dart';

class TabBarUsersScreen extends StatefulWidget {
  const TabBarUsersScreen({super.key});

  @override
  State<TabBarUsersScreen> createState() => _TabBarUsersScreenState();
}

class _TabBarUsersScreenState extends State<TabBarUsersScreen> {
  final _appController=Get.find<AppController>(tag: 'app_controller');
  final _userController=Get.find<UserController>(tag: 'user_controller');
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManger.kPrimary
        ),
      ),
      body: _appController.screens[_appController.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _appController.currentIndex,
          onTap: (index){
            _appController.changeScreen(index);
          },
          selectedItemColor: Colors.white,
          backgroundColor: ColorManger.kPrimary,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home Screen'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp,),label: _userController.userModel?.status==0? 'Drivers':'Users'),
            BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Setting'),

          ]
      ),
    ));
  }
}
