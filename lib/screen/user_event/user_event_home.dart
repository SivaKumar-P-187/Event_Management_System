import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/user_event/published_event.dart';
import 'package:final_event/screen/user_event/not_published_event.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_event/string.dart';

class UserEventHome extends StatefulWidget {
  const UserEventHome({Key? key}) : super(key: key);

  @override
  _UserEventHomeState createState() => _UserEventHomeState();
}

class _UserEventHomeState extends State<UserEventHome> {
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
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
            title: Text(
              Strings.userEventTitle,
              style: GoogleFonts.dmSerifDisplay(
                textStyle: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(1.5 * SizeConfig.widthMultiplier!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotPublishedEvent(
                  userUid: userUid,
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier!,
                ),
                PublishedEvent(
                  userUid: userUid,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
