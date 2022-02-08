import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class TopScreen extends StatefulWidget {
  final String text1;
  final String text2;
  const TopScreen({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 5 * SizeConfig.widthMultiplier!,
        right: 5 * SizeConfig.widthMultiplier!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2 * SizeConfig.heightMultiplier!,
          ),
          Text(
            widget.text1,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 1.7 * SizeConfig.heightMultiplier!,
          ),
          Text(
            widget.text2,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
