
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:safe_ride/shared/widgets/my_button.dart';
import 'package:safe_ride/view/users_home_screen/tab_bar_users.dart';

import '../../controller/user_controller.dart';
import '../../shared/config/resources/color_manger.dart';
import '../../shared/config/resources/font_manger.dart';
import '../../shared/config/resources/padding_manger.dart';
import '../../shared/config/resources/style_manger.dart';
import '../../shared/config/utils/utils.dart';
import '../../shared/widgets/my_text_field.dart';
import '../register_screen/register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = Get.find<UserController>(tag: 'user_controller');

  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details){
        Utils.hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: ColorManger.kPrimaryTwo,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding),
            child: Column(
              children: [
                SvgPicture.asset('assets/images/logo.svg',height: 350,),
                Text(
                  'Sign in',
                  style: getMyMediumTextStyle(color: ColorManger.kPrimary,
                      fontSize: FontSize.s20 * 1.5),
                ),
                const SizedBox(
                  height: PaddingManger.kPadding,
                ),

                MyTextField(controller: _emailController, labelText: 'Email Address', prefixIcon: Icon(Icons.email_outlined)),
                const SizedBox(
                  height: PaddingManger.kPadding,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                          PaddingManger.kPadding),
                      color: ColorManger.grey2
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextFormField(
                    obscureText: isObsecure,
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                            child: Icon(
                                isObsecure ? Icons.visibility_off_outlined : Icons
                                    .visibility_outlined)),
                        border: InputBorder.none


                    ),
                  ),
                ),
                const SizedBox(
                  height: PaddingManger.kPadding,
                ),
                GestureDetector(
                  onTap: ()async{
                    if(_emailController.text.isNotEmpty){
                      await _userController.forgetPassword(email: _emailController.text);

                    }else{
                      Utils.myToast(title: 'Please Write Your Email !');
                    }

                  },
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Forget Password',

                      style: getMyRegulerTextStyle(color: ColorManger.kPrimary,textDecoration: TextDecoration.underline),
                    ),
                  ),
                ),
                const SizedBox(
                  height: PaddingManger.kPadding * 1.5,
                ),

                Obx(()=>ConditionalBuilder(
                  condition: _userController.isLoading,
                  builder: (context)=>Center(child: CircularProgressIndicator(color: ColorManger.kPrimary,)),
                  fallback: (context)=> MyButton(title: 'Login', onTap: ()async{
                    if(_emailController.text.isNotEmpty&&_passwordController.text.isNotEmpty){
                      await _userController.loginWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                    }
                    else{
                      Utils.myToast(title: 'All Field Requierd');
                    }
                  }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
                )),




                const SizedBox(
                  height: PaddingManger.kPadding / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an Account?',
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                    TextButton(onPressed: () {
                      Get.offAll(() => const RegisterScreen());
                    }, child: Text(
                      'Register',
                      style: getMyMediumTextStyle(color: ColorManger.kPrimary),
                    ))
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
