import 'package:flutter/material.dart';

Widget BuildBigButton(BuildContext context,String text) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
       BoxShadow(
        blurRadius: 12.0,
        color: Color.fromARGB(255, 121, 239, 125),
        offset: Offset(0,5),
       ) 
      ]
    ),
    height: 50,
    width: MediaQuery.of(context).size.width,
    child: MaterialButton(
      onPressed: () {},
      child: Text(text,style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.black,
    ),
  );
}
