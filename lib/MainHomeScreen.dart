import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Screens/AppScreen/BookingScreen.dart';
import 'Screens/AppScreen/HomeScreen.dart';
import 'Screens/AppScreen/ProfileScreens/ProfileScreen.dart';
import 'Screens/AppScreen/SearchScreen.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  String? Username, Useremail;

  void getUserDateFromFirebase() async {
    final currentUser = FirebaseAuth.instance.currentUser!.email;

    final GetData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser)
        .get();

    var Uname = GetData['Name'];
    var Uemail = GetData['Email'];
    setState(() {
      Username = Uname;
      Useremail = Uemail;
    });
  }

  int CurrentIndex = 0;

  static List<Widget> BottomNav = <Widget>[
    HomeScreen(),
    SearchScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomNav.elementAt(CurrentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            CurrentIndex = index;
          });
        },
        currentIndex: CurrentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30,
              ),
              label: 'Booking'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,
        selectedIconTheme: IconThemeData(color: Colors.green),
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
        showUnselectedLabels: true,
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
