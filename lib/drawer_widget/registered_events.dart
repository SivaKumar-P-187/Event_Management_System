import 'package:final_event/json/users_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/registeredEvents/registered_event_home.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisteredEvent extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const RegisteredEvent({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _RegisteredEventState createState() => _RegisteredEventState();
}

class _RegisteredEventState extends State<RegisteredEvent> {
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
                  builder: (context) => RegisteredEventHome(
                    scaffoldKey: widget.scaffoldKey,
                    usersInfo: usersInfo,
                  ),
                ),
              );
            },
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.calendarCheck,
                color: Colors.grey.shade300,
                size: 4 * SizeConfig.textMultiplier!,
              ),
              title: Text(
                Strings.registeredEventTitle,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          );
        });
  }
}
