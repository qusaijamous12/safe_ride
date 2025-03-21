import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/shared/config/resources/padding_manger.dart';
import 'package:safe_ride/shared/config/resources/style_manger.dart';
import 'package:safe_ride/view/admin_home_screen/contact_us_messages_screen.dart';

import '../../shared/config/resources/color_manger.dart';
import '../login_screen/login_screen.dart';
import 'adding_driver_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  final _userController=Get.find<UserController>(tag: 'user_controller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home Screen',style: getMySemiBoldTextStyle(color: Colors.white),),
        backgroundColor: ColorManger.kPrimary,
        actions: [
          IconButton(onPressed: (){
            Get.offAll(()=>const LoginScreen());
          }, icon:const Icon(Icons.logout,color: Colors.white,)),
          IconButton(onPressed: (){
            Get.to(()=>const ContactUsMessagesScreen());
          }, icon:const Icon(Icons.message,color: Colors.white,)),


        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PaddingManger.kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Admin ',
                style: getMySemiBoldTextStyle(color: Colors.black,fontSize: 25),
              ),
              const  Spacer(),
              Text(
                'Please Move With The Following Steps to Add a Driver ',
                style: getMyMediumTextStyle(color: ColorManger.grey),
              ),
              const Spacer(),
              CarouselSlider(
                items: [
                  Image.network('https://www.tennessean.com/gcdn/presto/2019/12/06/PNAS/ff2d50c2-eafd-44d8-abc1-5af3c590374c-NAS-SEASON_TO_GIVE-_BUS_DRIVER-02.jpg'),
                  Image.network('https://media.istockphoto.com/id/1481399731/photo/happy-bus-driver-standing-with-arms-crossed-at-looking-at-camera.jpg?s=612x612&w=0&k=20&c=zUuNuAsEWOXISMqgxB1ayr3XhtPygikeWSy90i4V71M='),
                ],
                options: CarouselOptions(
                  height: 400,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval:const Duration(seconds: 3),
                  autoPlayAnimationDuration:const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),),
              const Spacer(),
              Text(
                'In the next screen, you will be prompted to enter the Driver name, email, and other important information. Make sure the information is accurate to help users find the Driver easily.',
                textAlign: TextAlign.center,
                style: getMyRegulerTextStyle(color: ColorManger.grey),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(onPressed: (){
                    Get.to(()=>const AddingStationOwnerScreen());

                  },backgroundColor: ColorManger.kPrimary,child: Icon(Icons.arrow_forward_ios,color: Colors.white,),)
                ],
              )






            ],
          ),
        ),
      ),
    )
    ;
  }
}
