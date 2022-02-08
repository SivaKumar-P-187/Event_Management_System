import 'package:final_event/json/event_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/event_page/event_home.dart';
import 'package:final_event/screen/images.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingEvent extends StatefulWidget {
  const UpcomingEvent({Key? key}) : super(key: key);

  @override
  _UpcomingEventState createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent> {
  List<NewEvent> event = [];
  String userUid = "";
  @override
  void initState() {
    super.initState();
    userUid = SharedPreferencesHelper.getUserUid();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewEvent>>(
        stream: UserManagement().getAllEvent(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          event = snapshot.data!;
          event.removeWhere((element) => element.createUserUid == userUid);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: 3 * SizeConfig.widthMultiplier!,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.upcomingEventTitle,
                      style: GoogleFonts.dmSerifDisplay(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 3 * SizeConfig.textMultiplier!),
                      ),
                    ),
                    Text(
                      event.length.toString(),
                      style: GoogleFonts.sofadiOne(
                        textStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontSize: 2.5 * SizeConfig.textMultiplier!,
                                ),
                      ),
                    )
                  ],
                ),
              ),
              event.isNotEmpty
                  ? SizedBox(
                      height: 25 * SizeConfig.heightMultiplier!,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: event.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: 3 * SizeConfig.widthMultiplier!,
                              ),
                              child: event[index].eventImage!.isNotEmpty
                                  ? eventDisplay(event: event[index])
                                  : const SizedBox.shrink(),
                            );
                          }),
                    )
                  : SizedBox(
                      height: 12 * SizeConfig.heightMultiplier!,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2 * SizeConfig.heightMultiplier!),
                          child: Text(
                            Strings.noUpcomingEvent,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2.5 * SizeConfig.textMultiplier!,
                                ),
                          ),
                        ),
                      ),
                    ),
            ],
          );
        });
  }

  eventDisplay({required NewEvent event}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Event(
              event: event,
              isUserEvent: false,
              collectionName: Strings.eventCollectionTitle,
            ),
          ),
        );
      },
      child: Hero(
        tag: event,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
              child: ImagesWidget(
                image: event.eventImage!,
                height: 55 * SizeConfig.imageSizeMultiplier!,
                width: 90 * SizeConfig.imageSizeMultiplier!,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier!),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.calendarAlt,
                          size: 5 * SizeConfig.widthMultiplier!,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 1.5 * SizeConfig.widthMultiplier!,
                        ),
                        Text(
                          "${event.date},${event.year}",
                          style: GoogleFonts.dmSerifDisplay(
                            textStyle:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      event.eventName,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.dmSerifDisplay(
                        textStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  upcomingHeader({required String length}) {
    return Padding(
      padding: EdgeInsets.only(right: 3 * SizeConfig.widthMultiplier!),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.upcomingEventTitle,
            style: GoogleFonts.dmSerifDisplay(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 3 * SizeConfig.textMultiplier!),
            ),
          ),
          Text(
            length,
            style: GoogleFonts.sofadiOne(
              textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 2.5 * SizeConfig.textMultiplier!,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
