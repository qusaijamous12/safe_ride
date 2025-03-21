import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/shared/config/resources/color_manger.dart';
import 'package:safe_ride/shared/utils/utils.dart';
import 'package:safe_ride/shared/widgets/my_app_bar.dart';
import 'package:safe_ride/shared/widgets/my_button.dart';
import 'package:safe_ride/shared/widgets/my_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userController = Get.find<UserController>(tag: 'user_controller');
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _uidController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    _nameController.text = _userController.userModel!.userName??'';
    _emailController.text = _userController.userModel!.email??'';
    _uidController.text = _userController.userModel!.uid??'';
    _genderController.text = _userController.userModel!.gender??'';
    _phoneController.text = _userController.userModel!.phoneNumber??'';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (detaisl) {
        Utils.hideKeyboard(context);
      },
      child: Scaffold(
        appBar: myAppBar(title: 'Profile Screen'),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      NetworkImage(_userController.userModel!.profileImage??''),
                  backgroundColor: ColorManger.kPrimary,
                ),
                const SizedBox(
                  height: 40,
                ),
                MyTextField(
                    controller: _nameController,
                    labelText: 'User Name',
                    prefixIcon: Icon(Icons.person_outline_sharp)),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: _emailController,
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined),
                  enabled: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: _phoneController,
                  labelText: 'Mobile Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: _genderController,
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.transgender),
                  enabled: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: _uidController,
                  labelText: 'User Id',
                  prefixIcon: Icon(Icons.phone),
                  enabled: false,
                ),
                const SizedBox(
                  height: 30,
                ),
          Obx(()=>      ConditionalBuilder(
              condition: _userController.isLoading,
              builder: (context)=>Center(child: CircularProgressIndicator(color: ColorManger.kPrimary,)),
              fallback: (context)=>MyButton(title: 'Update', onTap: ()async{
                if(_nameController.text.isNotEmpty&&_phoneController.text.isNotEmpty){
                  await _userController.updateUserData(phone: _phoneController.text,userName: _nameController.text);
                }
                else{
                  Utils.myToast(title: 'User Name and Mobile Number must not be empty ! ');
                }


              }, btnColor: ColorManger.kPrimary, textColor: Colors.white)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
