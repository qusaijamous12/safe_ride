import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/model/user_model.dart';
import 'package:safe_ride/shared/resources/style_manger.dart';
import 'package:safe_ride/shared/widgets/my_app_bar.dart';
import 'package:safe_ride/shared/widgets/my_button.dart';
import 'package:safe_ride/view/users_home_screen/chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/config/resources/color_manger.dart';
import '../../../shared/config/utils/utils.dart';
import '../../../shared/widgets/my_text_field.dart';

class DriverDetailsScreen extends StatefulWidget {
  final UserModel userModel;
  const DriverDetailsScreen({super.key,required this.userModel});

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  final _uidController=TextEditingController();
  final _genderController=TextEditingController();
  final _phoneNumber=TextEditingController();
  final _userController=Get.find<UserController>(tag: 'user_controller');

  @override
  void initState() {
    _nameController.text=widget.userModel.userName??'';
    _emailController.text=widget.userModel.email??'';
    _uidController.text=widget.userModel.uid??'';
    _genderController.text=widget.userModel.gender??'';
    _phoneNumber.text=widget.userModel.phoneNumber??'';
    super.initState();
  }

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
        appBar: myAppBar(title: 'Profile Screen'),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(widget.userModel.profileImage??''),
                  backgroundColor: ColorManger.kPrimary,
                ),
                const SizedBox(
                  height: 40,
                ),
                MyTextField(controller: _nameController, labelText: 'User Name', prefixIcon: Icon(Icons.person_outline_sharp),enabled: false,),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(controller: _emailController, labelText: 'Email Address', prefixIcon: Icon(Icons.email_outlined),enabled: false,),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(controller: _uidController, labelText: 'Driver Id', prefixIcon: Icon(Icons.numbers),enabled: false,),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(controller: _genderController, labelText: 'Driver Gender', prefixIcon: Icon(Icons.transgender),enabled: false,),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(child: MyTextField(controller: _phoneNumber, labelText: 'Phone Number', prefixIcon: Icon(Icons.phone),enabled: false,)),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: ()async{
                      String phoneNumber = _phoneNumber.text;
                      if (phoneNumber.isNotEmpty) {
                        // Initiate the phone call by opening the dialer
                        String url = 'tel:$phoneNumber';
                        if (await canLaunch(url)) {
                      await launch(url);
                      } else {
                      // Handle error: cannot launch the dialer
                      print("Cannot launch dialer");
                      }
                    }

                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: ColorManger.kPrimary,
                      child:   Icon(Icons.phone,color: Colors.white,),
                    ),
                  )

                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Driver Location',
                    style: getMyMediumTextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                  ),
                  child: GoogleMap(
                      initialCameraPosition:CameraPosition(
                    zoom: 14,
                      target:LatLng(double.parse(widget.userModel.latitude.toString()), double.parse(widget.userModel.longitude.toString()))
                  ),
                    markers: <Marker>{
                        Marker(markerId: MarkerId(widget.userModel.uid??''),position: LatLng(double.parse(widget.userModel.latitude.toString()), double.parse(widget.userModel.longitude.toString())),icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange))
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [

                    Expanded(
                      child: MyButton(title: 'Chat', onTap: (){
                        Get.to(()=> ChatScreen(userModel: widget.userModel,));

                      }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
                    ),
                    if(_userController.userModel?.status==2)...[
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MyButton(title: 'Student Location', onTap: ()async{
                          await FirebaseFirestore.instance.collection('users').doc(widget.userModel.uid).update({
                            'is_user_ready':false
                          });
                          openDirections(double.parse(_userController.userModel!.latitude.toString()), double.parse(_userController.userModel!.longitude.toString()), double.parse(widget.userModel.latitude.toString()), double.parse(widget.userModel.longitude.toString()));
                        }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
                      ),
                    ]
                  ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
  void openDirections(double startLat, double startLng, double endLat, double endLng) async {
    // Construct the Google Maps URL for directions from start to end
    final String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&origin=$startLat,$startLng&destination=$endLat,$endLng&travelmode=driving";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);  // Open Google Maps with directions
    } else {
      throw 'Could not open Google Maps';
    }
  }
}
