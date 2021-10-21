class UserFullList {
  UserFullList({this.userInfoModel});

  List<UserInfoModel>? userInfoModel;
  factory UserFullList.fromJson(dynamic json) {
    return UserFullList(
      userInfoModel:
          List<UserInfoModel>.from(json.map((x) => UserInfoModel.fromJson(x))),
    );
  }
}

class UserInfoModel {
  UserInfoModel({
    this.userFirstName,
    this.userLastName,
    this.userName,
    this.region,
    this.country,
    this.bio,
    this.id,
    this.profileImg,
    this.userFollwerapi,
  });

  String? userFirstName;
  String? userLastName;
  String? userName;
  String? region;
  String? country;
  String? bio;
  String? id;
  String? profileImg;
  List<UserFollwerApi>? userFollwerapi;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      userFirstName: json['first_name'],
      userLastName: json['last_name'],
      userName: json['user_name'],
      region: json['region'],
      country: json['country'],
      bio: json['bio'],
      id: json['id'],
      profileImg: json['profile_image'],
      userFollwerapi: List<UserFollwerApi>.from(
          json['follower'].map((x) => UserFollwerApi.fromJson(x))),
    );
  }
}

class UserFollwerApi {
  UserFollwerApi({
    this.userlastname,
    this.userImg,
    this.userName,
    this.userfirstname,
  });

  String? userlastname;
  String? userfirstname;
  String? userName;
  String? userImg;

  factory UserFollwerApi.fromJson(Map<String, dynamic> json) {
    return UserFollwerApi(
      userfirstname: json['firstName'],
      userlastname: json['lastName'],
      userName: json['userName'],
      userImg: json['userImage'],
    );
  }
}
