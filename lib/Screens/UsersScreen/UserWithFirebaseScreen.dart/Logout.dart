import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../LoginScreen.dart';

Logout(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color.fromARGB(255, 209, 43, 31),
                ),
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut().then((value){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      });

                    } catch (e) {
                      print("Error during sign-out: $e");
                      // Handle the error (e.g., show a snackbar or display an error message)
                    }
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black),
                  )),
            ],
          )
        ],
      ));
    },
  );
}
