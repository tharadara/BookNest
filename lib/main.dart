
import 'package:booknest/SplashScreen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/UsersScreen/LoginScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:  FirebaseOptions(messagingSenderId: '',
      apiKey: 'AIzaSyB2X_BWdtlham2Z_WOhWHG7U24nH2YQdFY',
      appId: '1:650618218671:android:0fceccc34583f225ffcc5a',
      projectId: 'booknest-e562f',
      storageBucket: 'booknest-e562f.appspot.com'));
  runApp(DevicePreview(
    builder: (context) {
      return MyApp();
    }
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}
