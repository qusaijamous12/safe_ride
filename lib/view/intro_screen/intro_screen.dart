
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../shared/config/resources/color_manger.dart';
import '../../shared/config/resources/padding_manger.dart';
import '../../shared/widgets/my_button.dart';
import '../login_screen/login_screen.dart';
import '../register_screen/register_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.kPrimaryTwo,
      body: Padding(
        padding: const EdgeInsets.all(PaddingManger.kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Expanded(
              child: Center(
                child: SvgPicture.asset('assets/images/logo.svg'),
              ),
            ),
            MyButton(title: 'Login', onTap: (){
              Get.offAll(()=>const LoginScreen());
            }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
            const SizedBox(
              height: PaddingManger.kPadding/2,
            ),
            MyButton(title: 'Register', onTap: (){
              Get.offAll(()=>const RegisterScreen());
            }, btnColor: Colors.white, textColor:ColorManger.kPrimary),

          ],
        ),
      ),
    );
  }
}
