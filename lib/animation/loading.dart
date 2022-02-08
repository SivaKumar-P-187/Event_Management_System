// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_this, sized_box_for_whitespace, unnecessary_new

import 'dart:math';

import 'package:final_event/size_config.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    final keys = GlobalKey<_LoadingState>();
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async {
              keys.currentState!.dispose();
              return false;
            },
            child: SimpleDialog(
              key: key,
              backgroundColor: Colors.black54,
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      Loading(),
                      SizedBox(
                        height: 1 * SizeConfig.heightMultiplier!,
                      ),
                      Text(
                        "Please Wait....",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationRadiusIn;
  late Animation<double> _animationRadiusOut;
  late Animation<double> animationRotation;
  final double initialRadius = 30;
  double radius = 0.0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.0, 1.0, curve: Curves.linear)),
    );
    _animationRadiusIn = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );
    _animationRadiusOut = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );
    _animationController.addListener(() {
      setState(() {
        if (_animationController.value >= 0.75 &&
            _animationController.value <= 1.0) {
          radius = _animationRadiusIn.value * initialRadius;
        } else if (_animationController.value >= 0.0 &&
            _animationController.value <= 0.25) {
          radius = _animationRadiusOut.value * initialRadius;
        }
      });
    });
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10 * SizeConfig.widthMultiplier!,
      height: 10 * SizeConfig.heightMultiplier!,
      child: Center(
        child: RotationTransition(
          turns: animationRotation,
          child: Container(
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(
                    0.0,
                    0.0,
                  ),
                  child: Dot(color: Colors.grey, radius: 30.0),
                ),
                Transform.translate(
                    offset: Offset(
                      radius * cos(pi / 4),
                      radius * sin(pi / 4),
                    ),
                    child: Dot(color: Colors.red, radius: 5.0)),
                Transform.translate(
                  offset: Offset(
                    radius * cos(2 * pi / 4),
                    radius * sin(2 * pi / 4),
                  ),
                  child: Dot(color: Colors.green, radius: 5.0),
                ),
                Transform.translate(
                  offset: Offset(
                    radius * cos(3 * pi / 4),
                    radius * sin(3 * pi / 4),
                  ),
                  child: Dot(color: Colors.amber, radius: 5.0),
                ),
                Transform.translate(
                  offset: Offset(
                    radius * cos(4 * pi / 4),
                    radius * sin(4 * pi / 4),
                  ),
                  child: Dot(color: Colors.limeAccent, radius: 5.0),
                ),
                Transform.translate(
                  offset: Offset(
                    radius * cos(5 * pi / 4),
                    radius * sin(5 * pi / 4),
                  ),
                  child: Dot(color: Colors.deepOrangeAccent, radius: 5.0),
                ),
                Transform.translate(
                  offset: Offset(
                    radius * cos(6 * pi / 4),
                    radius * sin(6 * pi / 4),
                  ),
                  child: Dot(color: Colors.pinkAccent, radius: 5.0),
                ),
                Transform.translate(
                  offset: Offset(
                    radius * cos(7 * pi / 4),
                    radius * sin(7 * pi / 4),
                  ),
                  child: Dot(color: Colors.blueAccent, radius: 5.0),
                ),
                Transform.translate(
                  offset: Offset(
                    radius * cos(8 * pi / 4),
                    radius * sin(8 * pi / 4),
                  ),
                  child: Dot(color: Colors.tealAccent, radius: 5.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  const Dot({
    Key? key,
    required this.color,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: this.radius,
        width: this.radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: this.color,
        ),
      ),
    );
  }
}
