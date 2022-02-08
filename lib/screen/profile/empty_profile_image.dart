import 'package:flutter/material.dart';
import 'package:final_event/color_list.dart';

class EmptyProfilePhoto extends StatefulWidget {
  final int colorNumber;
  final String email;
  final double height;
  const EmptyProfilePhoto({
    Key? key,
    required this.height,
    required this.email,
    required this.colorNumber,
  }) : super(key: key);

  @override
  _EmptyProfilePhotoState createState() => _EmptyProfilePhotoState();
}

class _EmptyProfilePhotoState extends State<EmptyProfilePhoto> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: widget.height,
      backgroundColor: ColorList.colors[widget.colorNumber],
      child: Center(
        child: Text(
          widget.email.substring(0, 1).toUpperCase(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
