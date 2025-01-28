
import 'package:flutter/material.dart';

Widget ListTileRoomsForMain(BuildContext context,  image, String name, address,
    Icon icon1, reviewPoint, reviewCount, price, time, Icon icon2) {
  String? HotelImage;
  String? HotelName;
  String? HotelAddress;
  String? HotelPrice;
  String? HotelTime;

  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    padding: EdgeInsets.only(left: 10, right: 10),
    height: 150,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 0),
            color: const Color.fromARGB(255, 241, 241, 241),
            blurRadius: 10)
      ],
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                height: 110,
                width: 110,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      image ?? '',
                      fit: BoxFit.cover,
                    ))),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HotelName = name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  HotelAddress = address,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    icon1,
                    Text(
                      reviewPoint,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.black),
                    ),
                    Text(
                      reviewCount,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  HotelPrice = price ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.black),
                ),
                SizedBox(),
                Text(
                  HotelTime = time ?? '',
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                icon2
              ],
            )
          ],
        ),
      ],
    ),
  );
}

Widget ListTileRoomsForBooking(
    BuildContext context, NetworkImage, String name, address, type,bookingTime,bookingDate) {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    padding: EdgeInsets.only(left: 10, right: 10),
    height: 150,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 0),
            color: const Color.fromARGB(255, 241, 241, 241),
            blurRadius: 10)
      ],
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 110,
                width: 110,
                child:
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          NetworkImage,
                          fit: BoxFit.cover,
                        ))
                   ),
            SizedBox(
              width: 10,
            ),
            
            //HOTEL NAME AND ADDRESS
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    address,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 202, 255, 205),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 132, 8),
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 25,),
            
            //BOOKING DATE AND TIMES
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [
                SizedBox(height: 45,),
                Text(bookingTime ?? '',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 20),),
                Text(bookingDate ?? '',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
              ],
            ),
          ],
        ),
       
        
      ],
    ),
  );
}
