import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/model/user_model.dart';
import 'package:safe_ride/shared/config/resources/color_manger.dart';
import 'package:safe_ride/shared/config/resources/font_manger.dart';
import 'package:safe_ride/shared/config/resources/padding_manger.dart';
import 'package:safe_ride/shared/config/resources/style_manger.dart';
import 'package:safe_ride/shared/widgets/my_button.dart';
import 'package:safe_ride/shared/widgets/no%20friends.dart';

import '../../../shared/config/utils/utils.dart';
import 'driver_details.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  final _userController=Get.find<UserController>(tag: 'user_controller');

  @override
  void initState() {
    if(_userController.userModel?.status==0){
      Future.delayed(Duration.zero,()async{
        await _userController.getAllDrivers();
      });

    }
    else{
      Future.delayed(Duration.zero,()async{
        await _userController.getAllUsers();
      });

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(isLoading: _userController.isLoading, child: Padding(
      padding: const EdgeInsets.all(PaddingManger.kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_userController.userModel?.status==0 ? ' Driver Screen':'Users Screen'}',
            style: getMyMediumTextStyle(color: Colors.black,fontSize: FontSize.s20),
          ),
          Text(
            'Choose your ${_userController.userModel?.status==0?'Driver':'User'} to start the safe ride !',
            style: getMyRegulerTextStyle(color: ColorManger.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          if(_userController.userModel?.status==0)...[
            if (_userController.allDrivers.isNotEmpty) ...[
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context,index)=>buildUserItem(_userController.allDrivers[index]),
                    separatorBuilder: (context,index)=>const SizedBox(
                      height: 15,
                    ),
                    itemCount: _userController.allDrivers.length),
              )
            ]
            else...[
              const Spacer(),
              NoUsers(title: 'There is No Drivers '),
              const Spacer(),

            ],
          ]else...[
            if (_userController.allUsers.isNotEmpty) ...[
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context,index)=>buildUserItem(_userController.allUsers[index]),
                    separatorBuilder: (context,index)=>const SizedBox(
                      height: 15,
                    ),
                    itemCount: _userController.allUsers.length),
              )
            ]
            else...[
              const Spacer(),
              NoUsers(title: 'There is No Users '),
              const Spacer(),

            ],
          ],

          const SizedBox(
            height:40,
          ),
          if(_userController.userModel?.status==0)
          Row(
            children: [
              Expanded(child: MyButton(title: 'Ready', onTap: ()async{
                await FirebaseFirestore.instance.collection('users').doc(_userController.userModel?.uid).update({
                  'is_user_ready':true
                }).then((value){
                  Utils.myToast(title: 'Success');
                });

              }, btnColor: ColorManger.kPrimary, textColor: Colors.white)),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: MyButton(title: 'Not Ready', onTap: ()async{
                await FirebaseFirestore.instance.collection('users').doc(_userController.userModel?.uid).update({
                  'is_user_ready':false
                }).then((value){
                  Utils.myToast(title: 'Success');
                });
              }, btnColor: Colors.white, textColor: ColorManger.kPrimary))


            ],
          )
        ],
      ),
    )));
  }
  Widget buildUserItem(UserModel model) => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(20)
    ),
    child: GestureDetector(
      onTap: (){

        Get.to(()=> DriverDetailsScreen(userModel: model,));

      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(20),

      ),

      child: Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                      model.profileImage??''),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.userName??'',
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                    Text(
                      model.email??'',
                      style: getMyRegulerTextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(model.isOnline??false)...[
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.green,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Online',
                            style: getMyRegulerTextStyle(color: ColorManger.grey),
                          )
                        ],
                      )
                    ]
                    else...[
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.red,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Offline',
                            style: getMyRegulerTextStyle(color: ColorManger.grey),
                          )
                        ],
                      )
                    ],
                    const SizedBox(
                      height: 15,
                    ),
                    if(_userController.userModel?.status==2)...[
                      if(model.isUserReady!)...[
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: ColorManger.kPrimary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'User is Ready',
                              style: getMyRegulerTextStyle(color: ColorManger.grey),
                            )
                          ],
                        )
                      ]
                      else...[
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'User is\'nt Ready',
                              style: getMyRegulerTextStyle(color: ColorManger.grey),
                            )
                          ],
                        )

                      ]

                    ]
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.location_on_outlined,
                  color: ColorManger.kPrimary,
                  size: 30,
                )
              ],
            ),
      ),
    ),
  );

}
