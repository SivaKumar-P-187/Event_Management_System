import 'package:final_event/json/users_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/user_event/user_event_home.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserEvents extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const UserEvents({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _UserEventsState createState() => _UserEventsState();
}

class _UserEventsState extends State<UserEvents> {
  String userUid = '';

  @override
  void initState() {
    super.initState();
    userUid = SharedPreferencesHelper.getUserUid();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersInfo>(
        stream: UserManagement().getParticularUserInfo(uid: userUid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          UsersInfo usersInfo = snapshot.data!;
          return InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const UserEventHome(),
                ),
              );
            },
            child: ListTile(
              leading: Stack(
                children: [
                  FaIcon(
                    FontAwesomeIcons.calendarAlt,
                    color: Colors.grey.shade300,
                    size: 4 * SizeConfig.textMultiplier!,
                  ),
                  usersInfo.unPublishedEvent.isNotEmpty
                      ? Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 3 * SizeConfig.heightMultiplier!,
                            width: 3 * SizeConfig.widthMultiplier!,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              title: Text(
                Strings.userEventTitle,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          );
        });
  }
}
