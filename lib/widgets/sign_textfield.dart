import 'package:flutter/material.dart';

class SignTextField extends StatelessWidget {
  final Color outShadow;
  final Color inShadow;
  final String hint;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  const SignTextField({
    @required this.outShadow,
    @required this.inShadow,
    @required this.hint,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      //height: MediaQuery.of(context).size.height / 19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: outShadow.withOpacity(0.2),
          ),
          BoxShadow(
            color: inShadow.withOpacity(0.2),
            spreadRadius: -12,
            blurRadius: 12,
          )
        ],
      ),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 10,
          ),
          errorStyle: TextStyle(
            height: 0.1,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
          border: InputBorder.none,
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
