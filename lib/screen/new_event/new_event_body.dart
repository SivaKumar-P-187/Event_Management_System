import 'dart:io';
import 'package:final_event/handler/error_handler.dart';
import 'package:final_event/json/event_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/new_event/event_field.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class NewEventBody extends StatefulWidget {
  final String eventType;
  const NewEventBody({
    Key? key,
    required this.eventType,
  }) : super(key: key);

  @override
  _NewEventBodyState createState() => _NewEventBodyState();
}

class _NewEventBodyState extends State<NewEventBody> {
  String eventName = "";
  String eventPlace = "";
  String eventDetails = "";
  String eventDate = "";
  String eventYear = "";
  String pickEventDateValue = "";
  String eventPeriod = "";
  String eventTime = "";
  String pickEventTimeValue = "";
  String eventImage = "";
  String eventBuilding = "";
  String? buildingType;
  DateTime? dateTime;
  DateTime? lastDateTime;
  TimeOfDay? time;
  TimeOfDay? lastTimePicker;
  File? image;
  bool eventPm = false;
  bool lastPm = false;
  String userUid = "";
  String userPhone = "";
  String eventId = "";
  String lastDate = "";
  DateTime? finalEventDate;
  DateTime? finalLastDate;
  List<String> items = [
    'Resort',
    'Palace',
    'Beach',
    'Temple',
    'Mountain',
    'House'
  ];
  @override
  void initState() {
    super.initState();
    userUid = SharedPreferencesHelper.getUserUid();
    userPhone = SharedPreferencesHelper.getUserPhoneNo();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.newEventImageField,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      letterSpacing: 0,
                    ),
              ),
              image == null
                  ? MaterialButton(
                      onPressed: () async {
                        await pickEventImage(
                          source: ImageSource.gallery,
                          context: context,
                        );
                      },
                      color: Colors.blue,
                      child: Text(
                        Strings.newEventPickImageButton,
                        style: Theme.of(context).textTheme.button,
                      ),
                    )
                  : MaterialButton(
                      onPressed: () async {
                        await pickEventImage(
                          source: ImageSource.gallery,
                          context: context,
                        );
                      },
                      color: Colors.blue,
                      child: Text(
                        Strings.newEventChangeImageButton,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
            ],
          ),
        ),
        image != null
            ? Padding(
                padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
                child: Stack(
                  children: [
                    Container(
                      height: 20 * SizeConfig.heightMultiplier!,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            3 * SizeConfig.widthMultiplier!,
                          ),
                        ),
                        image: DecorationImage(
                          image: FileImage(image!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                              2 * SizeConfig.widthMultiplier!),
                        ),
                        child: IconButton(
                          onPressed: () {
                            image = null;
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            size: 4 * SizeConfig.textMultiplier!,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox.shrink(),
        EventField(
          name: Strings.newEventNameField,
          maxLength: 50,
          maxLine: 1,
          onChange: (value) {
            setState(() {
              eventName = value;
            });
          },
        ),
        EventField(
          name: Strings.newEventBuildingField,
          maxLength: 50,
          maxLine: 1,
          onChange: (value) {
            setState(() {
              eventBuilding = value;
            });
          },
        ),
        EventField(
          name: Strings.newEventPlaceField,
          maxLength: 100,
          maxLine: 1,
          onChange: (value) {
            setState(() {
              eventPlace = value;
            });
          },
        ),
        EventField(
          name: Strings.newEventDetailsField,
          maxLength: 500,
          maxLine: 3,
          onChange: (value) {
            setState(() {
              eventDetails = value;
            });
          },
        ),

        ///event building type
        Padding(
          padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.newEventBuildingType,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      letterSpacing: 0,
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier! / 2,
                  horizontal: 2 * SizeConfig.widthMultiplier!,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                  borderRadius:
                      BorderRadius.circular(2 * SizeConfig.widthMultiplier!),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: buildingType,
                    iconSize: 5 * SizeConfig.textMultiplier!,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (values) =>
                        setState(() => buildingType = values as String?),
                  ),
                ),
              ),
            ],
          ),
        ),

        ///event date
        Padding(
          padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.newEventDateField,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      letterSpacing: 0,
                    ),
              ),
              eventDate.isEmpty
                  ? ElevatedButton(
                      onPressed: () async {
                        await pickDate(
                          context: context,
                        );
                      },
                      child: Text(
                        Strings.newEventPickDateButton,
                        style: Theme.of(context).textTheme.button,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await pickDate(
                          context: context,
                        );
                      },
                      child: Text(
                        eventDate + "-$eventYear",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
            ],
          ),
        ),

        ///event time
        Padding(
          padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.newEventTimeField,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      letterSpacing: 0,
                    ),
              ),
              eventTime.isEmpty
                  ? ElevatedButton(
                      onPressed: () async {
                        await pickTime(
                          context: context,
                        );
                      },
                      child: Text(
                        Strings.newEventPickTimeButton,
                        style: Theme.of(context).textTheme.button,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await pickTime(
                          context: context,
                        );
                      },
                      child: Text(
                        eventTime + eventPeriod,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
            ],
          ),
        ),

        ///last date
        Padding(
          padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.newEventLastDateField,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      letterSpacing: 0,
                    ),
              ),
              lastDate.isEmpty
                  ? ElevatedButton(
                      onPressed: () async {
                        if (dateTime != null) {
                          await pickLastDate(
                            context: context,
                          );
                        } else {
                          indicateUser(Strings.newEventChooseEventFirst);
                          return;
                        }
                      },
                      child: Text(
                        Strings.newEventPickDateButton,
                        style: Theme.of(context).textTheme.button,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await pickLastDate(
                          context: context,
                        );
                      },
                      child: Text(
                        lastDate,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
            ],
          ),
        ),

        ///last Time
        Padding(
          padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.newEventLastTimeField,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      letterSpacing: 0,
                    ),
              ),
              lastTimePicker == null
                  ? ElevatedButton(
                      onPressed: () async {
                        await pickLastTime(
                          context: context,
                        );
                      },
                      child: Text(
                        Strings.newEventPickDateButton,
                        style: Theme.of(context).textTheme.button,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await pickLastTime(
                          context: context,
                        );
                      },
                      child: Text(
                        lastTimePicker!.format(context),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
            ],
          ),
        ),

        ///registration button
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier! / 2,
            horizontal: 2 * SizeConfig.widthMultiplier!,
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (image != null &&
                  eventTime.isNotEmpty &&
                  eventDate.isNotEmpty &&
                  eventDetails.isNotEmpty &&
                  eventName.isNotEmpty &&
                  eventYear.isNotEmpty &&
                  eventPeriod.isNotEmpty &&
                  eventBuilding.isNotEmpty &&
                  buildingType!.isNotEmpty &&
                  eventPlace.isNotEmpty &&
                  lastDateTime != null &&
                  lastTimePicker != null) {
                finalEventDate = DateTime(
                  dateTime!.year,
                  dateTime!.month,
                  dateTime!.day,
                  eventPm ? 12 + time!.hour : time!.hour,
                  time!.minute,
                  0,
                  0,
                  0,
                );
                finalLastDate = DateTime(
                  lastDateTime!.year,
                  lastDateTime!.month,
                  lastDateTime!.day,
                  lastPm ? 12 + lastTimePicker!.hour : lastTimePicker!.hour,
                  time!.minute,
                  0,
                  0,
                  0,
                );
                setState(() {});
                eventId = randomAlphaNumeric(11);
                setState(() {});
                NewEvent newEvent = NewEvent(
                  eventName: eventName,
                  eventImage: "",
                  eventType: widget.eventType,
                  eventId: eventId,
                  eventBuilding: eventBuilding,
                  buildingType: buildingType!,
                  place: eventPlace,
                  date: eventDate,
                  year: eventYear,
                  time: eventTime,
                  period: eventPeriod,
                  details: eventDetails,
                  participants: [],
                  createUserUid: userUid,
                  isPublished: false,
                  eventPickTime: pickEventTimeValue,
                  lastTime: lastTimePicker!.format(context),
                  eventDateTime: finalEventDate!,
                  lastDateTime: lastDateTime!,
                );
                Map<String, dynamic> eventMap = newEvent.toMap();
                await UserManagement().updateNewEvent(
                  context: context,
                  eventDetails: eventMap,
                );
                await UserManagement().uploadEventImage(
                  image: image!.path.toString(),
                  uid: userUid,
                  eventId: eventId,
                  context: context,
                );
                await UserManagement().updateEventToUser(
                  context: context,
                  userUid: userUid,
                  eventId: eventId,
                );
                Navigator.of(context).pop();
                indicateUser(Strings.newEventSuccessfulMessage);
                Navigator.of(context).pushReplacementNamed('/home');
              } else {
                if (image == null) {
                  indicateUser(Strings.newEventWarringImageEmpty);
                } else if (eventName.isEmpty) {
                  indicateUser(Strings.newEventWarringNameEmpty);
                } else if (eventBuilding.isEmpty) {
                  indicateUser(Strings.newEventWarringBuildingEmpty);
                } else if (buildingType!.isEmpty) {
                  indicateUser(Strings.newEventWarringBuildingTypeEmpty);
                } else if (eventPlace.isEmpty) {
                  indicateUser(Strings.newEventWarringPlaceEmpty);
                } else if (eventDetails.isEmpty) {
                  indicateUser(Strings.newEventWarringDetailsEmpty);
                } else if (eventDate.isEmpty) {
                  indicateUser(Strings.newEventWarringDateEmpty);
                } else if (eventTime.isEmpty) {
                  indicateUser(Strings.newEventWarringTimeEmpty);
                } else if (lastDate.isEmpty) {
                  indicateUser(Strings.newEventWarringLastDateEmpty);
                } else if (lastTimePicker == null) {
                  indicateUser(Strings.newEventWarringLastTimeEmpty);
                }
              }
            },
            child: Text(
              Strings.newEventCreateEventButton,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ],
    );
  }

  Future pickDate({required BuildContext context}) async {
    final initialDate = dateTime ?? DateTime.now();
    final dateBirth = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().day + 1),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (dateBirth == null) return;
    if (dateBirth.isBefore(DateTime.now())) {
      indicateUser(Strings.newEventBirthEmpty);
      return;
    }
    dateTime = dateBirth;
    eventYear = dateTime!.year.toString();
    eventDate = DateFormat(Strings.newEventDateFormat).format(dateBirth);
    pickEventDateValue = DateFormat("dd-MM-yyyy").format(dateBirth);
    setState(() {});
  }

  Future pickTime({required BuildContext context}) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );
    if (newTime == null) return;
    time = newTime;
    final hour = newTime.hour <= 12
        ? newTime.hour.toString().padLeft(2, '0')
        : (newTime.hour - 12).toString().padLeft(2, '0');
    final minute = newTime.minute.toString().padLeft(2, '0');
    pickEventTimeValue = newTime.format(context);
    eventPeriod = newTime.period.name.toUpperCase();
    eventTime = hour + '.' + minute;
    eventPm = newTime.period.name.toUpperCase() == "PM" ? true : false;
    setState(() {});
  }

  Future pickLastDate({required BuildContext context}) async {
    final initialDate = lastDateTime ?? DateTime.now();
    final lastDatePick = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().day + 1),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (lastDatePick == null) return;
    if (lastDatePick.isAtSameMomentAs(dateTime!)) {
      indicateUser(Strings.newEventWarringLastEventSame);
      return;
    }
    if (lastDatePick.isAfter(dateTime!)) {
      indicateUser(Strings.newEventWarringLastDateValid);
      return;
    }
    lastDate = DateFormat("dd-MM-yyyy").format(lastDatePick);
    lastDateTime = lastDatePick;
    setState(() {});
  }

  Future pickLastTime({required BuildContext context}) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );
    if (newTime == null) return;
    lastTimePicker = newTime;
    lastPm = newTime.period.name.toUpperCase() == "PM" ? true : false;
    setState(() {});
  }

  ///pick event image from gallery
  pickEventImage({
    required ImageSource source,
    required BuildContext context,
  }) async {
    try {
      final images =
          await ImagePicker().pickImage(source: source, imageQuality: 100);
      if (images == null) return;
      image = File(images.path);
      setState(() {});
    } on PlatformException catch (e) {
      ErrorHandler().errorDialog(
        title: Strings.errorTitle,
        context: context,
        faIcon: FaIcon(
          FontAwesomeIcons.exclamationTriangle,
          size: 10 * SizeConfig.imageSizeMultiplier!,
          color: Colors.red,
        ),
        message: e.message.toString(),
      );
    }
  }

  indicateUser(String info) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          info,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 2 * SizeConfig.textMultiplier!,
              ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      );
}
