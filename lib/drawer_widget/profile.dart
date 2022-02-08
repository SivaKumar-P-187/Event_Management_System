import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/profile/home.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class Profile extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Profile({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String dateOfBirth = "";
  String phoneNo = "";
  String address = "";
  String photo = "";
  @override
  void initState() {
    super.initState();
    photo = SharedPreferencesHelper.getUserPhoto();
    address = SharedPreferencesHelper.getUserAddress();
    dateOfBirth = SharedPreferencesHelper.getDateOfBirth();
    phoneNo = SharedPreferencesHelper.getUserPhoneNo();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.scaffoldKey.currentState!.isDrawerOpen) {
          Navigator.pop(context);
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      },
      child: ListTile(
        leading: Stack(
          children: [
            Icon(
              Icons.person_outline,
              color: Colors.grey.shade300,
              size: 4 * SizeConfig.textMultiplier!,
            ),
            (dateOfBirth.isEmpty ||
                        phoneNo.isEmpty ||
                        address.isEmpty ||
                        photo.isEmpty) ==
                    true
                ? Positioned(
                    top: 0,
                    child: Container(
                      height: 2 * SizeConfig.heightMultiplier!,
                      width: 2 * SizeConfig.widthMultiplier!,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        title: Text(
          Strings.profileTitle,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
