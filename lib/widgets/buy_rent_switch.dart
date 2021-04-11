import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

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
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2.5),
      width: SizeConfig.safeBlockHorizontal * 50,
      height: SizeConfig.safeBlockVertical * 9,
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
              width: SizeConfig.safeBlockHorizontal * 22,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isBuySelected ? Colors.blue : Colors.transparent),
              child: Padding(
                padding: EdgeInsets.only(left: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    isBuySelected
                        ? Container(
                            height: SizeConfig.safeBlockHorizontal * 6.5,
                            width: SizeConfig.safeBlockHorizontal * 6.5,
                            child: SvgPicture.asset('assets/icons/buy.svg'))
                        : Container(),
                    Text(
                      Applocalizations.of(context).translate('Buy'),
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                          fontWeight: isBuySelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: isBuySelected ? Colors.white : Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 7,
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onRentSwitch,
            child: Container(
              width: SizeConfig.safeBlockHorizontal * 22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isRentSelected ? Colors.blue : Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isRentSelected
                      ? Container(
                          height: SizeConfig.safeBlockHorizontal * 6.5,
                          width: SizeConfig.safeBlockHorizontal * 6.5,
                          child: SvgPicture.asset(
                            'assets/icons/house30.svg',
                          ),
                        )
                      : Container(),
                  Text(
                    Applocalizations.of(context).translate('Rent'),
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                        fontWeight: isRentSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isRentSelected ? Colors.white : Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 7,
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
