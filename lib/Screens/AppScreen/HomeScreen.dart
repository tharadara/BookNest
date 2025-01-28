import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:shimmer/shimmer.dart';

import '../../Widgets/AppBar.dart';
import '../../Widgets/SearchBar.dart';
import '../../Widgets/Shimmer.dart';
import '../BookMarkScreen.dart';
import 'HotelDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  var name;
  HomeScreen({super.key, this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //GET USER NAME
  var Username = ''; //Username for firebase data
  var Useremail = ''; //Useremail for firebase data

  String UniqueId = '';

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    getHotelDetail();
    getListHotelDetail();
    super.setState(fn);
  }

  @override
  void initState() {
    getHotelDetail();
    getListHotelDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBarForMain(
            'BookNest',
            'assets/images/BN.png',
            //NAVIGATE TO BOOKMARK SCREEN
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    print(Username);
                    return bookmarkScreen(
                      uid: UniqueId,
                      Uemail: Useremail,
                      Uname: Username,
                    );
                  },
                ));
              },
              icon: Icon(
                Icons.bookmark_outline,
                size: 33,
              ),
            )),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            BuildSearchBarForMain(context),
            SizedBox(
              height: 20,
            ),
            getHotelDetail(),
            Padding(
              padding: const EdgeInsets.only(top: 17, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recently Booked',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),

            // LISTTILE HOTEL DETAIL
            getListHotelDetail(),

            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

//GET SINGLE IMAGE HOTEL DETAIL
  getHotelDetail() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('HotelDetail').snapshots(),
      builder: (context, snapshot) {
        print(snapshot.hasData);
        return snapshot.hasData
            ? Container(
                alignment: Alignment.center,
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                  itemBuilder: (context, index) {
                    final ds = snapshot.data!.docs[index].data();
                    final name = ds['Name'];
                    final price = ds['Price'];
                    final address = ds['Address'];
                    final image = ds['Image'];
                    final time = ds['Time'];
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('No Data Found...!'),
                      );
                    }
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            print('Click');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HotelDetail(
                                  Uemail: Useremail,
                                  Uname: Username,
                                  hotelData: Hotel(
                                    name: name,
                                    address: address,
                                    image: image,
                                    price: price,
                                    time: time,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? MainShimmer(context)
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: image ?? '',
                                        errorWidget: (context, url, error) {
                                          return Image.network(
                                            image ?? '',
                                            fit: BoxFit.cover,
                                            height: 280,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        Positioned(
                          top: 210,
                          left: 10,
                          right: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        address ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\$${price ?? 'N/A'}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      time ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            : MainShimmer(context);
      },
    );
  }

  //GET LIST OF HOTEL DETAIL
  Widget getListHotelDetail() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ListHotelDetail')
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            return Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    print('Data : ');
                    final Listds = snapshot.data!.docs[index];

                    return snapshot.hasData
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HotelDetail(
                                    hotelData: Hotel(
                                      name: Listds['Name'],
                                      address: Listds['Address'],
                                      image: Listds['Image'],
                                      price: Listds['Price'],
                                      time: Listds['Time'],
                                    ),
                                    Uemail: Useremail,
                                    Uname: Username,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: Listds['Image'] ?? '',
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                          errorWidget: (context, url, error) =>
                                              Image.network(
                                            Listds['Image'] ?? '',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Listds['Name'] ?? '',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            Listds['Address'] ?? '',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 26),
                                              SizedBox(width: 3),
                                              Text(
                                                '4.5',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                '(1.2k)',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '\$${Listds['Price'] ?? ''}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '/${Listds['Time'] ?? ''}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              UniqueId =
                                                  '(${Username})${Listds['Name']}';
                                              setState(() {});
                                              FirebaseFirestore.instance
                                                  .collection('BookMarkHotel')
                                                  .doc(Useremail)
                                                  .collection(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                                  .doc(UniqueId)
                                                  .set({
                                                'Name': Listds['Name'],
                                                'Image': Listds['Image'],
                                                'Price': Listds['Price'],
                                                'Address': Listds['Address'],
                                                'Time': Listds['Time'],
                                                'CustomerName': Username,
                                                'CustomerEmail': Useremail,
                                                'UID': UniqueId,
                                                'isBookMark': true,
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  duration: Duration(
                                                      milliseconds: 600),
                                                  backgroundColor: Colors.white,
                                                  content: Text(
                                                    'Added to Wishlist',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.bookmark_add,
                                                color: Colors.green),
                                            iconSize: 32,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : ListShimmer(context);
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class Hotel {
  final String name;
  final String address;
  final String image;
  final String price;
  final String time;

  Hotel({
    required this.time,
    required this.name,
    required this.address,
    required this.image,
    required this.price,
  });
}
