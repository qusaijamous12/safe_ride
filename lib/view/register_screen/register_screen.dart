
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../shared/config/resources/color_manger.dart';
import '../../shared/config/resources/font_manger.dart';
import '../../shared/config/resources/padding_manger.dart';
import '../../shared/config/resources/style_manger.dart';
import '../../shared/config/utils/utils.dart';
import '../../shared/widgets/my_button.dart';
import '../login_screen/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();

  final _userController = Get.find<UserController>(tag: 'user_controller');

  bool isObsecure = true;
  String? selectedGender;


  final genderOptions = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details) {
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
                  'Sign Up',
                  style: getMyMediumTextStyle(color: ColorManger.kPrimary, fontSize: FontSize.s20 * 1.5),
                ),
                const SizedBox(height: PaddingManger.kPadding),

                // User Name Field
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                    color: ColorManger.grey2,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      prefixIcon: Icon(Icons.person_outline_sharp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: PaddingManger.kPadding),

                // Email Field
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                    color: ColorManger.grey2,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: PaddingManger.kPadding),

                // Password Field
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                    color: ColorManger.grey2,
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
                        child: Icon(isObsecure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: PaddingManger.kPadding),

                // Mobile Phone Field
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                    color: ColorManger.grey2,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Mobile Phone',
                      prefixIcon: Icon(Icons.phone),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: PaddingManger.kPadding),


                // Age Field
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                    color: ColorManger.grey2,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      prefixIcon: Icon(Icons.numbers),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: PaddingManger.kPadding),




                // Gender Dropdown
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                    color: ColorManger.grey2,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    items: genderOptions.map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      prefixIcon: Icon(Icons.accessibility),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: PaddingManger.kPadding * 1.5),

               Obx(() => ConditionalBuilder(
                  condition: _userController.isLoading,
                  builder: (context) => Center(child: CircularProgressIndicator(color: ColorManger.kPrimary)),
                  fallback: (context) => MyButton(
                    title: 'Register',
                    onTap: () async {
                      if (_phoneController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _nameController.text.isNotEmpty &&
                          _ageController.text.isNotEmpty &&
                          selectedGender != null) {
                        await _userController.register(
                          email: _emailController.text,
                          name: _nameController.text,
                          password: _passwordController.text,
                          age: _ageController.text,
                          gender: selectedGender!,
                          mobileNumber: _phoneController.text,
                          status: 0
                        );
                        _nameController.clear();
                        _emailController.clear();
                        _passwordController.clear();
                        _phoneController.clear();
                        _ageController.clear();
                      } else {
                        print('qusai usai');
                        Utils.myToast(title: 'All Fields Required');
                      }
                    },
                    btnColor: ColorManger.kPrimary,
                    textColor: Colors.white,
                  ),
                )),

                const SizedBox(height: PaddingManger.kPadding / 2),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAll(() => const LoginScreen());
                      },
                      child: Text(
                        'Login',
                        style: getMyMediumTextStyle(color: ColorManger.kPrimary),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

