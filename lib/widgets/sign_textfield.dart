import 'package:flutter/material.dart';

class SignTextField extends StatelessWidget {
  final Color outShadow;
  final Color inShadow;
  final String hint;

  const SignTextField({
    @required this.outShadow,
    @required this.inShadow,
    @required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 19,
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
      padding: EdgeInsets.only(top: 10, left: 5),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          /* focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
              ), */
        ),
      ),
    );
  }
}
