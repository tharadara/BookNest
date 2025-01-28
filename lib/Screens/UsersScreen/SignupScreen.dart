
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/AppBar.dart';
import '../../Widgets/ScreenTopPart.dart';
import '../../Widgets/TextFields.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void handleSignup() {
    setState(() {
      isLoading = true;
    });
    if (email.text.isNotEmpty &&
        name.text.toString().isNotEmpty &&
        password.text.toString().isNotEmpty) {
      UserRegistration(email.text.toString(), password.text.toString());
    } else {
      setState(() {
        isLoading = false;
      });
      final errorMsg = SnackBar(
        duration: Duration(milliseconds: 700),
        content: Text(
          'Please Enter required fields..!',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.red),
        ),
        backgroundColor: Colors.white,
      );
      ScaffoldMessenger.of(context).showSnackBar(errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: BuildAppBar('assets/images/BN.png', 'BookNest'),
      body: ListView(
        children: [
          BuildUserScreenTop(context, 'SignUp', 'Create Your Account...!'),
          Container(
            margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Form(
              key: formKey,
              child: Column(
              children: [
                BuildUserTextFields(
                (val){
                  if(val.toString().isEmpty){
                    return 'Please Enter Name';
                  }
                },name, 'Name', false, Icon(Icons.person_outline)),
            SizedBox(
              height: 30,
            ),
            BuildUserTextFields((val){
                  if(val.toString().isEmpty){
                    return 'Please Enter Email';
                  }
                },
                email, 'Email', false, const Icon(Icons.email_outlined)),
            SizedBox(
              height: 30,
            ),
            BuildUserTextFields((val){
                  if(val.toString().isEmpty){
                    return 'Please Enter Password';
                  }
                }, password, 'Password', true,
                const Icon(Icons.lock_outline)),
            SizedBox(
              height: 50,
            ),
            BuildBigSignupButton(context, 'Sign up'),
              ],
            )),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'By signing up you agree to BookNest\'s ',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text('Terms',
                  style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(255, 0, 77, 3),
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Center(
              child: Text('of Services and Privacy Policy',
                  style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(255, 0, 77, 3),
                      fontWeight: FontWeight.bold))),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an Account ? ',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  //SIGNUP BUTTON

  Widget BuildBigSignupButton(BuildContext context, String text) {
    return isLoading == true
        ? Container(
            height: 50,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 12.0,
                color: Color.fromARGB(255, 121, 239, 125),
                offset: Offset(0, 5),
              )
            ]),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              onPressed: () {
                if(formKey.currentState!.validate()){

                isLoading ? null : handleSignup();
                }
              },
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.black,
            ),
          );
  }

  // USER REGISTRTION WITH FIREBASE

  UserRegistration(String email, password) async {
    if (email == "" || password == "" || name == "") {
      final errorMsg = SnackBar(
        content: Text(
          'Please Enter Required Fields..!',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      return ScaffoldMessenger.of(context).showSnackBar(errorMsg);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          SaveUserData();
          StoreUserDataInDatabase(name.text.toString(), email.toString());
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => MainHome()));
        });
      } on FirebaseAuthException catch (ex) {
        setState(() {
          isLoading = false;
        });
        final errorMsg = SnackBar(
          duration: Duration(milliseconds: 700),
          content: Text(
            ex.code.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 18, color: Colors.red),
          ),
          backgroundColor: Colors.white,
        );
        return ScaffoldMessenger.of(context).showSnackBar(errorMsg);
      }
    }
  }

  SaveUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('Name', name.text);
    await pref.setString('Email', email.text);
    await pref.setString('Password', password.text);
  }

  StoreUserDataInDatabase(String name, email) async {
    FirebaseFirestore.instance.collection('Users').doc(email).set({
      "Name": name,
      "Email": email,
    });
  }
}
