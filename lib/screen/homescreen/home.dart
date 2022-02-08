import 'package:final_event/drawer_widget/notification_drawer.dart';
import 'package:final_event/screen/appbar/appbar_menu_icon.dart';
import 'package:final_event/drawer_widget/drawer.dart';
import 'package:final_event/screen/appbar/notification_icon.dart';
import 'package:final_event/screen/homescreen/all_events.dart';
import 'package:final_event/screen/homescreen/upcoming_event.dart';
import 'package:final_event/screen/homescreen/your_location.dart';
import 'package:final_event/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_event/string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: MyDrawer(
        scaffoldKey: _scaffoldKey,
      ),
      endDrawer: NotificationDrawer(
        scaffoldKey: _scaffoldKey,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            centerTitle: true,
            leading: InkWell(
              child: const MenuIcon(),
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            title: Text(
              Strings.homeTitle,
              style: GoogleFonts.dmSerifDisplay(
                textStyle: Theme.of(context).textTheme.headline1,
              ),
            ),
            actions: [
              NotificationMenuIcon(
                scaffoldKey: _scaffoldKey,
              ),
            ],
          ),
        ],
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(
                left: 3 * SizeConfig.widthMultiplier!,
                top: 2 * SizeConfig.heightMultiplier!,
                bottom: 3 * SizeConfig.widthMultiplier!,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AllEvents(),
                  UpcomingEvent(),
                  Location(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
