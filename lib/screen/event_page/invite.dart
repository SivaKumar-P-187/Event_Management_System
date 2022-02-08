import 'package:final_event/json/event_.dart';
import 'package:final_event/json/users_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/following/user_list.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:google_fonts/google_fonts.dart';

class Invite extends StatefulWidget {
  final String eventId;
  final String createEventId;
  final NewEvent event;
  const Invite({
    Key? key,
    required this.eventId,
    required this.createEventId,
    required this.event,
  }) : super(key: key);

  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  String userUid = "";
  @override
  void initState() {
    super.initState();
    userUid = SharedPreferencesHelper.getUserUid();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            centerTitle: true,
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
                size: 5 * SizeConfig.textMultiplier!,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              Strings.inviteUserFollowing,
              style: GoogleFonts.dmSerifDisplay(
                textStyle: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: StreamBuilder<UsersInfo>(
            stream: UserManagement().getParticularUserInfo(uid: userUid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              UsersInfo usersInfo = snapshot.data!;
              if (usersInfo.followingList.isEmpty) {
                return SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                  child: Center(
                    child: Text(
                      Strings.followingUserEmpty,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                );
              }
              return StreamBuilder<List<UsersInfo>>(
                stream: UserManagement()
                    .getAllFollowingUsers(userUid: usersInfo.followingList),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  List<UsersInfo> user = snapshot.data!;
                  user.removeWhere((element) => element.uid == userUid);
                  return UsersList(
                    userUid: userUid,
                    isInvite: true,
                    usersList: user,
                    eventId: widget.eventId,
                    createUser: widget.createEventId,
                    event: widget.event,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
