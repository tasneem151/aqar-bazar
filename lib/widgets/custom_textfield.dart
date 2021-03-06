import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function onChanged;
  final TextEditingController controller;
  final String initValue;
  final bool isPassword;

  const CustomTextField(
      {Key key,
      this.onChanged,
      this.controller,
      this.initValue,
      this.isPassword = false})
      : super(key: key);
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
        initialValue: initValue,
        style: TextStyle(color: Colors.black),
        //onChanged: onChanged,
        onSaved: onChanged,
        controller: controller,
        obscureText: isPassword,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
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
