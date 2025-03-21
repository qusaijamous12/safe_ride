import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/shared/config/resources/color_manger.dart';
import 'package:safe_ride/shared/config/resources/padding_manger.dart';
import 'package:safe_ride/shared/config/resources/style_manger.dart';
import 'package:safe_ride/shared/widgets/my_app_bar.dart';
import 'package:safe_ride/shared/widgets/my_button.dart';

import '../../shared/config/utils/utils.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _userController=Get.find<UserController>(tag: 'user_controller');
  final _messageController=TextEditingController();
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
        appBar: myAppBar(title: 'Contact Us Screen'),
        body: Padding(
          padding: const EdgeInsets.all(PaddingManger.kPadding),
          child: Column(
            children: [
              Text(
                'Please Fill the following field to send message to the support team...',
                style: getMyMediumTextStyle(color: ColorManger.grey),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: ColorManger.kPrimary.withOpacity(0.3)
                ),
                child: TextFormField(
                  minLines:1,
                  maxLines: null,
                  controller:_messageController ,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: InputBorder.none
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: MyButton(title: 'Send', onTap: ()async{
                  if(_messageController.text.isEmpty){
                    Utils.myToast(title: 'Please Enter your message !');
                  }
                  else{

                    await FirebaseFirestore.instance.collection('messages').add({
                      'message':_messageController.text,
                      'user':_userController.userModel?.userName,
                      'email':_userController.userModel?.email,
                      'uid':_userController.userModel?.uid,
                      'profile_image':_userController.userModel?.profileImage
                    }).then((value){
                      Utils.myToast(title: 'Send Success !');
                      _messageController.clear();

                    }).catchError((error){
                      Utils.myToast(title: 'Check Your Internet !');
                    });
                  }
                }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
