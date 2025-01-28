
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../MainHomeScreen.dart';
import '../../../Widgets/TextFields.dart';

class EditProfile extends StatefulWidget {
  String Useremail;
  EditProfile({super.key, required this.Useremail});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fullname = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  var _genderController;
  DateTime? selectedDate = DateTime.now();

  selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2030));
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  storeUserDataInPref(String fullname, name, email, number, _genderController,
      DateTime selectedDate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('Fullname', fullname);
    pref.setString('Name', name);
    pref.setString('Email', email);
    pref.setString('Number', number);
    pref.setString('Gender', _genderController.toString());
    pref.setString('DateTime', '${selectedDate.toLocal()}');
  }

  uploadUserData(String email, name, fullname, number, _genderController,
      DateTime selectedDate) async {
    if (email.toString().isNotEmpty &&
        name.toString().isNotEmpty &&
        fullname.toString().isNotEmpty &&
        number.toString().isNotEmpty &&
        selectedDate != '' &&
        _genderController != '') {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.Useremail)
          .set({
        "Name": name,
        "FullName": fullname,
        "Email": email,
        "Number": number,
        "Gender": _genderController,
        "Birthdate": selectedDate,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(milliseconds: 600),
            backgroundColor: Colors.white,
            content: Text(
              'Succesfully Edited...!',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.green),
            )));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainHome(),
            ));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(
          duration: Duration(milliseconds: 600),
          backgroundColor: Colors.white,
          content: Text(
            'Please Enter required fields...!',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 20, color: Colors.red),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: ListView(children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: BuildEditProfileTextFields(
            fullname,
            'Fullname',
            false,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: BuildEditProfileTextFields(
            name,
            'Nick name',
            false,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: BuildEditProfileTextFields(
            email,
            'Email',
            false,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: BuildEditProfileTextFields(
            number,
            'Phone Number',
            false,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 252, 251, 251),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                  color: Color.fromARGB(255, 174, 174, 174).withOpacity(0.5),
                ),
              ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}'),
                  IconButton(
                      onPressed: () {
                        selectDate(context);
                      },
                      icon: Icon(Icons.date_range_rounded))
                ]),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                  color: Color.fromARGB(255, 174, 174, 174).withOpacity(0.5),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 252, 251, 251),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                  items: ['Male', 'Female']
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  value: _genderController,
                  onChanged: (value) {
                    _genderController = value;
                  },
                  iconSize: 30,
                  hint: Text(
                    'Gender',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: MaterialButton(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          onPressed: () {
            storeUserDataInPref(fullname.text, name.text, email.text,
                number.text, _genderController, selectedDate!.toLocal());
            uploadUserData(
                email.text.toString(),
                name.text.toString(),
                fullname.text.toString(),
                number.text.toString(),
                _genderController.toString(),
                selectedDate!.toLocal());
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), side: BorderSide.none),
          color: Colors.black,
          child: Text(
            'Update',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
