
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../MainHomeScreen.dart';
import '../../Widgets/AppBar.dart';
import '../../Widgets/MediaButton.dart';
import '../../Widgets/ScreenTopPart.dart';
import '../../Widgets/TextFields.dart';
import 'SignupScreen.dart';
import 'UserWithFirebaseScreen.dart/ForgotPasswordScreen.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  
  String Uname = '';

  SaveUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('Email', email.text);
    await pref.setString('Name', Uname);
    await pref.setString('Password', password.text);
    setState(() {
      
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //handle Function
  void handleLogin() {
    setState(() {
      isLoading = true;
    });

    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      //IF ALL SET THEN ITS LOGIN USER
      // API.userLogin(emailController.text.toString(),
      //     passwordController.text.toString(), context);
      UserLogin(email.text.toString(), password.text.toString());
    } else {
      //IF TEXT FIELDS ARE EMTY THEN ITS SHOW ERROR MESSAGE
      setState(() {
        isLoading = false;
      });
      final errorMsg = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 700),
        content: Text(
          'Please enter required fields..!',
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
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: BuildAppBar('assets/images/BN.png', 'BookNest'),
          body: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              BuildUserScreenTop(context, 'Login', 'WellCome Back...!'),
              Container(
                margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
                child: Column(
                  children: [
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            BuildUserTextFields((val) {
                              if (val.toString().isEmpty) {
                                return 'Please Enter Email';
                              }
                            }, email, 'Email', false,
                                const Icon(Icons.email_outlined)),
                            SizedBox(
                              height: 10,
                            ),
                            BuildUserTextFields((val) {
                              if (val.toString().isEmpty) {
                                return 'Please Enter Password';
                              }
                            }, password, 'Password', true,
                                const Icon(Icons.lock_outline)),
                            SizedBox(
                              height: 50,
                            ),
                            BuildBigLoginButton(context, 'Login'),
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ));
                  },
                  child: Text(
                    'Forgot the Password? ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 77, 3)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'or Contnue With',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildMediaButton(
                    AssetImage(
                      'assets/images/google.png',
                    ),
                  ),
                  BuildMediaButton(AssetImage('assets/images/fb.png')),
                  BuildMediaButton(AssetImage('assets/images/twitter.png')),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an Account ? ',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ));
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  //LOGIN BUTTON

  Widget BuildBigLoginButton(BuildContext context, String text) {
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
                if (formKey.currentState!.validate()) {
                  isLoading == true ? null : handleLogin();
                }
                FocusScope.of(context).unfocus();
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

// USER LOGIN WITH FIREBASE

  UserLogin(String email, password) async {
    if (email == "" || password == "") {
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
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          SaveUserData();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainHome()));
        });
      } on FirebaseAuthException catch (ex) {
        setState(() {
          isLoading = false;
        });
        final errorMsg = SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
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


}
