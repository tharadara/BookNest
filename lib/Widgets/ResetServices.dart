import 'package:flutter/material.dart';

Widget BuildResetServicesContainer(String title, subtitle, Icon icon) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 10.0,
            color: Color.fromARGB(255, 182, 182, 182).withOpacity(0.5),
          ),
        ]),
    child: ListTile(
      leading: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10.0,
              color: Color.fromARGB(255, 182, 182, 182).withOpacity(0.5),
            ),
          ]),
          height: 80,
          width: 60,
          child: icon),
      title: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    ),
  );
}
