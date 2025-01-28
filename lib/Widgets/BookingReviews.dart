import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BookingReviews(image,name,date,desc) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              color: const Color.fromARGB(255, 240, 240, 240),
              blurRadius: 10)
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 35,
            ),
            title: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(date,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            trailing: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '4',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Text(
                desc,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.black),),
          )
        ],
      ),
    ),
  );
}
