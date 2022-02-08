import 'package:final_event/json/event_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/build_event_widget.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class AllEvents extends StatefulWidget {
  final String eventType;
  const AllEvents({
    Key? key,
    required this.eventType,
  }) : super(key: key);

  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
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
        if (widget.eventType != "All Event") {
          event.removeWhere((element) => element.eventType != widget.eventType);
        }
        return Padding(
          padding: EdgeInsets.only(
            left: 2 * SizeConfig.widthMultiplier!,
            right: 2 * SizeConfig.widthMultiplier!,
          ),
          child: event.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: event.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 2 * SizeConfig.heightMultiplier!),
                      child: EventImageWidget(
                        event: event[index],
                        isUserEvent: false,
                        collectionName: Strings.eventCollectionTitle,
                      ),
                    );
                  },
                )
              : SizedBox(
                  height: 20 * SizeConfig.heightMultiplier!,
                  child: Center(
                    child: Text(
                      Strings.emptyEventWarning,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
