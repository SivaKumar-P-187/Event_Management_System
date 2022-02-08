import 'package:emojis/emoji.dart';
import 'package:final_event/json/types_event.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/event_type/event_home.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:emojis/emojis.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({Key? key}) : super(key: key);

  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  String name = "";
  List<TypeEvent> event = InitializeEvent.initUsers;
  String partying = Emoji.stabilize(Emojis.womanAndManHoldingHands,
      skin: false, gender: true);
  @override
  void initState() {
    super.initState();
    name = SharedPreferencesHelper.getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.welcomeUser + "$name!",
          style: GoogleFonts.dmSerifDisplay(
              textStyle: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 4.7 * SizeConfig.textMultiplier!)),
        ),
        SizedBox(
          height: 3 * SizeConfig.heightMultiplier!,
        ),
        Text(
          Strings.welcomeQuotes,
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.bodyText1!,
          ),
        ),
        SizedBox(
          height: 3 * SizeConfig.heightMultiplier!,
        ),
        SizedBox(
          height: 12 * SizeConfig.heightMultiplier!,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: event.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: 2 * SizeConfig.widthMultiplier!,
                  ),
                  child: allEventsList(
                    title: event[index].name,
                    iconData: event[index].eventIcon,
                  ),
                );
              }),
        ),
        SizedBox(
          height: 3 * SizeConfig.heightMultiplier!,
        ),
      ],
    );
  }

  allEventsList({
    required String title,
    required String iconData,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventTypeHome(eventType: title),
          ),
        );
      },
      child: Container(
        height: 15 * SizeConfig.heightMultiplier!,
        width: 30 * SizeConfig.widthMultiplier!,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(3.5 * SizeConfig.widthMultiplier!),
          color: Colors.grey.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              iconData,
              style: TextStyle(
                fontSize: SizeConfig.imageSizeMultiplier! * 7,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
