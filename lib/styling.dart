import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';

class AppTheme {
  AppTheme._();
  static const Color appBackgroundColor = Color(0xFFFFFFFF);
  static const Color topBarBackgroundColor = Color(0xFFFFD974);
  static const Color selectedTabBackgroundColor = Color(0xFFFFC442);
  static const Color unSelectedTabBackgroundColor = Color(0xFFFFFFFC);
  static const Color subTitleTextColor = Color(0xFF9F988F);
  static const Color button1 = Color(0xFFE65100);
  static const Color button2 = Color(0xFF000000);
  static const Color authenticationBackgroundColor = Color(0xFFF65726);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.appBackgroundColor,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
  );

  static final TextTheme lightTextTheme = TextTheme(
    subtitle1: _titleStyle,
    subtitle2: _subTitle,
    button: _button,
    bodyText1: _fieldStyle,
    bodyText2: _inputStyle,
    headline1: _homeTitle,
    headline2: _titleNameStyle,
  );

  static final TextStyle _titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 5.5 * SizeConfig.textMultiplier!,
  );
  static final TextStyle _subTitle = TextStyle(
    color: Colors.white,
    fontSize: 3.5 * SizeConfig.textMultiplier!,
  );
  static final TextStyle _button = TextStyle(
    color: Colors.white,
    fontSize: 2.5 * SizeConfig.textMultiplier!,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle _fieldStyle = TextStyle(
    color: Colors.grey,
    fontSize: 2 * SizeConfig.textMultiplier!,
  );
  static final TextStyle _inputStyle = TextStyle(
    color: Colors.black,
    fontSize: 2 * SizeConfig.textMultiplier!,
  );
  static final TextStyle _homeTitle = TextStyle(
    color: Colors.black,
    letterSpacing: 1.5,
    fontSize: 2.7 * SizeConfig.textMultiplier!,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle _titleNameStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 2.5 * SizeConfig.textMultiplier!,
  );
}
