import 'package:final_event/authentication/login/sign_in.dart';
import 'package:final_event/animation/loading_screen.dart';
import 'package:final_event/management/firebase.dart';
import 'package:final_event/management/local_storage.dart';
import 'package:final_event/screen/homescreen/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:final_event/size_config.dart';
import 'package:final_event/styling.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  await Firebase.initializeApp();
  await SharedPreferencesHelper.init();
  runApp(
    const MyApp(),
  );
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 0));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              title: 'Eventio',
              routes: {
                '/home': (BuildContext context) => const HomeScreen(),
                '/login': (BuildContext context) => const SignIn(),
              },
              home: FutureBuilder(
                future: UserManagement().currentUser(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const MainLoading();
                  } else {
                    if (snapshot.hasData) {
                      return const HomeScreen();
                    }
                    return const SignIn();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
