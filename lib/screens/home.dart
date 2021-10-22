import 'dart:convert';

import 'package:assignment_16/constants/api_constant.dart';
import 'package:assignment_16/model/user_api_info_model.dart';
import 'package:assignment_16/screens/user_detail.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = '/';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserInfoModel>? userInfoModel;
  bool isLoading = false;

  Future loadUserData() async {
    var url = Uri.parse('${APIConstant.baseUrl}${APIConstant.userList}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        UserFullListModel asUserfulllist =
            UserFullListModel.fromJson(jsonResponse);
        setState(() {
          userInfoModel = asUserfulllist.userInfoModel;
          isLoading = false;
        });
      } catch (e, s) {
        print(e);
        print(s);
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    isLoading = true;
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
        automaticallyImplyLeading: false,
        title: const Text("User List"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (userInfoModel != null)
              ? ListView.builder(
                  itemCount: userInfoModel?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        UserInfoModel? _user = userInfoModel?[index];

                        Navigator.pushNamed(context, UserDetailScreen.routeName,
                            arguments: _user);
                      },
                      title: Text(
                          "${userInfoModel?[index].userFirstName ?? ''} ${userInfoModel?[index].userLastName ?? ''}"),
                      subtitle: Text(userInfoModel?[index].userName ?? ''),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            userInfoModel?[index].profileImg ?? ''),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('No Data Found'),
                ),
    );
  }
}

// Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UserDetailScreen(
//                             userInfo: userInfoModel?[index],
//                           ),
//                         )),

