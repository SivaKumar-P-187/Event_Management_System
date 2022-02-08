import 'package:final_event/management/firebase.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class SignOut extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SignOut({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        UserManagement().signOut(context: context);
      },
      child: ListTile(
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.grey.shade300,
          size: 4 * SizeConfig.textMultiplier!,
        ),
        title: Text(
          Strings.signOutTitle,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
