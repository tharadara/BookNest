import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget SingleImageRoom(AssetImage image, String name, address, price, time, ) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Container(
      // height: 440,
      // width: 340,
      child: Column(
        children: [
          Container(
            height: 320,
            width: 370,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: image, fit: BoxFit.cover)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  Text(
                    address,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Column(
          //     children: [
          //       Text('data'),
          //       Text('data'),
          //       Text('data'),
          //     ],
          //   ),
          // )
        ],
      ),
    ),
  ]);
}
