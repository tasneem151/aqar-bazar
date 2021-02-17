import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/constants.dart';

class BuyRentSwitch extends StatelessWidget {
  final bool isRentSelected;
  final bool isBuySelected;
  final Function onBuySwitch;
  final Function onRentSwitch;
  final BoxShadow shadow;

  const BuyRentSwitch({
    @required this.isRentSelected,
    @required this.isBuySelected,
    @required this.onBuySwitch,
    @required this.onRentSwitch,
    this.shadow = kBoxShadow,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      width: width / 2,
      height: height / 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Color(0xffD8D8D8),
        boxShadow: [shadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onBuySwitch,
            child: Container(
              width: width / 4.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isBuySelected ? Colors.blue : Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    isBuySelected
                        ? SvgPicture.asset('assets/icons/buy.svg')
                        : Container(),
                    Text(
                      'Buy',
                      style: TextStyle(
                          fontSize: isBuySelected ? 25 : 20,
                          color: isBuySelected ? Colors.white : Colors.black),
                    ),
                    SizedBox(
                      height: height / 13,
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onRentSwitch,
            child: Container(
              width: width / 4.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isRentSelected ? Colors.blue : Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isRentSelected
                      ? SvgPicture.asset(
                          'assets/icons/house30.svg',
                        )
                      : Container(),
                  Text('Rent',
                      style: TextStyle(
                          fontSize: isRentSelected ? 25 : 20,
                          color: isRentSelected ? Colors.white : Colors.black)),
                  SizedBox(
                    height: height / 13,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
