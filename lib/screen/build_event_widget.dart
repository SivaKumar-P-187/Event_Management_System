import 'package:final_event/json/event_.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/screen/event_page/event_home.dart';
import 'package:final_event/screen/images.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventImageWidget extends StatefulWidget {
  final NewEvent event;
  final bool isUserEvent;
  final String collectionName;
  const EventImageWidget({
    Key? key,
    required this.event,
    required this.collectionName,
    required this.isUserEvent,
  }) : super(key: key);

  @override
  _EventImageWidgetState createState() => _EventImageWidgetState();
}

class _EventImageWidgetState extends State<EventImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 37 * SizeConfig.heightMultiplier!,
          width: 93.5 * SizeConfig.widthMultiplier!,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              6 * SizeConfig.widthMultiplier!,
            ),
            color: Colors.grey.shade50,
          ),
        ),
        InkWell(
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Event(
                  event: widget.event,
                  isUserEvent: widget.isUserEvent,
                  collectionName: widget.collectionName,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6 * SizeConfig.widthMultiplier!),
                      topRight:
                          Radius.circular(6 * SizeConfig.widthMultiplier!),
                    ),
                    child: ImagesWidget(
                      image: widget.event.eventImage!,
                      height: 25 * SizeConfig.imageSizeMultiplier!,
                      width: 93.5 * SizeConfig.imageSizeMultiplier!,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 1 * SizeConfig.heightMultiplier!,
                left: 3 * SizeConfig.widthMultiplier!,
                child: Text(
                  widget.event.eventName,
                  style: GoogleFonts.dmSerifDisplay(
                    textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 3.5 * SizeConfig.textMultiplier!,
                          color: Colors.white,
                          overflow: TextOverflow.clip,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 26 * SizeConfig.heightMultiplier!,
            child: SizedBox(
              width: 93.5 * SizeConfig.imageSizeMultiplier!,
              child: buildRowDetails(
                event: widget.event,
              ),
            )),
      ],
    );
  }

  buildRowDetails({required NewEvent event}) {
    return Padding(
      padding: EdgeInsets.only(
        left: 2 * SizeConfig.widthMultiplier!,
        right: 2 * SizeConfig.widthMultiplier!,
        top: 2 * SizeConfig.widthMultiplier!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildFieldWidget(
                iconData: FontAwesomeIcons.calendarDay,
                value: DateFormat.yMMMEd().format(event.eventDateTime),
              ),
              buildFieldWidget(
                iconData: FontAwesomeIcons.stopwatch,
                value: event.eventPickTime,
              ),
            ],
          ),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier!,
          ),
          buildFieldWidget(
            iconData: FontAwesomeIcons.mapMarkerAlt,
            value: event.eventBuilding + ',' + event.buildingType,
          )
        ],
      ),
    );
  }

  buildFieldWidget({required IconData iconData, required String value}) {
    return Row(
      children: [
        FaIcon(
          iconData,
          color: Colors.black87,
          size: 4 * SizeConfig.imageSizeMultiplier!,
        ),
        SizedBox(
          width: 1 * SizeConfig.widthMultiplier!,
        ),
        Text(
          value,
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
      ],
    );
  }
}
