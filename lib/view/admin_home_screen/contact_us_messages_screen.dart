import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_ride/model/message_model.dart';
import 'package:safe_ride/shared/config/resources/color_manger.dart';
import 'package:safe_ride/shared/config/resources/style_manger.dart';
import 'package:safe_ride/shared/widgets/my_app_bar.dart';
import 'package:safe_ride/shared/widgets/no%20friends.dart';

class ContactUsMessagesScreen extends StatefulWidget {
  const ContactUsMessagesScreen({super.key});

  @override
  State<ContactUsMessagesScreen> createState() =>
      _ContactUsMessagesScreenState();
}

class _ContactUsMessagesScreenState extends State<ContactUsMessagesScreen> {
  final  _messageAdmin = RxList<MessageAdminModel>([]);
  final _isLoading = RxBool(false);

  @override
  void initState() {
   _isLoading(true);
    Future.delayed(Duration.zero, () async {
      final result =
          await FirebaseFirestore.instance.collection('messages').get();
      result.docs.forEach((element) {
        _messageAdmin.add(MessageAdminModel.fromJson(element.data()));
      });
    });

 _isLoading(false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(
      progressIndicator: CircularProgressIndicator(
        color: ColorManger.kPrimary,
      ),
      isLoading: _isLoading.value,
      child: Scaffold(
        appBar: myAppBar(title: 'Contact Us Messages'),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_messageAdmin.isNotEmpty) ...[
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index)=>buildMessage(_messageAdmin[index]),
                      separatorBuilder: (context,index)=>const SizedBox(height: 15,),
                      itemCount: _messageAdmin.length),
                )
              ]
              else...[
                Spacer(),
                NoUsers(title: 'There is No Messages'),
                Spacer(),

              ]
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildMessage(MessageAdminModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(model.profileImage),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.userName,
                  style: getMyMediumTextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Email : ${model.email}',
                  style: getMyRegulerTextStyle(color: ColorManger.grey),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Messages : ${model.message} ',
          textAlign: TextAlign.justify,
          style: getMyMediumTextStyle(color: ColorManger.grey),
        )
      ],
    );
  }
}
