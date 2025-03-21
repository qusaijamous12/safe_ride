import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/model/user_model.dart';
import 'package:safe_ride/shared/widgets/my_app_bar.dart';

import '../../model/message_model.dart';
import '../../shared/config/resources/color_manger.dart';
import '../../shared/config/resources/font_manger.dart';
import '../../shared/config/resources/style_manger.dart';
import '../../shared/config/utils/utils.dart';

class ChatScreen extends StatefulWidget {
  final UserModel userModel;
  const ChatScreen({super.key,required this.userModel});


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _userController = Get.find<UserController>(tag: 'user_controller');

  final _messageController = TextEditingController();

  final _scrollController = ScrollController();  // Add a scroll controller


  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _userController.getMessages(receiverId: widget.userModel.uid??'');
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the controller when the widget is disposed.
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details) {
        Utils.hideKeyboard(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Messages'.tr,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorManger.kPrimary,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              Expanded(
                child: Container(
                  padding: const EdgeInsetsDirectional.all(20),
                  decoration: BoxDecoration(
                      color: ColorManger.kPrimary.withOpacity(0.5),
                      borderRadius: BorderRadiusDirectional.circular(20)),

                  child: SingleChildScrollView(
                    controller: _scrollController,

                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(widget.userModel.profileImage??''),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.userModel.userName??'',
                          style: getMyMediumTextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (_userController.listChatModel[index].senderId !=
                                  _userController.userModel?.uid) {
                                return buildMessage(
                                    _userController.listChatModel[index]);
                              } else {
                                return buildMyMessage(
                                    _userController.listChatModel[index]);
                              }
                            },
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 20,
                            ),
                            itemCount: _userController.listChatModel.length),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(start: 7),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // DoctorCubit.get(context).openGalaryToSendImage();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: 'Write Your Message Here'.tr,
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      color: ColorManger.kPrimary,
                      height: 60,
                      width: 60,
                      child: IconButton(
                          onPressed: () {
                            if (_messageController.text.isNotEmpty) {
                              _userController.sendMessage(
                                  receiverId: widget.userModel.uid??'',
                                  dateTime: DateTime.now().toString(),
                                  text: _messageController.text,
                                  profileImage: _userController
                                      .userModel?.profileImage ??
                                      '');
                              _messageController.clear();
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            } else {
                              Utils.myToast(title: 'Message is Requierd');
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildMessage(ChatModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Row(
      mainAxisSize: MainAxisSize.min, // Make Row shrink to fit content
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(widget.userModel.profileImage??''),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          // Ensure the container takes only necessary width based on content
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.text ?? '',
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.visible,
                  // Allow text to extend without clipping
                  softWrap: true, // Enable text wrapping
                ),
                Text(
                  model.dateTime?.substring(10,16) ?? '',
                  style: getMyLightTextStyle(
                      color: ColorManger.grey, fontSize: FontSize.s14),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildMyMessage(ChatModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Row(
      textDirection: TextDirection.rtl,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(_userController.userModel!.profileImage??''),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          // Ensure the container takes only necessary width based on content
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: ColorManger.kPrimary,
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.text ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  overflow: TextOverflow.visible,
                  // Allow text to extend without clipping
                  softWrap: true, // Enable text wrapping
                ),
                Text(
                  model.dateTime ?? '',
                  style: getMyLightTextStyle(
                      color: Colors.white, fontSize: FontSize.s14),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
