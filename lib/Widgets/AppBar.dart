import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Widget BuildAppBar(title, image) {
//   return Container(
//     margin: EdgeInsets.only(top: 20, left: 20),
//     child: Row(
//       children: [
//         ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.asset(
//               image,
//               width: 40,
//               fit: BoxFit.cover,
//             )),
//         SizedBox(
//           width: 10,
//         ),
//         Text(
//           title,
//           style: TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ],
//     ),
//   );
// }

AppBar BuildAppBar(image, String title) {
  return AppBar(
    title: Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            )),
       SizedBox(width: 10,),
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

AppBar BuildAppBarForMain(String title, image, icon2) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    width: 40,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),

          icon2,
        ],
      ),
    );
}
