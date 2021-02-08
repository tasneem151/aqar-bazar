import 'package:flutter/material.dart';

import '../constants.dart';

class PaymentCard extends StatefulWidget {
  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 2.3,
      width: width / 1.1,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [kBoxShadow],
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Card Number', style: TextStyle(color: Theme.of(context).primaryColor),),
          SizedBox(height: 10,),
          TxtField(hint: 'Enter Your Credit Card Number', width: width / 1.2, height: height / 19,),
          SizedBox(height: 40),
          Text('Card Holder', style: TextStyle(color: Theme.of(context).primaryColor),),
          SizedBox(height: 10,),
          TxtField(hint: 'Your Legal First And Last Name', width: width / 1.2, height: height / 19,),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('CVV', style: TextStyle(color: Theme.of(context).primaryColor),),
              SizedBox(height: 10,),
              TxtField(hint: '* * a', width: width / 3, height: height / 19,),
            ],),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Valid Until', style: TextStyle(color: Theme.of(context).primaryColor),),
                SizedBox(height: 10,),
                TxtField(hint: 'Month / Year', width: width / 3, height: height / 19,),
              ],),
          ],),

        ],
      ),
    );
  }
}

class TxtField extends StatelessWidget {
  final String hint;
  final double width;
  final double height;

  const TxtField({Key key, this.hint, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey[300], offset: Offset(0,0), blurRadius: 10.0),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.only(top: 10, left: 5),
      child: TextFormField(
        style: TextStyle(color: Theme.of(context).primaryColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Color(0xff4e89c7),
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
