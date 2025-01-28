import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildDropDownGender(
      {required String title,
      required String hint,
      required List<String> items}) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10))),
              items: items
                  .map((e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              value: '',
              onChanged: (value) {},
              iconSize: 30,
              hint: Text(
                hint,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )
          ],
        )
      ],
    );
  }
