
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/AppBar.dart';
import 'AppScreen/HomeScreen.dart';
import 'AppScreen/HotelDetailScreen.dart';

class bookmarkScreen extends StatefulWidget {
  String Uname;
  String Uemail;
  String uid;
  bookmarkScreen({required this.Uemail, required this.Uname,required this.uid});

  @override
  State<bookmarkScreen> createState() => _bookmarkScreenState();
}

class _bookmarkScreenState extends State<bookmarkScreen> {
  int? bookedCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    getBookmarkHotel();
    bookedCount;
    setState(){}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar('assets/images/BN.png', 'BookNest'),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: Row(
              children: [
                Text(
                  'My Wishlist\'s',
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.green,
                      fontWeight: FontWeight.w500),
                ),
                Text('(${bookedCount})'),
                
              ],
            )),

        SizedBox(
          height: 20,
        ),

        //BOOKING DETAILS
        getBookmarkHotel()
      ]),
    );
  }

  //GET BOOKMARK HOTELS DATA FROM FIREBASE
  Widget getBookmarkHotel() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('BookMarkHotel')
          .doc(widget.Uemail)
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        bookedCount = snapshot.data?.docs.length;
        setState(){}
        final bookingDoc = snapshot.data?.docs;
        return  Expanded(
            child:snapshot.hasData ? ListView.builder(
              physics: NeverScrollableScrollPhysics() ,
          itemCount: bookingDoc?.length,
          itemBuilder: (context, index) {
            final bookingData = bookingDoc?[index].data();
            final bookingID = bookingData?['UID'];

            // print(hotelCount);

            return
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HotelDetail(
                                  hotelData: Hotel(
                                      address: bookingData?['Address'],
                                      image: bookingData?['Image'],
                                      name: bookingData?['Name'],
                                      price: bookingData?['Price'],
                                      time: bookingData?['Time']),
                                  Uemail: widget.Uemail,
                                  Uname: widget.Uname)));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Card(
                          //IMAE PART OF LIST HOTEL CARD
                          child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            snapshot.connectionState == ConnectionState.active
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: bookingData?['Image'],
                                      errorWidget: (context, url, error) {
                                        return Image.network(
                                          bookingData?['Image'],
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ))
                                : Container(
                                    height: 150,
                                    width: 130,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    )),
                            SizedBox(
                              width: 10,
                            ),

                            //NAME AND ADDRESS OF LIST CARD HOTEL
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bookingData?['Name'],
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    bookingData?['Address'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 26,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        '(1.2k)',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            SizedBox(
                              width: 30,
                            ),

                            //PRICE AND TIME PART OF HOTEL CARD
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '\$' + bookingData?['Price'],
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '/' + bookingData?['Time'],
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //BOOKMARK ICON
                                IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('BookMarkHotel')
                                        .doc(widget.Uemail).collection(FirebaseAuth.instance.currentUser!.uid).doc(bookingData?['UID'])
                                        .delete();
                                    bookedCount = snapshot.data?.docs.length;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration:
                                                Duration(milliseconds: 600),
                                            backgroundColor: Colors.white,
                                            content: Text(
                                              'Remove From WishList',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  color: Colors.red),
                                            )));
                                  },
                                  icon: Icon(Icons.bookmark_remove),
                                  iconSize: 38,
                                  color: Colors.green,
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                    ),
                  );

          },
        ) : Center(child: CircularProgressIndicator(),));
      },
    );
  }
}
