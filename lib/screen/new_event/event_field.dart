import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class EventField extends StatefulWidget {
  final String name;
  final int maxLength;
  final int maxLine;
  final ValueChanged<String> onChange;
  const EventField({
    Key? key,
    required this.name,
    required this.onChange,
    required this.maxLine,
    required this.maxLength,
  }) : super(key: key);

  @override
  _EventFieldState createState() => _EventFieldState();
}

class _EventFieldState extends State<EventField> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 1 * SizeConfig.widthMultiplier!,
        right: 1 * SizeConfig.widthMultiplier!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  letterSpacing: 0,
                ),
          ),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier!,
          ),
          TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 2 * SizeConfig.textMultiplier!,
                ),
            maxLength: widget.maxLength,
            maxLines: widget.maxLine,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  3 * SizeConfig.widthMultiplier!,
                ),
              ),
            ),
            onChanged: widget.onChange,
          ),
        ],
      ),
    );
  }
}
