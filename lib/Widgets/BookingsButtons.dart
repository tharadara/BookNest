import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CancelBooking(onpress) {
  return MaterialButton(
    height: 50,
    minWidth: 190,
    padding: EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
    onPressed: onpress,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), side: BorderSide(width: 2)),
    child: Text(
      'Cancel Booking',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 19,
      ),
    ),
  );
}

Widget ViewBookingTicket(onpress) {
  return MaterialButton(
    height: 50,
    minWidth: 190,
    padding: EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
    onPressed: onpress,
    color: Colors.black,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), side: BorderSide(width: 2)),
    child: Text(
      'View Ticket',
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),
    ),
  );
}
