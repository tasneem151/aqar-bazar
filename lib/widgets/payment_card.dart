import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/Provider/date_provider.dart';

import '../constants.dart';

class PaymentCard extends StatefulWidget {
  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  String ccNumber, cvc, month, year;
  @override
  Widget build(BuildContext context) {
    ccNumber = Provider.of<DateProvider>(context).getCCNumber();
    cvc = Provider.of<DateProvider>(context).getCVCNumber();
    month = Provider.of<DateProvider>(context).getMonth();
    year = Provider.of<DateProvider>(context).getYear();
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
          Text(
            'Card Number',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          TxtField(
            initial: ccNumber == null ? "" : ccNumber,
            hint: 'Enter Your Credit Card Number',
            width: width / 1.2,
            height: height / 16,
            onChanged: (value) {
              Provider.of<DateProvider>(context, listen: false)
                  .setCCNumber(value);
            },
          ),
          SizedBox(height: 40),
          Text(
            'CVC',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          TxtField(
            initial: cvc == null ? "" : cvc,
            obsecure: true,
            hint: '* * 3',
            width: width / 1.2,
            height: height / 16,
            onChanged: (value) {
              Provider.of<DateProvider>(context, listen: false)
                  .setCVCNumber(value);
            },
          ),
          SizedBox(height: 40),
          Text(
            'Valid Until',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TxtField(
                initial: month == null ? "" : month,
                hint: 'month e.g.: 01',
                width: width / 3,
                height: height / 16,
                onChanged: (value) {
                  Provider.of<DateProvider>(context, listen: false)
                      .setMonth(value);
                },
              ),
              SizedBox(
                width: 50,
              ),
              TxtField(
                initial: year == null ? "" : year,
                hint: 'year e.g.: 2021',
                width: width / 3,
                height: height / 16,
                onChanged: (value) {
                  Provider.of<DateProvider>(context, listen: false)
                      .setYear(value);
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}

class TxtField extends StatelessWidget {
  final String hint;
  final double width;
  final double height;
  final void Function(String) onChanged;
  final bool obsecure;
  final String initial;

  const TxtField({
    this.hint,
    this.height,
    this.width,
    this.onChanged,
    this.obsecure = false,
    this.initial,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[300], offset: Offset(0, 0), blurRadius: 10.0),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.only(top: 3),
      child: TextFormField(
        initialValue: initial,
        obscureText: obsecure,
        obscuringCharacter: "*",
        onChanged: onChanged,
        style: TextStyle(color: Theme.of(context).primaryColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.blueGrey[500],
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
