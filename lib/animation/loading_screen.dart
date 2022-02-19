import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
          width: 25 * SizeConfig.widthMultiplier!,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius:
                BorderRadius.circular(5 * SizeConfig.widthMultiplier!),
          ),
          child: SpinKitFadingCircle(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              );
            },
            duration: Duration(seconds: 3),
            size: 12 * SizeConfig.imageSizeMultiplier!,
          ),
        ),
      ),
    );
  }
}
