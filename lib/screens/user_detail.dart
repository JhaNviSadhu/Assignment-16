import 'package:assignment_16/constant.dart';
import 'package:assignment_16/model/user_api_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenArgument {
  UserInfoModel? userInfo;

  ScreenArgument(this.userInfo);
}

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/second';
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool isSorted = false;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as UserInfoModel;
    sortingData() {
      isSorted
          ? arg.userFollwerapi?.sort(
              (name1, name2) => (name1.userName ?? '').compareTo(
                (name2.userName ?? ''),
              ),
            )
          : arg.userFollwerapi?.sort(
              (name2, name1) => (name1.userName ?? '').compareTo(
                (name2.userName ?? ''),
              ),
            );
      isSorted = !isSorted;
    }

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
              child: (arg.profileImg == null)
                  ? const Placeholder()
                  : Image.network(
                      arg.profileImg ?? '',
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
                      "${arg.userFirstName} ${arg.userLastName}".toUpperCase(),
                      style: kfont1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${arg.region ?? ' '} ,${arg.country ?? ' '}",
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
                    arg.bio ?? '',
                    style: kfont,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
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
                          "3",
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
                                "${arg.userFollwerapi?.length ?? 0}",
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
                          "4",
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
              ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        sortingData();
                      });
                    },
                    icon: const Icon(Icons.sort_by_alpha),
                  ),
                )
              : const SizedBox(height: 0),
          isSelected
              ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              arg.userFollwerapi?[index].userImg ?? ''),
                        ),
                        title: Text(
                          "${arg.userFollwerapi?[index].userfirstname ?? ''}${arg.userFollwerapi?[index].userlastname ?? ''}",
                          style: kfont1.copyWith(fontSize: 20),
                        ),
                        subtitle: Text(
                          arg.userFollwerapi?[index].userName ?? '',
                          style: kfont.copyWith(fontSize: 20),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
