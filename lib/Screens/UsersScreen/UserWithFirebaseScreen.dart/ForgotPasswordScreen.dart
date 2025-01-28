
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../Widgets/AppBar.dart';
import '../../../Widgets/ResetServices.dart';
import '../../../Widgets/ScreenTopPart.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar('assets/images/BN.png','BookNest'),
      body: ListView(
        children: [
          BuildUserScreenTop(context, 'Forgot Password', ''),
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Text(
                'Select Which contact detail should we use to',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 18),
              ),
              Text('reset your Password',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 18))
            ],
          ),
          SizedBox(height: 50,),
          Column(
            children: [
              BuildResetServicesContainer('Via SMS: ', 'Enter Mobile Number', Icon(Icons.sms,size: 40,)),
              BuildResetServicesContainer('Via Email: ', 'Enter Email Id', Icon(Icons.email,size: 40,))
            ],
          )
        ],
      ),
    );
  }
}
