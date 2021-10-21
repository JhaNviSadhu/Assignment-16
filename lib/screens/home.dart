import 'dart:convert';

import 'package:assignment_16/constants/api_constant.dart';
import 'package:assignment_16/model/user_api_info.dart';
import 'package:assignment_16/screens/user_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserInfoModel>? userInfoModel;

  Future loadUserData() async {
    var url = Uri.parse('${APIConstant.baseUrl}${APIConstant.userList}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      UserFullList asUserfulllist = UserFullList.fromJson(jsonResponse);
      setState(() {
        userInfoModel = asUserfulllist.userInfoModel;
      });
    }
  }

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User List"),
        ),
        body: ListView.builder(
          itemCount: userInfoModel?.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(
                      userInfo: userInfoModel?[index],
                    ),
                  )),
              title: Text(
                  "${userInfoModel?[index].userFirstName ?? ''} ${userInfoModel?[index].userLastName ?? ''}"),
              subtitle: Text(userInfoModel?[index].userName ?? ''),
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(userInfoModel?[index].profileImg ?? ''),
              ),
            );
          },
        ));
  }
}
