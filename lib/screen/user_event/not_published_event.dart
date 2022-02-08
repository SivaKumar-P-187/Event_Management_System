import 'package:final_event/json/event_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/screen/build_event_widget.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class NotPublishedEvent extends StatefulWidget {
  final String userUid;
  const NotPublishedEvent({
    Key? key,
    required this.userUid,
  }) : super(key: key);

  @override
  _NotPublishedEventState createState() => _NotPublishedEventState();
}

class _NotPublishedEventState extends State<NotPublishedEvent> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewEvent>>(
        stream:
            UserManagement().getUserEventNotPublished(userUid: widget.userUid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          List<NewEvent> event = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
            child: event.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.userEventNotPublishTitle,
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
                              event: event[index],
                              collectionName:
                                  Strings.unpublishedEventCollectionTitle,
                              isUserEvent: true,
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          );
        });
  }
}
