import 'package:flutter/material.dart';

Widget BuildMediaButton(image){
  return Container(
    height: 60,
    width: 90,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          blurRadius: 12.0,
          color: Color.fromARGB(255, 194, 192, 192),
          offset: Offset(0, 5),
        )
      ]
    ),
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        image: DecorationImage(image: image,),
        
      ),
    ),
  );
}