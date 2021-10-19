class UserModel {
  UserModel({
    this.firstName,
    this.lastName,
    this.region,
    this.country,
    this.bio,
    this.post,
    this.userfollwer,
    this.following,
    this.profilePic,
  });

  String? firstName;
  String? lastName;
  String? region;
  String? country;
  String? bio;
  List<String>? post;

  List<Following>? following;
  String? profilePic;
  List<UserFollower>? userfollwer;

  factory UserModel.fromJson(Map<String, dynamic> userData) {
    return UserModel(
      firstName: userData['first_name'],
      lastName: userData['last_name'],
      region: userData['region'],
      country: userData['country'],
      bio: userData['bio'],
      post: List<String>.from(userData['post'].map((x) => x)),
      userfollwer: List<UserFollower>.from(
          userData['followers'].map((x) => UserFollower.fromJson(x))),
      following: List<Following>.from(
          userData['following'].map((x) => Following.fromJson(x))),
      profilePic: userData['profile_pic'],
    );
  }
}

class UserFollower {
  UserFollower({this.name, this.userImg, this.userName});

  String? name;
  String? userName;
  String? userImg;

  factory UserFollower.fromJson(Map<String, dynamic> userData) {
    return UserFollower(
        name: userData['name'],
        userName: userData['user_name'],
        userImg: userData['user_img']);
  }
}

class Following {
  Following({this.name, this.userImg, this.userName});

  String? name;
  String? userName;
  String? userImg;

  factory Following.fromJson(Map<String, dynamic> userData) {
    return Following(
        name: userData['name'],
        userName: userData['user_name'],
        userImg: userData['user_img']);
  }
}
