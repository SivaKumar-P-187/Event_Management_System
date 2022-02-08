import 'package:final_event/screen/event_type/all_events.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_event/size_config.dart';

class EventTypeHome extends StatefulWidget {
  final String eventType;
  const EventTypeHome({
    Key? key,
    required this.eventType,
  }) : super(key: key);

  @override
  _EventTypeHomeState createState() => _EventTypeHomeState();
}

class _EventTypeHomeState extends State<EventTypeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
            title: Text(
              widget.eventType,
              style: GoogleFonts.dmSerifDisplay(
                textStyle: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 1.2 * SizeConfig.widthMultiplier!,
              bottom: 3 * SizeConfig.widthMultiplier!,
            ),
            child: AllEvents(
              eventType: widget.eventType,
            ),
          ),
        ),
      ),
    );
  }
}
