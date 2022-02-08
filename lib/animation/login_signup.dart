// ignore_for_file: unnecessary_new, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class LoginSignUp extends StatefulWidget {
  final int time;
  final Widget child;
  LoginSignUp({
    Key? key,
    required this.time,
    required this.child,
  }) : super(key: key);

  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      duration: new Duration(seconds: widget.time),
      vsync: this,
    );
    animation = new Tween(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child1) {
        return Container(
          child: Transform(
            transform:
                Matrix4.translationValues(0.0, animation.value * width, 0.0),
            child: widget.child,
          ),
        );
      },
    );
  }
}
