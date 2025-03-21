class UserModel {
  final String? email;
  final String ?phoneNumber;
  final String ?profileImage;
  final String ?uid;
  final String ?gender;
  final String ?userName;
  final int ?status;
  final String ?driverDescription;
  final bool ?isOnline;
  final num ?latitude;
  final num ?longitude;
  final bool ?isUserReady;

  UserModel({
     this.uid,
     this.gender,
     this.userName,
     this.email,
     this.profileImage,
     this.phoneNumber,
     this.status,
     this.isOnline,
    this.driverDescription,
    this.isUserReady,
     this.longitude,
     this.latitude
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        uid: json['uid']??'',
        gender: json['gender']??'',
        userName: json['user_name']??'',
        email: json['email']??'',
        status:json['status']??0,
        latitude: json['latitude']??0,
        longitude: json['longitude']??0,
        isOnline: json['is_online']??false,
        profileImage: json['profile_image']??'',
        isUserReady: json['is_user_ready']??false,
        driverDescription: json['driver_description']??'',
        phoneNumber: json['mobile_number']??'');
  }

}