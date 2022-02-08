import 'package:final_event/json/event_.dart';
import 'package:final_event/json/users_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/screen/build_event_widget.dart';

class RegisteredUpcomingEvent extends StatefulWidget {
  final UsersInfo usersInfo;
  const RegisteredUpcomingEvent({
    Key? key,
    required this.usersInfo,
  }) : super(key: key);

  @override
  _RegisteredUpcomingEventState createState() =>
      _RegisteredUpcomingEventState();
}

class _RegisteredUpcomingEventState extends State<RegisteredUpcomingEvent> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewEvent>>(
        stream: UserManagement().getUserRegisteredEvents(
            eventId: widget.usersInfo.registeredEvents, context: context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          List<NewEvent> initialEvent = snapshot.data!;
          List<NewEvent> event = [];
          for (int i = 0; i < initialEvent.length; i++) {
            if (initialEvent[i].eventDateTime.isAfter(DateTime.now())) {
              event.add(initialEvent[i]);
            }
          }
          return Padding(
            padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
            child: event.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.registerUpcomingEventTitle,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 3.5 * SizeConfig.textMultiplier!,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: event.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: 2 * SizeConfig.heightMultiplier!),
                            child: EventImageWidget(
                              collectionName: Strings.eventCollectionTitle,
                              event: event[index],
                              isUserEvent: false,
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : SizedBox(
                    height: 20 * SizeConfig.heightMultiplier!,
                    child: Center(
                      child: Text(
                        Strings.registerUpcomingEventEmptyWarning,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
          );
        });
  }
}
