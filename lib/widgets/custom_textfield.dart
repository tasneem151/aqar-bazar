import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey[100],
          ),
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor,
            spreadRadius: -12,
            blurRadius: 12,
          )
        ],
      ),
      child: TextFormField(
        controller: TextEditingController(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.blue,
              )),
        ),
      ),
    );
  }
}
