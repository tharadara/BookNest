import 'package:flutter/material.dart';

Widget BuildUserTextFields(validator,
    controller, String hintText, obscureText, Icon icon) {
  return TextFormField(
    validator: validator,
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(

      prefixIcon: icon,
      // alignLabelWithHint: true,,
      hintText: hintText,
    ),
  );
}

Widget BuildEditProfileTextFields(controller, String hintText, obscureText) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 5),
          blurRadius: 10.0,
          color: Color.fromARGB(255, 174, 174, 174).withOpacity(0.5),
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        fillColor: Color.fromARGB(255, 252, 251, 251),
        filled: true,
        hintText: hintText,
      ),
    ),
  );
}
