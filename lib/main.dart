import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mband_app/main_page.dart';
import 'package:mband_app/profile.dart';
import 'package:mband_app/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBand',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('token') ?? 'no token');
  }

  Future<Widget> loadAfterFuture(BuildContext context) async {
    String token = await (getToken() ?? 'no token');
    if (token != 'no token') {
      var response = await Service().testToken(token);
      if (response == "200") {
        List<Profile> profiles = await Service().getProfilesList(token);
        List<Profile> subs = await Service().getSubsList(token);
        Profile profile = await Service().getProfile(token,context);
        return MainPage(
          profile: profile,
          profiles: profiles,
          subs: subs,
        );
      } else {
        return const LoginPage();
      }
    } else {
      return const LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: const Color.fromRGBO(255, 182, 41, 1),
      navigateAfterFuture: loadAfterFuture(context),

      loaderColor: const Color.fromRGBO(244, 244, 244, 1),
      seconds: 20,


    );
  }
}
