import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget ProfileLowerContainer(BuildContext context, Icon icon, String text) {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    height: 60,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              color: const Color.fromARGB(255, 245, 244, 244)),
        ],
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: icon),
         Expanded(
          flex: 6,
           child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20,color: Colors.black),
            ),
         ),
      ]
    ),
  );
}
Widget ProfileLowerContainerLogout(BuildContext context, Icon icon, String text) {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    height: 60,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              color: const Color.fromARGB(255, 245, 244, 244)),
        ],
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: icon),
         Expanded(
          flex: 6,
           child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20,color: Colors.red),
            ),
         ),
      ]
    ),
  );
}
