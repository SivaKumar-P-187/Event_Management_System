import 'package:final_event/drawer_widget/create_event.dart';
import 'package:final_event/drawer_widget/following_users.dart';
import 'package:final_event/drawer_widget/profile.dart';
import 'package:final_event/drawer_widget/registered_events.dart';
import 'package:final_event/drawer_widget/sign_out.dart';
import 'package:final_event/drawer_widget/user_event.dart';
import 'package:final_event/json/users_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/profile/empty_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/screen/images.dart';
import 'package:final_event/string.dart';

class MyDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const MyDrawer({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int? colorNumber;
  String name = "";
  String photo = "";
  String email = "";
  String password = "";
  String address = "";
  String phoneNo = "";
  String dateOfBirth = "";
  String tempValue = "";
  String? eventType;
  String userUid = "";
  UsersInfo? usersInfo;
  Map<String, dynamic>? documentData;
  final items = ['Birthday', 'Anniversary'];
  @override
  void initState() {
    super.initState();
    userUid = SharedPreferencesHelper.getUserUid();
    colorNumber = SharedPreferencesHelper.getDefaultColor();
    photo = SharedPreferencesHelper.getUserPhoto();
    address = SharedPreferencesHelper.getUserAddress();
    dateOfBirth = SharedPreferencesHelper.getDateOfBirth();
    phoneNo = SharedPreferencesHelper.getUserPhoneNo();
    name = SharedPreferencesHelper.getUserName();
    password = SharedPreferencesHelper.getPassword();
    email = SharedPreferencesHelper.getUserEmail();
    setState(() {});
    buildOnLaunch();
  }

  buildOnLaunch() async {
    await getOnLaunch();
  }

  getOnLaunch() async {
    UserManagement().getFollowersList(userUid: userUid).then((value) {
      if (value.docs.isNotEmpty) {
        documentData = value.docs.single.data() as Map<String, dynamic>;
        usersInfo = UsersInfo.fromMap(documentData!);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 30 * SizeConfig.heightMultiplier!,
            width: 15 * SizeConfig.widthMultiplier!,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 2 * SizeConfig.widthMultiplier!,
                  right: 2 * SizeConfig.widthMultiplier!),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: Divider.createBorderSide(
                      context,
                      width: SizeConfig.widthMultiplier! / 2,
                      color: Colors.grey.shade100,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: 2 * SizeConfig.heightMultiplier!,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 3 * SizeConfig.widthMultiplier!,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      photo.isNotEmpty
                          ? imageWidget(
                              image: photo,
                              width: 26 * SizeConfig.widthMultiplier!,
                              height: 12 * SizeConfig.heightMultiplier!,
                            )
                          : EmptyProfilePhoto(
                              height: 5 * SizeConfig.heightMultiplier!,
                              email: email,
                              colorNumber: colorNumber!,
                            ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier!,
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier! / 4,
                      ),
                      usersInfo != null
                          ? Text(
                              usersInfo!.followersList.length.toString() +
                                  Strings.followersCount,
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 2 * SizeConfig.widthMultiplier!,
              right: 2 * SizeConfig.widthMultiplier!,
            ),
            child: Column(
              children: [
                Profile(
                  scaffoldKey: widget.scaffoldKey,
                ),
                CreateEvent(
                  scaffoldKey: widget.scaffoldKey,
                ),
                UserEvents(
                  scaffoldKey: widget.scaffoldKey,
                ),
                RegisteredEvent(
                  scaffoldKey: widget.scaffoldKey,
                ),
                FollowingUsers(scaffoldKey: widget.scaffoldKey),
                SignOut(
                  scaffoldKey: widget.scaffoldKey,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 2 * SizeConfig.widthMultiplier!,
              right: 2 * SizeConfig.widthMultiplier!,
            ),
            child: Divider(
              color: Colors.grey.shade100,
              thickness: SizeConfig.widthMultiplier! / 2,
            ),
          ),
        ],
      ),
    );
  }

  imageWidget({String? image, double? height, double? width}) {
    return ClipOval(
      child: ImagesWidget(image: photo, width: width, height: height),
    );
  }
}
