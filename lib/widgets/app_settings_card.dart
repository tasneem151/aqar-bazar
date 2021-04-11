import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class AppSettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.safeBlockHorizontal * 45,
      height: SizeConfig.safeBlockVertical * 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [kButtonShadow],
      ),
      child: Column(
        children: [
          Container(
            height: SizeConfig.safeBlockVertical * 9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Theme.of(context).accentColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal,
                      right: SizeConfig.safeBlockHorizontal),
                  child: SvgPicture.asset('assets/icons/setting.svg'),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 30,
                  child: Text(
                    Applocalizations.of(context).translate("App Settings"),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.safeBlockHorizontal * 2.5,
                        SizeConfig.safeBlockHorizontal * 4,
                        SizeConfig.safeBlockHorizontal * 1.5,
                        0),
                    child: SvgPicture.asset('assets/icons/translate.svg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockHorizontal * 4),
                    child: Text(
                        Applocalizations.of(context).translate('Language')),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 4),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 10,
                  child: Text(
                    'EN',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            indent: SizeConfig.safeBlockHorizontal * 5,
            endIndent: SizeConfig.safeBlockHorizontal * 5,
            color: Theme.of(context).accentColor,
            thickness: 0.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.safeBlockHorizontal * 2.5,
                        SizeConfig.safeBlockHorizontal * 1.5,
                        SizeConfig.safeBlockHorizontal * 1.5,
                        0),
                    child: SvgPicture.asset('assets/icons/money.svg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockHorizontal * 1.5),
                    child: Text(
                        Applocalizations.of(context).translate('Currency')),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 4),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 10,
                  child: Text(
                    'LE',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          /*  Divider(
            indent: 20,
            endIndent: 20,
            color: Theme.of(context).accentColor,
            thickness: 0.8,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/bell.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Notification'),
                  ],
                ),
                Container(
                  width: 50,
                  child: Text(
                    'On',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ), */
        ],
      ),
    );
  }
}
