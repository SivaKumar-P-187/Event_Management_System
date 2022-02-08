import 'package:final_event/json/notification.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class NotificationMenuIcon extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const NotificationMenuIcon({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _NotificationMenuIconState createState() => _NotificationMenuIconState();
}

class _NotificationMenuIconState extends State<NotificationMenuIcon> {
  String userUid = "";
  @override
  void initState() {
    super.initState();
    userUid = SharedPreferencesHelper.getUserUid();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NotificationJson>>(
      stream: UserManagement().getUserNotification(userUid: userUid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        List<NotificationJson> notification = snapshot.data!;

        return InkWell(
          onTap: () {
            widget.scaffoldKey.currentState!.openEndDrawer();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 6 * SizeConfig.widthMultiplier!,
              vertical: 0.5 * SizeConfig.heightMultiplier!,
            ),
            child: Stack(
              children: [
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).textTheme.headline1!.color,
                  size: 5 * SizeConfig.textMultiplier!,
                ),
                notification.isNotEmpty
                    ? Positioned(
                        top: 0,
                        right: 1.5 * SizeConfig.widthMultiplier!,
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
          ),
        );
      },
    );
  }
}
