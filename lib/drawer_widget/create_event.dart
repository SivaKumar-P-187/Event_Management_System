import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/new_event/new_event_home.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class CreateEvent extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CreateEvent({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final items = ['Birthday', 'Anniversary'];
  String? eventType;
  String userPhone = "";
  String userPhoto = "";
  String userDateOfBirth = "";
  String userAddress = "";
  @override
  void initState() {
    super.initState();
    userPhone = SharedPreferencesHelper.getUserPhoneNo();
    userAddress = SharedPreferencesHelper.getUserAddress();
    userPhoto = SharedPreferencesHelper.getUserPhoto();
    userDateOfBirth = SharedPreferencesHelper.getDateOfBirth();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (userDateOfBirth.isNotEmpty &&
            userPhoto.isNotEmpty &&
            userAddress.isNotEmpty &&
            userPhone.isNotEmpty) {
          await eventTypeFun();
        } else {
          if (widget.scaffoldKey.currentState!.isDrawerOpen) {
            Navigator.pop(context);
          }
          if (userPhoto.isEmpty) {
            indicateUser(Strings.createEventProfileEmpty);
          } else if (userPhone.isEmpty) {
            indicateUser(Strings.createEventPhoneEmpty);
          } else if (userAddress.isEmpty) {
            indicateUser(Strings.createEventAddressEmpty);
          } else {
            indicateUser(Strings.createEventBirthEmpty);
          }
        }
      },
      child: ListTile(
        leading: Icon(
          Icons.add_box_outlined,
          color: Colors.grey.shade300,
          size: 4 * SizeConfig.textMultiplier!,
        ),
        title: Text(
          Strings.createEventTitle,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }

  Future eventTypeFun() async {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            Strings.createEventType,
            style: Theme.of(context).textTheme.headline2,
          ),
          content: Container(
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
                value: eventType,
                iconSize: 5 * SizeConfig.textMultiplier!,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                items: items.map(buildMenuItem).toList(),
                onChanged: (values) =>
                    setState(() => eventType = values as String?),
              ),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                if (eventType != null) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewEventHome(
                        eventType: eventType!,
                      ),
                    ),
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                Strings.createEventDoneButton,
                style: Theme.of(context).textTheme.button,
              ),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
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
