import 'package:final_event/json/users_.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/registeredEvents/completed_event.dart';
import 'package:final_event/screen/registeredEvents/upcoming_event.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisteredEventHome extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final UsersInfo usersInfo;
  const RegisteredEventHome({
    Key? key,
    required this.scaffoldKey,
    required this.usersInfo,
  }) : super(key: key);

  @override
  _RegisteredEventHomeState createState() => _RegisteredEventHomeState();
}

class _RegisteredEventHomeState extends State<RegisteredEventHome> {
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
              Strings.registeredEventTitle,
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
                widget.usersInfo.registeredEvents.isNotEmpty
                    ? RegisteredUpcomingEvent(
                        usersInfo: widget.usersInfo,
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier!,
                ),
                widget.usersInfo.registeredEvents.isNotEmpty
                    ? RegisteredCompletedEvent(
                        usersInfo: widget.usersInfo,
                      )
                    : SizedBox(
                        height: 20 * SizeConfig.heightMultiplier!,
                        child: Center(
                          child: Text(
                            Strings.registerCompletedEventEmptyWarning,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
