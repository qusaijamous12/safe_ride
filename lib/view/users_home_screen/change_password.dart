import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_ride/shared/config/resources/color_manger.dart';
import 'package:safe_ride/shared/config/resources/padding_manger.dart';
import 'package:safe_ride/shared/widgets/my_app_bar.dart';
import 'package:safe_ride/shared/widgets/my_button.dart';
import 'package:safe_ride/shared/widgets/my_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPassword=TextEditingController();
  final _newPassword=TextEditingController();
  final _confirmNewPassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Change Password Screen'),
      body: Padding(
        padding: const EdgeInsets.all(PaddingManger.kPadding),
        child: Column(
          children: [
            MyTextField(controller: _confirmNewPassword, labelText: 'Current Password', prefixIcon: Icon(Icons.lock_open_outlined)),
            const SizedBox(
              height: 20,
            ),
            MyTextField(controller: _newPassword, labelText: 'New Password', prefixIcon: Icon(Icons.lock_open_outlined)),
            const SizedBox(
              height: 20,
            ),
            MyTextField(controller: _confirmNewPassword, labelText: 'Confirm New Password', prefixIcon: Icon(Icons.lock_open_outlined)),
            const SizedBox(
              height: 40,
            ),
            MyButton(title: 'Submit', onTap: (){}, btnColor: ColorManger.kPrimary, textColor: Colors.white)

          ],
        ),
      ),
    );
  }
}
