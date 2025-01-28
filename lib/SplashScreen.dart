import 'dart:async';
import 'package:flutter/material.dart';

import 'SplashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  SplashServices splashScreen = SplashServices();

@override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/BN.png'),
            Text('WellCome To BookNest',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),)
          ],
        ),
      ),
    );
  }
}