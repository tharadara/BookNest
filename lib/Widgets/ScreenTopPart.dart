import 'package:flutter/material.dart';

Widget BuildUserScreenTop(BuildContext context,String text1,text2) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(left: 20),
    margin: EdgeInsets.only(top: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
        ),
        Text(
          text2,
          style: TextStyle(
              color: const Color.fromARGB(255, 54, 54, 54), fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    ),
  );
}

Widget BuildMainScreenTop(BuildContext context,String text1,text2) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(left: 20),
    margin: EdgeInsets.only(top: 10),
    child: Row(
      children: [
        Text(
          text1,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          text2,
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ],
    ),
  );
}
