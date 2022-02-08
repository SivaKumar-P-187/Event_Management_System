import 'package:final_event/size_config.dart';
import 'package:flutter/material.dart';

class MenuIcon extends StatefulWidget {
  const MenuIcon({Key? key}) : super(key: key);

  @override
  _MenuIconState createState() => _MenuIconState();
}

class _MenuIconState extends State<MenuIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCircle(),
            buildCircle(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCircle(),
            buildCircle(),
          ],
        ),
      ],
    );
  }

  buildCircle() {
    return Container(
      height: 2.3 * SizeConfig.heightMultiplier!,
      width: 2.3 * SizeConfig.widthMultiplier!,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }
}
