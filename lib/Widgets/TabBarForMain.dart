import 'package:flutter/material.dart';

Widget TabBarForMain(String text) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    alignment: Alignment.center,
    height: 45,
    decoration: BoxDecoration( 
      border: Border.all(color: Colors.black,width: 2),
        color: Colors.white, borderRadius: BorderRadius.circular(30)),
    child: Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
    ),
  );
}
