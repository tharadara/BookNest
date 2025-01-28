import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget HotelDetailSingleImage(image) {
  return Container(
    height: 120,
    width: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(image: image,fit: BoxFit.cover)
    ),
  );
}
