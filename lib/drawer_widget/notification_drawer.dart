import 'package:final_event/json/event_.dart';
import 'package:final_event/json/notification.dart';
import 'package:final_event/json/users_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/event_page/event_home.dart';
import 'package:final_event/screen/images.dart';
import 'package:final_event/screen/time_conversion.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const NotificationDrawer({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _NotificationDrawerState createState() => _NotificationDrawerState();
}

class _NotificationDrawerState extends State<NotificationDrawer> {
  String userUid = "";
  @override
  void initState() {
    super.initState();
    userUid = SharedPreferencesHelper.getUserUid();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder<List<NotificationJson>>(
        stream: UserManagement().getUserNotification(userUid: userUid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          List<NotificationJson> notification = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier!),
            child: notification.isNotEmpty
                ? ListView.builder(
                    itemCount: notification.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 2 * SizeConfig.heightMultiplier!),
                        child: buildNotificationContainer(
                            notification: notification[index]),
                      );
                    },
                  )
                : SizedBox(
                    height: 20 * SizeConfig.heightMultiplier!,
                    child: Center(
                      child: Text(
                        Strings.emptyNotificationWarring,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  buildNotificationContainer({required NotificationJson notification}) {
    return StreamBuilder<UsersInfo>(
      stream: UserManagement().getParticularUserInfo(uid: notification.userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        UsersInfo usersInfo = snapshot.data!;
        return StreamBuilder<NewEvent>(
          stream: UserManagement()
              .getEvent(eventUid: notification.event, collectionName: "Event"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            NewEvent event = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
              ),
              child: ListTile(
                leading: ClipOval(
                  child: ImagesWidget(
                    image: usersInfo.photo,
                    height: 15 * SizeConfig.heightMultiplier!,
                    width: 15 * SizeConfig.widthMultiplier!,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 17 * SizeConfig.widthMultiplier!,
                      ),
                      child: Text(
                        usersInfo.name,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      TimeAgo.timeAgoSinceDate(DateFormat("dd-MM-yyyy h:mma")
                          .format(notification.dateTime)),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 1.6 * SizeConfig.textMultiplier!,
                          ),
                      maxLines: 2,
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Your are been invited for \" ${notification.eventName} \"..",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 2 * SizeConfig.textMultiplier!,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier!,
                    ),

                    ///button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bottomMenu(
                          title: "X",
                          height: 5 * SizeConfig.heightMultiplier!,
                          width: 15 * SizeConfig.widthMultiplier!,
                          onTap: () async {
                            await UserManagement().deleteParticularNotification(
                                userUid: userUid,
                                notificationId: notification.notificationId,
                                context: context);
                          },
                        ),
                        bottomMenu(
                          title: "Go to Event",
                          height: 5 * SizeConfig.heightMultiplier!,
                          width: 23 * SizeConfig.widthMultiplier!,
                          onTap: () async {
                            if (widget
                                .scaffoldKey.currentState!.isEndDrawerOpen) {
                              Navigator.pop(context);
                            }
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Event(
                                  isUserEvent: false,
                                  event: event,
                                  collectionName: 'Event',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier!,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  bottomMenu({
    required String title,
    required double height,
    required double width,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(3 * SizeConfig.widthMultiplier!),
              border: Border.all(color: Colors.grey),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 1.5 * SizeConfig.textMultiplier!,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
