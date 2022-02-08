import 'package:final_event/screen/new_event/new_event_body.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewEventHome extends StatefulWidget {
  final String eventType;
  const NewEventHome({
    Key? key,
    required this.eventType,
  }) : super(key: key);

  @override
  _NewEventHomeState createState() => _NewEventHomeState();
}

class _NewEventHomeState extends State<NewEventHome> {
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
              widget.eventType + Strings.eventTitle,
              style: GoogleFonts.dmSerifDisplay(
                textStyle: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
        body: NewEventBody(
          eventType: widget.eventType,
        ),
      ),
    );
  }
}
