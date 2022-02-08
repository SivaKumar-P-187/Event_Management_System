import 'package:final_event/screen/profile/profile_body.dart';
import 'package:final_event/screen/profile/profile_image_home.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ProfilePhoto(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}
