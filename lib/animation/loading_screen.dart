import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class MainLoading extends StatefulWidget {
  const MainLoading({Key? key}) : super(key: key);

  @override
  _MainLoadingState createState() => _MainLoadingState();
}

class _MainLoadingState extends State<MainLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 10 * SizeConfig.heightMultiplier!,
          width: 20 * SizeConfig.widthMultiplier!,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius:
                BorderRadius.circular(5 * SizeConfig.widthMultiplier!),
          ),
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey.shade200,
              color: Colors.red,
              strokeWidth: 7.0,
            ),
          ),
        ),
      ),
    );
  }
}
