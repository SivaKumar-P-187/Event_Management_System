import 'package:final_event/animation/login_signup.dart';
import 'package:final_event/color_list.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/authentication/bottom_screen.dart';
import 'package:final_event/authentication/login/sign_in.dart';
import 'package:final_event/authentication/text_field.dart';
import 'package:final_event/authentication/top_screen.dart';
import 'package:final_event/handler/error_handler.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:final_event/styling.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email = "";
  String _password = "";
  String _name = "";
  bool isLock = true;
  int? randomNumber;
  FaIcon faIcon = FaIcon(
    FontAwesomeIcons.exclamationTriangle,
    size: 10 * SizeConfig.imageSizeMultiplier!,
    color: Colors.red,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.authenticationBackgroundColor,
      body: SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopScreen(
                    text1: Strings.loginScreenSignUpButton,
                    text2: Strings.signUpWelcome,
                  ),
                  SizedBox(
                    height: 5 * SizeConfig.heightMultiplier!,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(16 * SizeConfig.widthMultiplier!),
                          topRight:
                              Radius.circular(16 * SizeConfig.widthMultiplier!),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.all(7 * SizeConfig.widthMultiplier!),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 2 * SizeConfig.heightMultiplier!,
                            ),
                            LoginSignUp(
                              time: 1,
                              child: Container(
                                padding: EdgeInsets.all(
                                    3 * SizeConfig.heightMultiplier!),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      3 * SizeConfig.widthMultiplier!),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, 3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    LoginSignUpTextField(
                                      value: (value) {
                                        setState(() {
                                          _name = value;
                                        });
                                      },
                                      iconData1: null,
                                      iconData2: null,
                                      isObscure: false,
                                      inputType: TextInputType.name,
                                      hint: Strings.signUpName,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                    ),
                                    LoginSignUpTextField(
                                      value: (value) {
                                        setState(() {
                                          _email = value;
                                        });
                                      },
                                      iconData1: null,
                                      iconData2: null,
                                      isObscure: false,
                                      inputType: TextInputType.emailAddress,
                                      hint: Strings.emailHintText,
                                    ),
                                    LoginSignUpTextField(
                                      hint: Strings.passwordHintText,
                                      inputType: TextInputType.visiblePassword,
                                      value: (value) {
                                        setState(() {
                                          _password = value;
                                        });
                                      },
                                      iconData1: Icons.lock,
                                      iconData2: Icons.lock_open,
                                      isObscure: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5 * SizeConfig.heightMultiplier!,
                            ),
                            Expanded(
                              child: BottomScreen(
                                buttonText1: Strings.signUpCreateAccount,
                                buttonText2: Strings.signUpBack,
                                text3: Strings.signUpHaveAccount,
                                button1: () async {
                                  _email.trim();
                                  _password.trim();
                                  _name.trim();
                                  randomNumber =
                                      randomBetween(0, ColorList.colors.length);
                                  setState(() {});
                                  if (checkData()) {
                                    await UserManagement().createUser(
                                        email: _email,
                                        password: _password,
                                        name: _name,
                                        number: randomNumber!,
                                        context: context);
                                  }
                                },
                                button2: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const SignIn(),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkData() {
    if (_email.isEmpty) {
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: faIcon,
          message: Strings.emailEmpty);
      return false;
    } else if (!RegExp(Strings.emailExpression).hasMatch(_email)) {
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: faIcon,
          message: Strings.emailValid);
      return false;
    } else if (_name.isEmpty) {
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: faIcon,
          message: Strings.signUpNameEmpty);
      return false;
    } else if (_password.isEmpty) {
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: faIcon,
          message: Strings.passwordEmpty);
      return false;
    } else if (_password.length < 5) {
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: faIcon,
          message: Strings.passwordValid);
      return false;
    }
    return true;
  }
}
