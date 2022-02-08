import 'package:final_event/animation/login_signup.dart';
import 'package:final_event/authentication/bottom_screen.dart';
import 'package:final_event/authentication/createaccount/sign_up.dart';
import 'package:final_event/authentication/text_field.dart';
import 'package:final_event/authentication/top_screen.dart';
import 'package:final_event/handler/error_handler.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/string.dart';
import 'package:final_event/styling.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email = "";
  String _password = "";
  bool isLock = true;
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
                    text1: Strings.loginTitle,
                    text2: Strings.loginScreenWelcomeMessage,
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
                            EdgeInsets.all(8 * SizeConfig.widthMultiplier!),
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
                              height: 3 * SizeConfig.heightMultiplier!,
                            ),
                            LoginSignUp(
                              time: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  Strings.loginScreenForgotPassword,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2 * SizeConfig.heightMultiplier!,
                            ),
                            Expanded(
                              child: BottomScreen(
                                buttonText1: Strings.loginScreenLoginButton,
                                buttonText2: Strings.loginScreenSignUpButton,
                                text3: Strings.loginScreenNewToApp,
                                button1: () async {
                                  _email.trim();
                                  _password.trim();
                                  setState(() {});

                                  if (checkData()) {
                                    await UserManagement().signInUser(
                                      email: _email,
                                      password: _password,
                                      context: context,
                                    );
                                  }
                                },
                                button2: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
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
        message: Strings.emailEmpty,
      );
      return false;
    } else if (!RegExp(Strings.emailExpression).hasMatch(_email)) {
      ErrorHandler().errorDialog(
          title: Strings.errorTitle,
          context: context,
          faIcon: faIcon,
          message: Strings.emailValid);
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
