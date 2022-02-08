import 'package:final_event/json/event_.dart';
import 'package:final_event/screen/event_page/bottom_screen.dart';
import 'package:final_event/screen/event_page/top_screen.dart';
import 'package:final_event/screen/images.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class Event extends StatefulWidget {
  final NewEvent event;
  final bool isUserEvent;
  final String collectionName;
  const Event({
    Key? key,
    required this.event,
    required this.isUserEvent,
    required this.collectionName,
  }) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
                size: 3.5 * SizeConfig.textMultiplier!,
              ),
            ),
          )
        ],
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 3 * SizeConfig.widthMultiplier!,
              top: 2 * SizeConfig.heightMultiplier!,
              bottom: 3 * SizeConfig.widthMultiplier!,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.event.eventImage != null
                    ? Container(
                        height: 25 * SizeConfig.heightMultiplier!,
                        width: 93.5 * SizeConfig.widthMultiplier!,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            6 * SizeConfig.widthMultiplier!,
                          ),
                          color: Colors.grey.shade100,
                        ),
                        child: Hero(
                          tag: widget.event,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              6 * SizeConfig.widthMultiplier!,
                            ),
                            child: ImagesWidget(
                              image: widget.event.eventImage!,
                              height: 25 * SizeConfig.imageSizeMultiplier!,
                              width: 93.5 * SizeConfig.imageSizeMultiplier!,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 2 * SizeConfig.heightMultiplier!,
                ),
                TopScreen(
                  event: widget.event,
                  collectionName: widget.collectionName,
                ),
                BottomScreen(
                  event: widget.event,
                  isUserEvent: widget.isUserEvent,
                  collectionName: widget.collectionName,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
