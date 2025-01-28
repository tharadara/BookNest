import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Widgets/AppBar.dart';
import '../../../Widgets/ProfileLowerContainer.dart';
import '../../UsersScreen/UserWithFirebaseScreen.dart/Logout.dart';
import 'EditProfile.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? pickedImage;
  var Username = '';
  var Useremail = '';

  final currentUser = FirebaseAuth.instance.currentUser!.email;
  getUserDateFromFirebase() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        "assets/images/BN.png",
        'BookNest',
      ),
      body: ListView(
        children: [
          Container(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(currentUser)
                .snapshots(),
            builder: (context, snapshot) {
              final data = snapshot.data?.data();
              return Column(
                children: [
                  SizedBox(height: 10,),
                  Stack(children: [
                    Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Colors.white),
                    ),
                    pickedImage != null
                        ? CircleAvatar(
                            radius: 75,
                            backgroundImage: FileImage(pickedImage!),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: CircleAvatar(
                              radius: 75,
                              backgroundColor:
                                  Color.fromARGB(255, 234, 234, 234),
                              child: CachedNetworkImage(
                                height: 150,
                                width: 150,
                                imageUrl: data?['URL'] ?? '',
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return Icon(Icons.person);
                                },
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 110, left: 100),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit_square,
                          size: 30,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          ShowImagePickerBox();
                        },
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data?['Name'] ?? '',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    data?['Email'] ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      // UploadeUserData();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(
                              Useremail: Useremail,
                            ),
                          ));
                    },
                    child: ProfileLowerContainer(
                        context,
                        Icon(Icons.person_outline,
                            size: 30, color: Colors.black),
                        'Edit Profile'),
                  ),
                  SizedBox(height: 10,),
                  ProfileLowerContainer(
                      context,
                      Icon(Icons.notifications_outlined,
                          size: 30, color: Colors.black),
                      'Notifications'),SizedBox(height: 10,),
                  ProfileLowerContainer(
                      context,
                      Icon(Icons.language_outlined,
                          size: 30, color: Colors.black),
                      'Languages'),SizedBox(height: 10,),
                  ProfileLowerContainer(
                      context,
                      Icon(Icons.help_center_outlined,
                          size: 30, color: Colors.black),
                      'Help Center'),SizedBox(height: 10,),
                  ProfileLowerContainer(
                      context,
                      Icon(Icons.shield_outlined,
                          size: 30, color: Colors.black),
                      'Privacy'),SizedBox(height: 10,),
                  ProfileLowerContainer(
                      context,
                      Icon(Icons.star_outlined, size: 30, color: Colors.black),
                      'Rate BookNest'),SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      Logout(context);
                    },
                    child: ProfileLowerContainerLogout(
                      context,
                      Icon(Icons.logout_rounded, size: 30, color: Colors.red),
                      'Logout',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ShowImagePickerBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Select Image From'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  PickImageFrom(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.camera),
                  title: Text(
                    'Camera',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  PickImageFrom(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.photo),
                  title: Text(
                    'Gallery',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  PickImageFrom(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
        UploadeUserData();
      });
    } catch (ex) {
      print(ex.toString());
    }
  }

  UploadeUserData() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref('UserProfileImage')
        .child(Username)
        .putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection('Users').doc(currentUser).update({
      'URL': url,
    });
  }

  // SaveUserData() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.getString('Image' image);
  // }

  getImageFromFirebas() async {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot image = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser)
        .get();

    var ImagePath = image['URL'];

    Reference ref = FirebaseStorage.instance
        .ref('UserProfileImage')
        .child(currentUser)
        .child(ImagePath);

    var url = await ref.getDownloadURL();

    setState(() {
      url = url;
    });
    print(url.toString());
  }
}