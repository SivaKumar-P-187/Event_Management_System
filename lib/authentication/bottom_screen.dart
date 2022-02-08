import 'package:final_event/animation/login_signup.dart';
import 'package:final_event/styling.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class BottomScreen extends StatefulWidget {
  final String buttonText1;
  final String buttonText2;
  final String text3;
  final VoidCallback button1;
  final VoidCallback button2;
  const BottomScreen({
    Key? key,
    required this.text3,
    required this.buttonText1,
    required this.buttonText2,
    required this.button1,
    required this.button2,
  }) : super(key: key);

  @override
  _BottomScreenState createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginSignUp(
          time: 1,
          child: InkWell(
            onTap: widget.button1,
            child: Container(
              height: 6.5 * SizeConfig.heightMultiplier!,
              margin: EdgeInsets.symmetric(
                horizontal: 12 * SizeConfig.widthMultiplier!,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
                color: AppTheme.button1,
              ),
              child: Center(
                child: Text(
                  widget.buttonText1,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginSignUp(
                  time: 1,
                  child: Text(
                    widget.text3,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  height: 2 * SizeConfig.widthMultiplier!,
                ),
                LoginSignUp(
                  time: 1,
                  child: InkWell(
                    onTap: widget.button2,
                    child: Container(
                      height: 6.5 * SizeConfig.heightMultiplier!,
                      margin: EdgeInsets.symmetric(
                        horizontal: 12 * SizeConfig.widthMultiplier!,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            6 * SizeConfig.widthMultiplier!),
                        color: AppTheme.button2,
                      ),
                      child: Center(
                        child: Text(
                          widget.buttonText2,
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
