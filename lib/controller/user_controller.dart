import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_ride/controller/map_controller.dart';
import 'package:safe_ride/model/user_model.dart';
import 'package:safe_ride/view/drivers_home_screen/dirver_home_screen.dart';
import 'package:safe_ride/view/login_screen/login_screen.dart';
import 'package:safe_ride/view/users_home_screen/home_screen.dart';

import '../model/message_model.dart';
import '../shared/config/utils/utils.dart';
import '../view/admin_home_screen/admin_home_screen.dart';
import '../view/users_home_screen/tab_bar_users.dart';

class UserController extends GetxController{

  final _isLoading=RxBool(false);

  final _userModel=Rxn<UserModel>();
  final _allDrivers=RxList<UserModel>([]);
  final _listChatModel = RxList<ChatModel>([]);
  final _instance = FirebaseFirestore.instance;
  final _driverMarkers = RxList<Marker>([]);
  final _allUsers=RxList<UserModel>([]);

  final _mapController=Get.find<MapController>(tag: 'map_controller');




  //Authentication
  Future<void> loginWithEmailAndPassword({required String email,required String password})async{
    _isLoading(true);
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value)async{
      if(value.user?.uid!=null){
        await getUserData(uid: value.user!.uid);
        await updateMyPosition();
        if(_userModel.value!=null){

          if(_userModel.value?.status==0){
            Get.offAll(()=>const TabBarUsersScreen());
          }else if(_userModel.value?.status==1){
            Get.offAll(()=>const AdminMainScreen());
          }
          else{
            Get.offAll(()=>const TabBarUsersScreen());
          }

        }

      }
      else{
        Utils.myToast(title: 'Login Failed !');
      }

    }).catchError((error){
      print('error is ${error.toString()}');
      Utils.myToast(title: 'Login Failed !');
    });
    _isLoading(false);
  }
  Future<void> register({required String email,required String name,required String password,required String age,required String mobileNumber,required String gender,required int status,String ?driverDescription})async{

    _isLoading(true);

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)async{
      if(value.user?.uid!=null){
        await saveDataToFireStore(userName: name, email: email, mobileNumber: mobileNumber, gender: gender, age: age, uid: value.user!.uid,status: status,driverDescription: driverDescription);
      }
    }).catchError((error){
      _isLoading(false);
      print('there is an error when create account !!${error.toString()}');
      Utils.myToast(title: 'Please Check Your Internet !');
    });

    _isLoading(false);

  }
  Future<void> saveDataToFireStore({required String userName,required String email,required String mobileNumber,required String gender,required String age,required String uid,required int status,String ?driverDescription})async{

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email':email,
      'user_name':userName,
      'age':age,
      'gender':gender,
      'is_online':false,
      'profile_image':gender=='Male'?'https://thumbs.dreamstime.com/b/profile-photo-nice-young-man-raise-fist-wear-striped-t-shirt-isolated-bright-yellow-color-background-profile-photo-nice-328338323.jpg':'https://img.freepik.com/premium-photo/profile-side-photo-young-attractive-girl-happy-positive-smile-isolated-yellow-color-background_525549-3672.jpg',
      'uid':uid,
      'status':status,
      'mobile_number':mobileNumber,
      'is_user_ready':false,
      'latitude':_mapController.myPosition?.latitude,
      'longitude':_mapController.myPosition?.longitude,
      'driver_description':driverDescription
    }).then((value){
      Utils.myToast(title: 'Create Account Successfully');
      if(status==0){
        Get.offAll(()=>const LoginScreen());

      }else if(status==2){
        Get.offAll(()=>const AdminMainScreen());
      }
    }).catchError((error){
      Utils.myToast(title: 'Please Check Your Internet !');
      _isLoading(false);
    });

  }
  Future<void> forgetPassword({required String email})async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value){
      Utils.myToast(title: 'Please check your email !');
    }).catchError((error){
      Utils.myToast(title: 'Check Your Internet !');
    });
  }


  Future<void> getUserData({required String uid})async{
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'is_online':true
    });
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value){
      if(value.data()!=null){
        _userModel(UserModel.fromJson(value.data()!));
      }

    });

  }
  Future<void> updateUserData({String ?userName,String ?phone})async{
    _isLoading(true);
    await FirebaseFirestore.instance.collection('users').doc(_userModel.value?.uid).update({
      'mobile_number':phone,
      'user_name':userName
    }).then((value)async{
      Utils.myToast(title: 'Updated Successfully');
      await getUserData(uid: _userModel.value!.uid??'');
    }).catchError((error){
      print('there is an error when update user data !');
    });
    _isLoading(false);

  }
  Future<void> updateMyPosition()async{
    await _mapController.determinePosition();
    await FirebaseFirestore.instance.collection('users').doc(_userModel.value?.uid).update({
      'latitude':_mapController.myPosition?.latitude,
      'longitude':_mapController.myPosition?.longitude,
    });
  }

  //Get All Drivers
  Future<void> getAllDrivers()async{
    _allDrivers.clear();
    _driverMarkers.clear();
    _isLoading(true);
    await FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element){
        if(element['status']==2){
          _allDrivers.add(UserModel.fromJson(element.data()));
          double latitude = element['latitude'];
          double longitude = element['longitude'];
          BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
          Marker driverMarker = Marker(
            markerId: MarkerId(element['uid']),
            position: LatLng(latitude, longitude),
            icon: markerIcon,
            infoWindow: InfoWindow(title: element['user_name']),
          );
          _driverMarkers.add(driverMarker);
        }
      });
    });
    _isLoading(false);
  }
  Future<void> getAllUsers()async{
    _allUsers.clear();
    _driverMarkers.clear();
    _isLoading(true);
    await FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element){
        if(element['status']==0){
          _allUsers.add(UserModel.fromJson(element.data()));
          double latitude = element['latitude']??0;
          double longitude = element['longitude']??0;
          Marker driverMarker = Marker(
            markerId: MarkerId(element['uid']),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: element['user_name']),
          );
          _driverMarkers.add(driverMarker);
        }
      });
    });
    _isLoading(false);
  }







  //Chat
  void sendMessage(
      {required String receiverId,
        required String dateTime,
        required String text,
        String? image,
        required String profileImage}) {
    ChatModel chatModel = ChatModel(
        text: text,
        dateTime: dateTime,
        senderId: _userModel.value?.uid,
        reciverId: receiverId,
        profileImage: profileImage);
    _instance
        .collection('users')
        .doc(_userModel.value?.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(chatModel.toMap())
        .then((value) {})
        .catchError((error) {
      print('there is an error when send message !');
    });

    _instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(_userModel.value?.uid)
        .collection('message')
        .add(chatModel.toMap())
        .then((value) {
      print('message Send Success !');
    }).catchError((error) {
      print('there is an error when send message !');
    });
    _listChatModel.add(chatModel);
  }

  Future getMessages({required String receiverId}) async {
    print('getMessages');
    await _instance
        .collection('users')
        .doc(_userModel.value?.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .listen((event) {
      print('sfsdfsfsfsf');
      _listChatModel.clear();
      event.docs.forEach((element) {
        _listChatModel.add(ChatModel.fromJson(element.data()));
      });
      print('Get Messages Success State');
    });
  }


  bool get isLoading=>_isLoading.value;
  UserModel ?get userModel=>_userModel.value;
  List<UserModel> get allDrivers=>_allDrivers;
  List<ChatModel> get listChatModel => _listChatModel;
  List<Marker> get driverMarkers=>_driverMarkers;
  List<UserModel> get allUsers=>_allUsers;


}