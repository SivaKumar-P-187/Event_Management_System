import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class ProfileField extends StatefulWidget {
  final String name;
  final IconData iconData;
  final VoidCallback onTap;
  const ProfileField({
    Key? key,
    required this.iconData,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  _ProfileFieldState createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 2,
        color: Colors.grey.shade50,
        child: ListTile(
          leading: Icon(
            widget.iconData,
            color: Colors.blue,
            size: 4 * SizeConfig.textMultiplier!,
          ),
          title: Text(
            widget.name,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 2.2 * SizeConfig.textMultiplier!,
                  overflow: TextOverflow.clip,
                ),
          ),
        ),
      ),
    );
  }
}
