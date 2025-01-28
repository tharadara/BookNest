
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Widgets/AppBar.dart';
import 'HomeScreen.dart';

class reviewScreen extends StatefulWidget {
  String Uname, Uemail;
  final Hotel hotelData;
  // String Uimage;
  reviewScreen({super.key, required this.Uname, required this.Uemail,required this.hotelData});

  @override
  State<reviewScreen> createState() => _reviewScreenState();
}

class _reviewScreenState extends State<reviewScreen> {
  TextEditingController reviewController = TextEditingController();
  TextEditingController starController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar('assets/images/BN.png', 'BookNest'),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.purple,
                    child: Text(
                      widget.Uname[0],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.Uname,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        maxLines: 1,
                        softWrap: true,
                        'Reviews are public and include your ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        'account and device info.',
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),

              //REVIEW TEXT FIELDS
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  controller: reviewController,
                  decoration: InputDecoration(
                    hintText: 'Describe your experience...!',
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                ),
              ),
              // SizedBox(height: 20,),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: TextField(
              //     controller: starController,
              //     keyboardType: TextInputType.phone,
              //     decoration: InputDecoration(
                  
              //       hintText: 'Give Star ',
              //         border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     )),
              //   ),
              // ),
              SizedBox(height: 20,),

              //SUBMIT BUTTON
              MaterialButton(
                padding: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.purple,
                onPressed: () {},
                child: Text('Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }

  storeUserReview(){
    
    DateTime dateTime = DateTime.now();
    String FormatedDate = DateFormat('dd-MM-yy').format(dateTime);
    String FormatedTime = DateFormat('hh:mma').format(dateTime);

    FirebaseFirestore.instance.collection('UserReview').doc().set({
      'Name': widget.Uname,
      'Review': reviewController,
      'Date': FormatedDate,
      'Time': FormatedTime,
      'StarReview': starController,
      'HotelName': widget.hotelData.name,
    });
  }
}
