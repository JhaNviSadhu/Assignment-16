import 'package:assignment_16/constant.dart';
import 'package:assignment_16/model/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserModel? userModel;
  bool isSelected = false;

  Future<String> _loadAssets() async {
    return await rootBundle.loadString('assets/userinfo.json');
  }

  Future loadUserData() async {
    String jsonString = await _loadAssets();
    final jsonResponse = json.decode(jsonString);
    setState(() {
      userModel = UserModel.fromJson(jsonResponse);
    });
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: isSelected
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            child: Container(
              height: isSelected
                  ? MediaQuery.of(context).size.height / 4
                  : MediaQuery.of(context).size.height / 1.6,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.primary,
              child: (userModel?.profilePic == null)
                  ? const Placeholder()
                  : Image.network(
                      userModel?.profilePic ?? '',
                      scale: 1.0,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userModel?.firstName} ${userModel?.lastName}"
                          .toUpperCase(),
                      style: kfont1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${userModel?.region} ,${userModel?.country}",
                      style: kfont,
                    ),
                  ],
                ),
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {},
                  backgroundColor: primarycolor,
                  child: const Icon(
                    CupertinoIcons.add,
                  ),
                ),
              ],
            ),
          ),
          isSelected
              ? const SizedBox(
                  height: 0,
                  width: 0,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 19, left: 30, right: 30),
                  child: Text(
                    userModel?.bio ?? "",
                    style: kfont,
                  ),
                ),
          isSelected
              ? const SizedBox(
                  height: 19,
                )
              : const Spacer(),
          SafeArea(
            top: false,
            bottom: isSelected ? false : true,
            child: Container(
              height: 78,
              color: boxcolor,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Spacer(),
                        Text("Posts", style: kfont.copyWith(fontSize: 10)),
                        const SizedBox(height: 5),
                        Text(
                          "${userModel?.post?.length.toString()}",
                          style: kfont1.copyWith(fontSize: 18),
                        ),
                        const Spacer(),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          print(isSelected);
                          isSelected = !isSelected;
                          print(isSelected);
                        });
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            children: [
                              const Spacer(),
                              Text("Followers",
                                  style: kfont.copyWith(fontSize: 10)),
                              const SizedBox(height: 5),
                              Text(
                                "${userModel?.userfollwer?.length}",
                                style: kfont1.copyWith(fontSize: 18),
                              ),
                              const Spacer(),
                            ],
                          ),
                          Positioned(
                            top: 40,
                            child: isSelected
                                ? const Icon(
                                    Icons.arrow_drop_up_outlined,
                                    size: 60,
                                    color: primarycolor,
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Spacer(),
                        Text("Following", style: kfont.copyWith(fontSize: 10)),
                        const SizedBox(height: 5),
                        Text(
                          "${userModel?.following?.length}",
                          style: kfont1.copyWith(fontSize: 18),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          isSelected
              ? Container(
                  // color: Colors.red,
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: userModel?.userfollwer?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          maxRadius: 45,
                          minRadius: 45,
                          backgroundImage: AssetImage(
                            userModel?.userfollwer?[index].userImg ?? " ",
                          ),
                        ),
                        title: Text(
                          userModel?.userfollwer?[index].name ?? '',
                          style: kfont1.copyWith(fontSize: 20),
                        ),
                        subtitle: Text(
                          userModel?.userfollwer?[index].userName ?? '',
                          style: kfont.copyWith(fontSize: 20),
                        ),
                      );
                    },
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  // Widget userFollowerInfo() {

  //   return
  // }
}
