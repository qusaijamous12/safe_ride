import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_ride/controller/user_controller.dart';
import 'package:safe_ride/shared/config/resources/padding_manger.dart';
import 'package:safe_ride/shared/widgets/my_app_bar.dart';
import 'package:safe_ride/shared/widgets/my_text_field.dart';
import 'package:safe_ride/shared/widgets/no%20friends.dart';

import '../../model/user_model.dart';
import '../../shared/config/resources/color_manger.dart';
import '../../shared/config/resources/style_manger.dart';
import 'drivers_scrceen/driver_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _userController = Get.find<UserController>(tag: 'user_controller');
  final _searchController = TextEditingController();
  List<UserModel> filteredUsers = [];

  void initState() {
    super.initState();
    if(_userController.userModel?.status==0){
      Future.delayed(Duration.zero, () async {
        await _userController.getAllDrivers();
        filteredUsers = _userController.allDrivers;
      });
    }else{
      Future.delayed(Duration.zero, () async {
        await _userController.getAllUsers();
        filteredUsers = _userController.allUsers;
      });

    }


    _searchController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredUsers = _userController.allDrivers
          .where((user) {
        return user.userName?.toLowerCase().contains(query) ?? false ||
            user.userName!.toLowerCase().contains(query);
      })
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => LoadingOverlay(
        isLoading: _userController.isLoading,
        child: Scaffold(
          appBar: myAppBar(title: 'Search Screen'),
          body: Padding(
            padding: const EdgeInsets.all(PaddingManger.kPadding),
            child: Column(
              children: [
                if (_userController.allDrivers.isNotEmpty) ...[
                  MyTextField(
                      controller: _searchController,
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search)),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index)=>buildUserItem(filteredUsers[index]),
                        separatorBuilder: (context,index)=>SizedBox(height: PaddingManger.kPadding/1.5,),
                        itemCount: filteredUsers.length),
                  )
                ]
                else ...[
                  Spacer(),
                  NoUsers(title:_userController.userModel?.status==0? 'There Is No Drivers':'There Is No Users'),
                  Spacer()
                ]
              ],
            ),
          ),
        )));
  }

  Widget buildUserItem(UserModel model) => Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: GestureDetector(
          onTap: () {
            Get.to(() => DriverDetailsScreen(
                  userModel: model,
                ));
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
                  backgroundImage: NetworkImage(model.profileImage??''),
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
                    )
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
