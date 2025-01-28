import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'MainHomeScreen.dart';
import 'Screens/UsersScreen/LoginScreen.dart';

class SplashServices {
  void isLogin(BuildContext context) async {
    final userCheck = await FirebaseAuth.instance.currentUser;

    if (userCheck != null) {
      Timer(Duration(milliseconds: 700), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainHome(),
            ));
      });
    }else{
      Timer(Duration(milliseconds: 700), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      });
    }
  }
}
