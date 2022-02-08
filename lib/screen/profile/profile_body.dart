import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/profile/edit_dialog.dart';
import 'package:final_event/screen/profile/profile_field.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String name = "";
  String uid = "";
  String photo = "";
  String email = "";
  String password = "";
  String address = "";
  String phoneNo = "";
  String dateOfBirth = "";
  String tempValue = "";
  @override
  void initState() {
    super.initState();
    photo = SharedPreferencesHelper.getUserPhoto();
    address = SharedPreferencesHelper.getUserAddress();
    dateOfBirth = SharedPreferencesHelper.getDateOfBirth();
    phoneNo = SharedPreferencesHelper.getUserPhoneNo();
    name = SharedPreferencesHelper.getUserName();
    uid = SharedPreferencesHelper.getUserUid();
    password = SharedPreferencesHelper.getPassword();
    email = SharedPreferencesHelper.getUserEmail();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileField(
            iconData: Icons.person_outline,
            name: name,
            onTap: () {
              EditProfile().editProfile(
                context: context,
                label: Strings.profileNameLabel,
                value: name,
                maxLine: 1,
                textInputType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    tempValue = value;
                  });
                },
                onSaved: () async {
                  Navigator.of(context).pop();
                  if (tempValue.isNotEmpty) {
                    setState(() {
                      name = tempValue;
                      tempValue = "";
                    });
                    await UserManagement().updateUserData(
                        key: name,
                        uid: uid,
                        field: Strings.profileNameField,
                        context: context);
                    await UserManagement()
                        .updateLocalName(name: name, context: context);
                  } else {
                    createSnackBar(Strings.profileWarringNameEmpty);
                  }
                },
                onCancel: () {
                  Navigator.of(context).pop();
                  setState(() {
                    tempValue = "";
                  });
                },
              );
            },
          ),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier!,
          ),
          ProfileField(
            iconData: Icons.email_outlined,
            name: email,
            onTap: () {
              createSnackBar(Strings.profileWarringEmailEmpty);
            },
          ),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier!,
          ),
          ProfileField(
            iconData: Icons.calendar_today_rounded,
            name: dateOfBirth.isNotEmpty
                ? dateOfBirth
                : Strings.profileBirthEmptyMessage,
            onTap: () async {
              await pickDate(context);
            },
          ),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier!,
          ),
          ProfileField(
            iconData: Icons.phone_android_sharp,
            name:
                phoneNo.isNotEmpty ? phoneNo : Strings.profilePhoneEmptyMessage,
            onTap: () {
              EditProfile().editProfile(
                context: context,
                label: Strings.profilePhoneLabel,
                value: phoneNo,
                maxLine: 1,
                textInputType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    tempValue = value;
                  });
                },
                onSaved: () async {
                  Navigator.of(context).pop();
                  if (tempValue.isNotEmpty && (tempValue.length == 10)) {
                    setState(() {
                      phoneNo = tempValue;
                      tempValue = "";
                    });
                    await UserManagement().updateUserData(
                        key: phoneNo,
                        uid: uid,
                        field: Strings.profilePhoneField,
                        context: context);
                    await UserManagement()
                        .updateLocalPhoneNo(phoneNo: phoneNo, context: context);
                  } else {
                    if (tempValue.isEmpty) {
                      createSnackBar(Strings.profileWarringPhoneEmpty);
                    } else if (tempValue.length > 10 || tempValue.length < 10) {
                      createSnackBar(Strings.profileWarringPhoneValid);
                    }
                  }
                },
                onCancel: () {
                  Navigator.of(context).pop();
                  setState(() {
                    tempValue = "";
                  });
                },
              );
            },
          ),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier!,
          ),
          ProfileField(
            iconData: Icons.home,
            name: address.isNotEmpty
                ? address
                : Strings.profileAddressEmptyMessage,
            onTap: () {
              EditProfile().editProfile(
                context: context,
                label: Strings.profileAddressLabel,
                value: address,
                maxLine: 3,
                textInputType: TextInputType.streetAddress,
                onChanged: (value) {
                  setState(() {
                    tempValue = value;
                  });
                },
                onSaved: () async {
                  Navigator.of(context).pop();
                  if (tempValue.isNotEmpty) {
                    setState(() {
                      address = tempValue;
                      tempValue = "";
                    });
                    await UserManagement().updateUserData(
                        key: address,
                        uid: uid,
                        field: Strings.profileAddressField,
                        context: context);
                    await UserManagement()
                        .updateLocalAddress(address: address, context: context);
                  } else {
                    if (tempValue.isEmpty) {
                      createSnackBar(Strings.profileWarringAddressEmpty);
                    }
                  }
                },
                onCancel: () {
                  Navigator.of(context).pop();
                  setState(() {
                    tempValue = "";
                  });
                },
              );
            },
          ),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier!,
          ),
          ProfileField(
            iconData: Icons.remove_red_eye_outlined,
            name: password,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 2 * SizeConfig.textMultiplier!,
              ),
        ),
        backgroundColor: Colors.black);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final dateBirth = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 90),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (dateBirth == null) return;
    dateOfBirth = DateFormat(Strings.profileBirthFormat).format(dateBirth);
    setState(() {});
    await UserManagement().updateUserData(
        key: dateOfBirth,
        uid: uid,
        field: Strings.profileBirthField,
        context: context);
    await UserManagement()
        .updateLocalDateOfBirth(date: dateOfBirth, context: context);
    setState(() {});
  }
}
