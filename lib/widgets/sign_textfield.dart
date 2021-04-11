import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';

class SignTextField extends StatelessWidget {
  final double width;
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
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: width == null ? SizeConfig.safeBlockHorizontal * 85 : width,
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
      padding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 2,
          right: SizeConfig.safeBlockHorizontal * 2,
          top: SizeConfig.safeBlockVertical * 1.3,
          bottom: SizeConfig.safeBlockVertical * 1.3),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 2,
            right: SizeConfig.safeBlockHorizontal * 2,
            bottom: SizeConfig.safeBlockVertical * 1.3,
            top: SizeConfig.safeBlockVertical * 1.3,
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
