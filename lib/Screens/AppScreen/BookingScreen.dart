import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/AppBar.dart';
import '../../Widgets/BookingsButtons.dart';
import '../../Widgets/ListTileRooms.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final CurrrentEmail = FirebaseAuth.instance.currentUser?.email ?? '';
  DocumentSnapshot? ds;

  Widget getBookingData() {
    return Expanded(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('BookedHotel')
          .where('CustomerEmail', isEqualTo: CurrrentEmail)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          final bookingDocs = snapshot.data?.docs;

          return bookingDocs!.isNotEmpty
              ? ListView.builder(
                  itemCount: bookingDocs.length,
                  itemBuilder: (context, index) {
                    final bookingData = bookingDocs?[index].data();
                    final bookingId = bookingData?[
                        'UID']; // Replace with your actual field name

                    return Column(
                      children: [
                        ListTileRoomsForBooking(
                            context,
                            bookingData?['Image'],
                            bookingData?['Name'],
                            bookingData?['Address'],
                            'Paid',
                            bookingData?['BookingTime'],
                            bookingData?['BookingDate']),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: CancelBooking(() {
                                  // DELETE ALERT BOX
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Are you Sure? You want to Cancel your Booking?',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                //YES BUTTON
                                                Card(
                                                    color: Colors.white,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          //DELETE BOOKING FROM FIREBASE
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'BookedHotel')
                                                              .doc(bookingId)
                                                              .delete();

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      content:
                                                                          Text(
                                                                        'Your Booking Cancel Succesfully...!',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Colors.green),
                                                                      )));
                                                        },
                                                        child: Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.red),
                                                        ))),
                                                SizedBox(
                                                  width: 10,
                                                ),

                                                //NO BUTTON
                                                Card(
                                                    color: Colors.white,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                        ))),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                              SizedBox(width: 20),
                              Expanded(child: ViewBookingTicket(() {
                                final bd = bookingData?['TicketNumber'];
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Booking Ticket',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: snapshot.connectionState ==
                                                        ConnectionState
                                                            .active &&
                                                    snapshot.hasData
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          bookingData?['Image'],
                                                      fit: BoxFit.cover,
                                                      height: 90,
                                                      width: 90,
                                                      errorWidget: (context,
                                                          url, error) {
                                                        return Container(
                                                          height: 90,
                                                          width: 90,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      bookingData![
                                                                          'Image']),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        );
                                                      },
                                                    ))
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                    // Text('data')
                                                  ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            'Hotel : ' + bookingData?['Name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Location : ' +
                                                bookingData?['Address'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Ticket : ' +
                                                bookingData?['TicketNumber'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Time : ' +
                                                bookingData?['BookingTime'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Date : ' +
                                                bookingData?['BookingDate'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              })),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No Booking Found...!',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontSize: 22),
                  ),
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }

  @override
  void initState() {
    CurrrentEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar('assets/images/BN.png', 'BookNest'),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 15),
          child: Text(
            'My Boooking\'s',
            style: TextStyle(
                fontSize: 26, color: Colors.green, fontWeight: FontWeight.w500),
          ),
        ),

        SizedBox(
          height: 20,
        ),

        //BOOKING DETAILS
        getBookingData()
      ]),
    );
  }

  // GET BOKING DATA FROM
}
