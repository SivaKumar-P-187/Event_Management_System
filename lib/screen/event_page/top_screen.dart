import 'package:final_event/json/event_.dart';
import 'package:final_event/json/users_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/event_page/invite.dart';
import 'package:final_event/screen/images.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class TopScreen extends StatefulWidget {
  final NewEvent event;
  final String collectionName;
  const TopScreen({
    Key? key,
    required this.event,
    required this.collectionName,
  }) : super(key: key);

  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  String userUid = "";
  @override
  void initState() {
    super.initState();
    userUid = SharedPreferencesHelper.getUserUid();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NewEvent>(
        stream: UserManagement().getEvent(
          eventUid: widget.event.eventId,
          collectionName: widget.collectionName,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final event = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.eventName,
                style: GoogleFonts.dmSerifDisplay(
                  textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 3.5 * SizeConfig.textMultiplier!,
                      ),
                ),
              ),
              event.participants.isNotEmpty
                  ? SizedBox(
                      height: 12 * SizeConfig.heightMultiplier!,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: event.participants.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: 1.0 * SizeConfig.widthMultiplier!,
                              ),
                              child: userList(
                                userId: event.participants[index],
                              ),
                            );
                          }))
                  : SizedBox(
                      height: 6 * SizeConfig.heightMultiplier!,
                      child: Center(
                        child: Text(
                          Strings.eventNoParticipants,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 2.5 * SizeConfig.textMultiplier!,
                                  ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier!,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${event.participants.length} ${Strings.eventPlushIcon} ${Strings.eventAttending}",
                    style: GoogleFonts.dmSerifDisplay(
                      textStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 3 * SizeConfig.textMultiplier!,
                              ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    size: 2.5 * SizeConfig.textMultiplier!,
                  ),
                ],
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier!,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 3 * SizeConfig.widthMultiplier!,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Invite(
                          eventId: event.eventId,
                          createEventId: event.createUserUid,
                          event: event,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 7 * SizeConfig.heightMultiplier!,
                    width: 100 * SizeConfig.widthMultiplier!,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(
                        5 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 3 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Strings.eventInviteMessage,
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontSize: 2 * SizeConfig.textMultiplier!,
                                  ),
                            ),
                          ),
                          Container(
                            height: 7 * SizeConfig.heightMultiplier!,
                            width: 40 * SizeConfig.widthMultiplier!,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(
                                6 * SizeConfig.widthMultiplier!,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                Strings.eventInvite,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      fontSize: 2 * SizeConfig.textMultiplier!,
                                      letterSpacing:
                                          0.5 * SizeConfig.textMultiplier!,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier!,
              ),
              Text(
                Strings.eventDetailTitle,
                style: GoogleFonts.dmSerifDisplay(
                  textStyle: Theme.of(context).textTheme.headline1,
                ),
              ),
              ReadMoreText(
                event.details,
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: Strings.showMore,
                trimExpandedText: Strings.showLess,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 2.5 * SizeConfig.textMultiplier!,
                    ),
                moreStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                lessStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier!,
              ),
            ],
          );
        });
  }

  userList({required String userId}) {
    return StreamBuilder<UsersInfo>(
        stream: UserManagement().getParticularUserInfo(uid: userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          UsersInfo userInfo = snapshot.data!;
          return InkWell(
            onTap: () async {
              if (userInfo.uid != userUid) {
                await buildFollowWidget(usersInfo: userInfo);
              }
            },
            child: ClipOval(
              child: Container(
                height: 12 * SizeConfig.heightMultiplier!,
                width: 22 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade50,
                ),
                child: ImagesWidget(
                  image: userInfo.photo,
                  width: 22 * SizeConfig.widthMultiplier!,
                  height: 12 * SizeConfig.heightMultiplier!,
                ),
              ),
            ),
          );
        });
  }

  Future buildFollowWidget({required UsersInfo usersInfo}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                2 * SizeConfig.widthMultiplier!,
              ),
            ),
          ),
          content: Container(
            width: 35 * SizeConfig.widthMultiplier!,
            height: 25 * SizeConfig.heightMultiplier!,
            padding: EdgeInsets.symmetric(
              // vertical: SizeConfig.heightMultiplier! / 3,
              horizontal: 1 * SizeConfig.widthMultiplier!,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
              borderRadius:
                  BorderRadius.circular(2 * SizeConfig.widthMultiplier!),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 3 * SizeConfig.heightMultiplier!,
                ),
                Center(
                  child: ClipOval(
                    child: ImagesWidget(
                      image: usersInfo.photo,
                      height: 30 * SizeConfig.imageSizeMultiplier!,
                      width: 25 * SizeConfig.imageSizeMultiplier!,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier!,
                ),
                Center(
                  child: Text(
                    usersInfo.name,
                    style: GoogleFonts.dmSerifDisplay(
                      textStyle: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier!,
                ),
              ],
            ),
          ),
          actions: [
            usersInfo.followersList.contains(userUid)
                ? MaterialButton(
                    onPressed: () async {
                      await UserManagement().removeUserFollowingList(
                          userUid: usersInfo.uid, uid: userUid);
                      await UserManagement().removeUserFollowerList(
                          userUid: usersInfo.uid, uid: userUid);
                      Navigator.of(context).pop();
                    },
                    color: Colors.blue,
                    child: Text(
                      Strings.unFollowTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 2 * SizeConfig.textMultiplier!,
                      ),
                    ),
                  )
                : MaterialButton(
                    onPressed: () async {
                      await UserManagement().addUserFollowingList(
                          userUid: usersInfo.uid, uid: userUid);
                      await UserManagement().addUserFollowersList(
                          userUid: usersInfo.uid, uid: userUid);
                      Navigator.of(context).pop();
                    },
                    color: Colors.blue,
                    child: Text(
                      Strings.followTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 2 * SizeConfig.textMultiplier!,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
