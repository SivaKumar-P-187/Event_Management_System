import 'package:final_event/handler/error_handler.dart';
import 'package:final_event/json/event_.dart';
import 'package:final_event/json/users_.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomScreen extends StatefulWidget {
  final NewEvent event;
  final bool isUserEvent;
  final String collectionName;
  const BottomScreen({
    Key? key,
    required this.event,
    required this.isUserEvent,
    required this.collectionName,
  }) : super(key: key);

  @override
  _BottomScreenState createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  String title = "";
  String uid = "";
  bool isPublished = false;
  @override
  void initState() {
    super.initState();
    int initial = (4.5 * SizeConfig.widthMultiplier!.toInt()).toInt();
    uid = SharedPreferencesHelper.getUserUid();
    title = widget.event.eventBuilding.length > initial
        ? widget.event.eventBuilding
            .replaceRange(initial - 1, widget.event.eventBuilding.length, "..")
        : widget.event.eventBuilding;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NewEvent>(
        stream: UserManagement().getEvent(
          eventUid: widget.event.eventId,
          collectionName: widget.collectionName,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final event = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier!,
              ),
              buildContactInfo(event: event),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottomMenu(
                      iconData: Icons.calendar_today,
                      title: event.date,
                      subTitle: event.year,
                      onTap: () {}),
                  bottomMenu(
                      iconData: Icons.location_pin,
                      title: title,
                      subTitle: event.buildingType,
                      onTap: () {
                        ErrorHandler().errorDialog(
                          title: Strings.eventRegistrationTitle,
                          context: context,
                          faIcon: FaIcon(
                            FontAwesomeIcons.addressBook,
                            size: 15 * SizeConfig.imageSizeMultiplier!,
                            color: Colors.grey,
                          ),
                          message: event.place,
                        );
                      }),
                  bottomMenu(
                      iconData: Icons.access_time,
                      title: event.time,
                      subTitle: event.period,
                      onTap: () {}),
                ],
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier!,
              ),
              widget.event.lastDateTime.isAfter(DateTime.now())
                  ? widget.isUserEvent
                      ? event.isPublished
                          ? buildPublished()
                          : buildNotPublished(event: event)
                      : event.participants.contains(uid)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: 3 * SizeConfig.widthMultiplier!),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 0,
                                    child: InkWell(
                                      onTap: () async {
                                        await UserManagement()
                                            .removeEventTOUser(
                                                uid: uid,
                                                eventId: event.eventId,
                                                context: context);
                                        await UserManagement()
                                            .removeUserToEvent(
                                                uid: uid,
                                                eventId: event.eventId,
                                                context: context);
                                      },
                                      child: Container(
                                        height:
                                            7 * SizeConfig.heightMultiplier!,
                                        width: 20 * SizeConfig.widthMultiplier!,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              4 * SizeConfig.widthMultiplier!),
                                        ),
                                        child: Center(
                                          child: Text(
                                            Strings.eventCancel,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontSize: 3 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1 * SizeConfig.widthMultiplier!,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {},
                                      child: Container(
                                        height:
                                            7 * SizeConfig.heightMultiplier!,
                                        width: 60 * SizeConfig.widthMultiplier!,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(
                                            4 * SizeConfig.widthMultiplier!,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            Strings.eventAttending,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                  fontSize: 2.5 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  right: 3 * SizeConfig.widthMultiplier!),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        await UserManagement().addEventTOUser(
                                            uid: uid,
                                            eventId: event.eventId,
                                            context: context);
                                        await UserManagement().addUserToEvent(
                                            uid: uid,
                                            eventId: event.eventId,
                                            context: context);
                                      },
                                      child: Container(
                                        height:
                                            7 * SizeConfig.heightMultiplier!,
                                        width: 60 * SizeConfig.widthMultiplier!,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(
                                            4 * SizeConfig.widthMultiplier!,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          Strings.eventAttend,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                fontSize: 2.5 *
                                                    SizeConfig.textMultiplier!,
                                              ),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                  : buildRegistrationCompleted(),
            ],
          );
        });
  }

  buildPublished() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {},
            child: Container(
              height: 7 * SizeConfig.heightMultiplier!,
              width: 60 * SizeConfig.widthMultiplier!,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  4 * SizeConfig.widthMultiplier!,
                ),
              ),
              child: Center(
                  child: Text(
                Strings.userEventPublishedButton,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontSize: 2.5 * SizeConfig.textMultiplier!,
                      letterSpacing: 2,
                    ),
              )),
            ),
          ),
        ),
      ],
    );
  }

  buildNotPublished({required NewEvent event}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              await UserManagement().updateToEvent(
                eventUid: event.eventId,
                context: context,
                event: event,
              );
              await UserManagement().updatePublishedEvent(
                  eventUid: event.eventId,
                  context: context,
                  collectionName: Strings.eventCollectionTitle);
              await UserManagement().updatePublishedEventToUser(
                eventUid: event.eventId,
                context: context,
                userUid: uid,
                event: event,
              );
              await UserManagement().updatePublishedEvent(
                  eventUid: event.eventId,
                  context: context,
                  collectionName: Strings.unpublishedEventCollectionTitle);
              await UserManagement().deletePublishedInUnPublished(
                eventUid: event.eventId,
                context: context,
              );
            },
            child: Container(
              height: 7 * SizeConfig.heightMultiplier!,
              width: 60 * SizeConfig.widthMultiplier!,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                color: Colors.red,
                borderRadius: BorderRadius.circular(
                  4 * SizeConfig.widthMultiplier!,
                ),
              ),
              child: Center(
                  child: Text(
                Strings.userEventNotPublishedButton,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontSize: 2.5 * SizeConfig.textMultiplier!,
                      letterSpacing: 2,
                    ),
              )),
            ),
          ),
        ),
      ],
    );
  }

  buildRegistrationCompleted() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 7 * SizeConfig.heightMultiplier!,
            width: 60 * SizeConfig.widthMultiplier!,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              color: Colors.red,
              borderRadius: BorderRadius.circular(
                4 * SizeConfig.widthMultiplier!,
              ),
            ),
            child: Center(
                child: Text(
              Strings.registrationCompleted,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 2.5 * SizeConfig.textMultiplier!,
                    letterSpacing: 2,
                  ),
            )),
          ),
        ),
      ],
    );
  }

  bottomMenu({
    required IconData iconData,
    required String title,
    required String subTitle,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 6 * SizeConfig.heightMultiplier!,
            width: 13 * SizeConfig.widthMultiplier!,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(3 * SizeConfig.widthMultiplier!),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Icon(iconData),
            ),
          ),
          SizedBox(
            width: 1 * SizeConfig.widthMultiplier!,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      letterSpacing: 0,
                      fontSize: 2 * SizeConfig.textMultiplier!,
                      overflow: TextOverflow.clip,
                    ),
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      overflow: TextOverflow.clip,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildContactInfo({required NewEvent event}) {
    return StreamBuilder<UsersInfo>(
        stream:
            UserManagement().getParticularUserInfo(uid: event.createUserUid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final usersInfo = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.eventContactInfoTitle,
                style: GoogleFonts.dmSerifDisplay(
                  textStyle: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier!,
              ),
              buildContactWidget(
                field: Strings.eventNameField,
                value: usersInfo.name,
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier!,
              ),
              buildContactWidget(
                field: Strings.eventPhoneField,
                value: usersInfo.phoneNo,
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier!,
              ),
              buildContactWidget(
                field: Strings.eventEmailField,
                value: usersInfo.email,
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier!,
              ),
            ],
          );
        });
  }

  buildContactWidget({required String field, required String value}) {
    return Padding(
      padding: EdgeInsets.only(
        left: 2 * SizeConfig.widthMultiplier!,
        right: 2 * SizeConfig.widthMultiplier!,
      ),
      child: Row(
        children: [
          Text(
            field,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  letterSpacing: 0,
                  fontSize: 2 * SizeConfig.textMultiplier!,
                  overflow: TextOverflow.clip,
                ),
          ),
          SizedBox(
            width: 3 * SizeConfig.widthMultiplier!,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
