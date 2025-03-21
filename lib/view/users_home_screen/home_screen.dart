import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_ride/controller/map_controller.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/shared/config/resources/color_manger.dart';
import 'package:safe_ride/shared/config/resources/font_manger.dart';
import 'package:safe_ride/shared/config/resources/style_manger.dart';
import 'package:safe_ride/shared/config/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_ride/view/users_home_screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userController = Get.find<UserController>(tag: 'user_controller');
  final _mapController=Get.find<MapController>(tag: 'map_controller');




  @override
  void initState() {
    if(_userController.userModel?.status==0){
      Future.delayed(Duration.zero,()async{
        await _userController.getAllDrivers();
      });
    }else{
      Future.delayed(Duration.zero,()async{
        await _userController.getAllUsers();
      });
    }

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(isLoading: _userController.isLoading, child: GestureDetector(
      onTap: () {
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details) {
        Utils.hideKeyboard(context);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(20),
            decoration: BoxDecoration(
              color: ColorManger.kPrimary,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(20),
                bottomEnd: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Welcome',
                      style: getMyMediumTextStyle(
                        color: Colors.white,
                        fontSize: FontSize.s20,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=> SearchScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search,
                          color: ColorManger.kPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Hello ${_userController.userModel?.status==2 ?'Driver':''} ${_userController.userModel?.userName?.capitalizeFirst}',
                  style: getMyRegulerTextStyle(
                    color: Colors.white,
                    fontSize: FontSize.s16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>const SearchScreen());

                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 10,horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        Icon(Icons.search,color: ColorManger.kPrimary,),
                        const  SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Search',
                          style: getMyRegulerTextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(_userController.userModel!.latitude.toString()), double.parse(_userController.userModel!.longitude.toString())),  // Use coordinates of the location you want to display
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {

              },
              markers: _userController.driverMarkers.toSet(),
            ),
          )
        ],
      ),
    )));
  }
}

