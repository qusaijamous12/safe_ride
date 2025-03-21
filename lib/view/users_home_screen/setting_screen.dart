import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/shared/config/resources/color_manger.dart';
import 'package:safe_ride/shared/config/resources/font_manger.dart';
import 'package:safe_ride/shared/config/resources/style_manger.dart';
import 'package:safe_ride/view/login_screen/login_screen.dart';
import 'package:safe_ride/view/users_home_screen/about_us_screen.dart';
import 'package:safe_ride/view/users_home_screen/change_password.dart';
import 'package:safe_ride/view/users_home_screen/contact_us_screen.dart';
import 'package:safe_ride/view/users_home_screen/profile_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _userController=Get.find<UserController>(tag: 'user_controller');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Setting Screen',
            style: getMyMediumTextStyle(color: Colors.black,fontSize: FontSize.s20),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (){
              Get.to(()=>const ProfileScreen());

            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorManger.kPrimary,
                  child: Icon(Icons.person_outline_sharp,color: Colors.white,size: 45,),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Profile',
                  style: getMyMediumTextStyle(color: Colors.black),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            height: 3,
            thickness: 3,
            color: ColorManger.grey2,
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // GestureDetector(
          //   onTap: (){
          //     Get.to(()=>const ChangePasswordScreen());
          //   },
          //   child: Row(
          //     children: [
          //       CircleAvatar(
          //         radius: 30,
          //         backgroundColor: ColorManger.kPrimary,
          //         child: Icon(Icons.lock_open_outlined,color: Colors.white,size: 45,),
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       Text(
          //         'Change Password',
          //         style: getMyMediumTextStyle(color: Colors.black),
          //       ),
          //       Spacer(),
          //       Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Divider(
          //   height: 3,
          //   thickness: 3,
          //   color: ColorManger.grey2,
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   children: [
          //     CircleAvatar(
          //       radius: 30,
          //       backgroundColor: ColorManger.kPrimary,
          //       child: Icon(Icons.dark_mode_outlined,color: Colors.white,size: 45,),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Text(
          //       'Dark Theme ',
          //       style: getMyMediumTextStyle(color: Colors.black),
          //     ),
          //     Spacer(),
          //     Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
          //   ],
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Divider(
          //   height: 3,
          //   thickness: 3,
          //   color: ColorManger.grey2,
          // ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Get.to(()=>const ContactUsScreen());
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorManger.kPrimary,
                  child: Icon(Icons.email_outlined,color: Colors.white,size: 45,),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Contact Us',
                  style: getMyMediumTextStyle(color: Colors.black),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            height: 3,
            thickness: 3,
            color: ColorManger.grey2,
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Get.to(()=>const AboutUsScreen());
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorManger.kPrimary,
                  child: Icon(Icons.info_outline,color: Colors.white,size: 45,),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'About Us',
                  style: getMyMediumTextStyle(color: Colors.black),
                ),
                Spacer(),

                Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            height: 3,
            thickness: 3,
            color: ColorManger.grey2,
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: ()async{
              await FirebaseFirestore.instance.collection('users').doc(_userController.userModel?.uid).update({
                'is_online':false
              });

              Get.offAll(()=>const LoginScreen());
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorManger.kPrimary,
                  child: Icon(Icons.logout,color: Colors.white,size: 45,),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'LogOut',
                  style: getMyMediumTextStyle(color: Colors.black),
                ),
                Spacer(),

                Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
              ],
            ),
          )

        ],
      ),
    );
  }
}
