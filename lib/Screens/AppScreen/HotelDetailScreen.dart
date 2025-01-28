import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../RandomNumber/random.dart';
import '../../Widgets/AppBar.dart';
import '../../Widgets/BookingReviews.dart';
import '../../Widgets/HotelDetailSingleImage.dart';
import 'HomeScreen.dart';
import 'ReviewScreen.dart';

class HotelDetail extends StatefulWidget {
  // String image;
  // String name;
  // String address;
  // String price;
  // String time;
  final Hotel hotelData;
  String Uname;
  String Uemail;

  HotelDetail(
      {super.key,
      required this.hotelData,
      // required this.name,
      // required this.address,
      // required this.image,
      // required this.price,
      // required this.time,
      required this.Uemail,
      required this.Uname});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar('assets/images/BN.png', 'BookNest'),
      body: ListView(
        children: [
          Stack(children: [
            Container(
              height: 250,
              child: CachedNetworkImage(
                height: 250,
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.cover,
                imageUrl: widget.hotelData.image,
                errorWidget: (context, url, error) {
                  return Container(
                    height: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.hotelData.image))),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 220),
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Royal Palace Hotel',
                          widget.hotelData.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.green),
                        ),
                        Text(
                          widget.hotelData.address,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        Divider(),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '\$' + widget.hotelData.price,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          widget.hotelData.time,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),

          //HOTEL IMAGES
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gallery Photos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  'SeeAll',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HotelDetailSingleImage(AssetImage('assets/images/img2.jpg')),
                  SizedBox(
                    width: 20,
                  ),
                  HotelDetailSingleImage(AssetImage('assets/images/img4.jpg')),
                  SizedBox(
                    width: 20,
                  ),
                  HotelDetailSingleImage(AssetImage('assets/images/img5.jpg')),
                  SizedBox(
                    width: 20,
                  ),
                  HotelDetailSingleImage(AssetImage('assets/images/img6.jpg')),
                  SizedBox(
                    width: 20,
                  ),
                  HotelDetailSingleImage(AssetImage('assets/images/img7.jpg')),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          // HOTEL DETAILS....

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                Icon(
                  Icons.home_work_outlined,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Hotel',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.hotel,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Bedrooms',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.hot_tub,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Bathrooms',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.area_chart_rounded,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '3700 sqft',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                )
              ],
            ),
          ]),
          SizedBox(
            height: 20,
          ),

          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Text(
                      'Review\'s',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 244, 225, 51),
                  ),
                  Text(
                    ' 3.5 ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text('(4551 reviews)'),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'SeeAll',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => reviewScreen(
                              Uname: widget.Uname,
                              Uemail: widget.Uemail,
                              hotelData: widget.hotelData,
                            ),
                          ));
                    },
                    child: Text(
                      'Write a review',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              BookingReviews(
                  'assets/images/mh.JPG',
                  'Mohammad Husain',
                  'Dec 10,2024',
                  'Very Nice and Comfortable Hotel,thank you for accompanying my vacation...!'),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: MaterialButton(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          onPressed: () {
            bookedHotel();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Booked Succesfully...!',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                );
              },
            );
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), side: BorderSide.none),
          color: Colors.black,
          child: Text(
            'Book Now',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
    );
  }

  //BOOKED HOTEL FUCTION
  bookedHotel() async {
    final UniqueId = '(' + widget.Uname + ')' + widget.hotelData.name;

    //SET DATE AND TIME FOR BOOKING
    DateTime dateTime = DateTime.now();
    String FormatedDate = DateFormat('dd-MM-yy').format(dateTime);
    String FormatedTime = DateFormat('hh:mma').format(dateTime);

    //GENERATE RANDOME TICKET NUMBER
    var rng = Random();
    String ticketNumber =
        generateTicketNumber(rng, 10); // Adjust the length as needed
    print(ticketNumber);

    // makePayment(widget.hotelData.price).then((val){


    //STRUCTURE USE TO STORE DATA INTO FIREBASE
    FirebaseFirestore.instance.collection('BookedHotel').doc(UniqueId).set({
      'Name': widget.hotelData.name,
      'Image': widget.hotelData.image,
      'Price': widget.hotelData.price,
      'Address': widget.hotelData.address,
      'Time': widget.hotelData.time,
      'CustomerName': widget.Uname,
      'CustomerEmail': widget.Uemail,
      'UID': UniqueId,
      'BookingTime': FormatedTime,
      'BookingDate': FormatedDate,
      'TicketNumber': ticketNumber
    });
    }
  }

  // //GET USER DETAIL FRO SHAREDPREFERENCE
  // getUserDetail() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   Uname = pref.getString('UserName');
  //   Uemail = pref.getString('UserEmail');
  //   setState(() {

  //   });
  // }

//PAYMENT STRIPE FUNCTION
//   Future<void> makePayment(String amount) async {
//     try {
//       paymentIntent = await createPaymentIntent(amount, 'INR');
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntent?['client_secret'],
//           style: ThemeMode.dark,
//           merchantDisplayName: 'Mohd',
//         ),
//       );
//       await displayPaymentSheet();
//     } catch (e, s) {
//       print('Exception: $e\nStack Trace: $s');
//     }
//   }
//
//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) async {
//         // StoreOrderDetail();
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                       ),
//                       SizedBox(width: 10),
//                       Text('Payment Succesfull')
//                     ],
//                   )
//                 ],
//               ),
//             );
//           },
//         );
//         paymentIntent = null;
//       }).onError((error, stackTrace) {
//         print('Error is : ---> $error $stackTrace');
//       });
//     } on StripeException catch (e) {
//       print('Error is : ---> $e');
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                 content: Text('Cancelled'),
//               ));
//     } catch (e) {
//       print('$e');
//     }
//   }
//
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $secretKey',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: body,
//       );
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('Error Charging User: ${err.toString()}');
//     }
//   }
//
//   calculateAmount(String amount) {
//     final calculateAmount = (int.parse(amount) * 100);
//     return calculateAmount.toString();
//   }
//
//   //TO GENERATE RANDOME TICKET NUMBER
//   String generateTicketNumber(Random rng, int length) {
//     const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//     return List.generate(length, (index) => chars[rng.nextInt(chars.length)])
//         .join();
//   }
