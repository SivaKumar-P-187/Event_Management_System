import 'package:final_event/json/event_.dart';
import 'package:final_event/json/notification.dart';
import 'package:final_event/json/users_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/images.dart';
import 'package:final_event/size_config.dart';
import 'package:flutter/material.dart';
import 'package:final_event/string.dart';
import 'package:random_string/random_string.dart';

class UsersList extends StatefulWidget {
  final String userUid;
  final String eventId;
  final bool isInvite;
  final String createUser;
  final NewEvent? event;
  final List<UsersInfo> usersList;
  const UsersList({
    Key? key,
    required this.userUid,
    required this.isInvite,
    required this.usersList,
    required this.eventId,
    required this.createUser,
    @required this.event,
  }) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<UsersInfo> usersInfo = [];
  String searchValue = "";
  List<UsersInfo> searchValueList = [];
  List<UsersInfo> inviteList = [];
  String name = "";
  String uid = "";
  instantSearch() {
    searchValueList = [];
    setState(() {});
    for (var element in usersInfo) {
      if (element.name.toLowerCase().startsWith(searchValue.toLowerCase())) {
        searchValueList.add(element);
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    usersInfo = widget.usersList;
    name = SharedPreferencesHelper.getUserName();
    uid = SharedPreferencesHelper.getUserUid();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            style: TextStyle(
              color: Colors.black,
              fontSize: 2 * SizeConfig.textMultiplier!,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(2 * SizeConfig.widthMultiplier!),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchValue = value;
              });
              instantSearch();
            },
          ),
        ),
        searchValue.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: usersInfo.isNotEmpty
                    ? ListView.builder(
                        itemCount: usersInfo.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 2 * SizeConfig.widthMultiplier!,
                                right: 2 * SizeConfig.widthMultiplier!),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    2 * SizeConfig.widthMultiplier!),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: buildUserList(users: usersInfo[index]),
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        height: 15 * SizeConfig.heightMultiplier!,
                        child: Center(
                          child: Text(
                            Strings.followingUserEmpty,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: searchValueList.isNotEmpty
                    ? ListView.builder(
                        itemCount: searchValueList.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 2 * SizeConfig.widthMultiplier!,
                                right: 2 * SizeConfig.widthMultiplier!),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    2 * SizeConfig.widthMultiplier!),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:
                                  buildUserList(users: searchValueList[index]),
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        height: 15 * SizeConfig.heightMultiplier!,
                        child: Text(
                          Strings.followingUserEmpty,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 3 * SizeConfig.textMultiplier!,
                                  ),
                        ),
                      ),
              ),
      ],
    );
  }

  buildUserList({required UsersInfo users}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier!,
                width: 20 * SizeConfig.widthMultiplier!,
                child: ClipOval(
                  child: ImagesWidget(
                    image: users.photo,
                    height: 10 * SizeConfig.heightMultiplier!,
                    width: 20 * SizeConfig.widthMultiplier!,
                  ),
                ),
              ),
              SizedBox(
                width: 5 * SizeConfig.widthMultiplier!,
              ),
              Text(
                users.name,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 3 * SizeConfig.textMultiplier!,
                    ),
              )
            ],
          ),
          widget.isInvite && widget.createUser != users.uid
              ? MaterialButton(
                  onPressed: () async {
                    if (!inviteList.contains(users)) {
                      String notificationId = randomAlphaNumeric(11);
                      inviteList.add(users);
                      print("name:${widget.event!.eventName}");
                      Map<String, dynamic> notificationMap = NotificationJson(
                        username: name,
                        userId: uid,
                        event: widget.eventId,
                        dateTime: DateTime.now(),
                        notificationId: notificationId,
                        eventName: widget.event!.eventName,
                      ).toMap();
                      await UserManagement().addNotificationToUser(
                          userUid: users.uid,
                          notificationId: notificationId,
                          context: context,
                          notificationMap: notificationMap);
                      setState(() {});
                    }
                  },
                  color:
                      inviteList.contains(users) ? Colors.black : Colors.blue,
                  child: Text(
                    inviteList.contains(users) ? "Invited" : "Invite",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 2 * SizeConfig.textMultiplier!,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
