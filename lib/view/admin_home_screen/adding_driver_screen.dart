import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/shared/config/resources/padding_manger.dart';
import 'package:safe_ride/shared/config/resources/style_manger.dart';
import 'package:safe_ride/shared/widgets/my_app_bar.dart';

import '../../shared/config/resources/color_manger.dart';
import '../../shared/config/utils/utils.dart';
import '../../shared/widgets/my_button.dart';

class AddingStationOwnerScreen extends StatefulWidget {
  const AddingStationOwnerScreen({super.key});

  @override
  State<AddingStationOwnerScreen> createState() =>
      _AddingStationOwnerScreenState();
}

class _AddingStationOwnerScreenState extends State<AddingStationOwnerScreen> {
  final _userController = Get.find<UserController>(tag: 'user_controller');
  final _userNameController = TextEditingController();
  final _ageController = TextEditingController();

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _driverPasswordController = TextEditingController();
  final _driverDescription=TextEditingController();

  String? selectedGender;

  final genderOptions = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:myAppBar(title: 'Add Driver'),
      body: GestureDetector(
        onTap: () {
          Utils.hideKeyboard(context);
        },
        onVerticalDragDown: (details) {
          Utils.hideKeyboard(context);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please Fill The Following Fields To Add Driver',
                style: getMyMediumTextStyle(color: ColorManger.lightGrey),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Driver Name',
                style: getMySemiBoldTextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: ColorManger.grey2),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _userNameController,
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Driver Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Driver Email',
                style: getMySemiBoldTextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: ColorManger.grey2),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Driver Email',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Diver PhoneNumber',
                style: getMySemiBoldTextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: ColorManger.grey2),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Driver Mobile Number',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Driver Password',
                style: getMySemiBoldTextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: ColorManger.grey2),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _driverPasswordController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Driver Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadiusDirectional.circular(PaddingManger.kPadding),
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
              const SizedBox(
                height: 16,
              ),
              Text(
                'Driver Age',
                style: getMySemiBoldTextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: ColorManger.grey2),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Driver Age',
                    prefixIcon: Icon(Icons.numbers),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Driver Description',
                style: getMySemiBoldTextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: ColorManger.grey2),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _driverDescription,
                  minLines: 1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Driver Description',
                    prefixIcon: Icon(Icons.description),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => ConditionalBuilder(
                  condition: _userController.isLoading,
                  builder: (context)=>Center(child: CircularProgressIndicator(color: ColorManger.kPrimary,)),
                  fallback: (context)=> MyButton(

                    btnColor: ColorManger.kPrimary,
                    title: 'Submit',
                    textColor: Colors.white,
                    onTap: ()async{
                      if(_userNameController.text.isNotEmpty&&_emailController.text.isNotEmpty&&_ageController.text.isNotEmpty&&_driverPasswordController.text.isNotEmpty&&_driverDescription.text.isNotEmpty){
                        await _userController.register(email: _emailController.text, name: _userNameController.text, password: _driverPasswordController.text, age: _ageController.text, mobileNumber: _phoneController.text, gender: selectedGender??'Male',status: 2,driverDescription: _driverDescription.text);
                      }else{
                        Utils.myToast(title: 'All Fields are required');
                      }
                      _driverDescription.clear();
                      _userNameController.clear();
                      _emailController.clear();
                      _phoneController.clear();
                      _driverPasswordController.clear();
                      _ageController.clear();

                    },)))
            ],
          ),
        ),
      ),
    );
  }
}
