
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BuildSearchBarForMain(BuildContext context) {
  return InkWell(
    onTap: (){
      // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
    },
    child: Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 235, 235),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.search_outlined,
                size: 30,
                color: Color.fromARGB(255, 98, 98, 98),
              ),
              SizedBox(
                width: 10,
              ),
               Text(
                'Search',
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 84, 84, 84),
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget BuildSearchBarForSearchScreen(BuildContext context,Icon icon,String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, ),
    child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
      color: const Color.fromARGB(255, 235, 235, 235),
      borderRadius: BorderRadius.circular(10)),
          child: TextField(
    decoration: InputDecoration(
      prefixIcon: icon,
        hintText: text,hintStyle: TextStyle(fontSize: 18),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none)),
          ),
        ),
  );
}
