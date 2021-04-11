import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/Provider/date_provider.dart';
import 'package:aqar_bazar/size_config.dart';
import '../constants.dart';

class PaymentCard extends StatefulWidget {
  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  String ccNumber, cvc, month, year;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ccNumber = Provider.of<DateProvider>(context).getCCNumber();
    cvc = Provider.of<DateProvider>(context).getCVCNumber();
    month = Provider.of<DateProvider>(context).getMonth();
    year = Provider.of<DateProvider>(context).getYear();

    return Container(
      width: SizeConfig.safeBlockHorizontal * 90,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(SizeConfig.safeBlockHorizontal * 5),
          boxShadow: [kBoxShadow],
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 5,
                vertical: SizeConfig.safeBlockHorizontal * 5),
            child: Text(
              'Card Number',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 5),
            child: TxtField(
              initial: ccNumber == null ? "" : ccNumber,
              hint: 'Enter Your Credit Card Number',
              height: SizeConfig.safeBlockVertical * 6.3,
              onChanged: (value) {
                Provider.of<DateProvider>(context, listen: false)
                    .setCCNumber(value);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 5,
                vertical: SizeConfig.safeBlockHorizontal * 5),
            child: Text(
              'CVC',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 5,
            ),
            child: TxtField(
              initial: cvc == null ? "" : cvc,
              obsecure: true,
              hint: '* * 3',
              height: SizeConfig.safeBlockVertical * 6.3,
              onChanged: (value) {
                Provider.of<DateProvider>(context, listen: false)
                    .setCVCNumber(value);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 5,
                vertical: SizeConfig.safeBlockHorizontal * 5),
            child: Text(
              'Valid Until',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.safeBlockHorizontal * 5,
                  right: SizeConfig.safeBlockHorizontal * 5,
                  bottom: SizeConfig.safeBlockHorizontal * 5,
                ),
                child: TxtField(
                  initial: month == null ? "" : month,
                  hint: 'month e.g.: 01',
                  width: SizeConfig.safeBlockHorizontal * 35,
                  onChanged: (value) {
                    Provider.of<DateProvider>(context, listen: false)
                        .setMonth(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.safeBlockHorizontal * 5,
                  right: SizeConfig.safeBlockHorizontal * 5,
                  bottom: SizeConfig.safeBlockHorizontal * 5,
                ),
                child: TxtField(
                  initial: year == null ? "" : year,
                  hint: 'year e.g.: 2021',
                  width: SizeConfig.safeBlockHorizontal * 35,
                  onChanged: (value) {
                    Provider.of<DateProvider>(context, listen: false)
                        .setYear(value);
                  },
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 5),
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
