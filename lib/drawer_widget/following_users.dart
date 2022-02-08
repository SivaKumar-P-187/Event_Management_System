import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/following/home.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FollowingUsers extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const FollowingUsers({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _FollowingUsersState createState() => _FollowingUsersState();
}

class _FollowingUsersState extends State<FollowingUsers> {
  String userUid = '';

  @override
  void initState() {
    super.initState();
    userUid = SharedPreferencesHelper.getUserUid();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const FollowingHome(),
          ),
        );
      },
      child: ListTile(
        leading: FaIcon(
          FontAwesomeIcons.userPlus,
          color: Colors.grey.shade300,
          size: 4 * SizeConfig.textMultiplier!,
        ),
        title: Text(
          Strings.followingEventTitle,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
