import 'package:aqar_bazar/screens/about_us.dart';
import 'package:aqar_bazar/screens/contact_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class AboutAqarCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.safeBlockHorizontal * 90,
      height: SizeConfig.safeBlockVertical * 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [kButtonShadow]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: SizeConfig.safeBlockVertical * 9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xff4e89c7),
                  Color(0xff21d8a2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 1.0],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/icons/Logo short white.png')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Applocalizations.of(context).translate("About Aqar"),
                  maxLines: 2,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AboutUs();
            })),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.safeBlockHorizontal * 1.5,
                      SizeConfig.safeBlockVertical * 3,
                      SizeConfig.safeBlockHorizontal * 2.5,
                      0),
                  child: SvgPicture.asset('assets/icons/information.svg'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical * 3,
                  ),
                  child:
                      Text(Applocalizations.of(context).translate('About Us')),
                ),
              ],
            ),
          ),
          Divider(
            indent: SizeConfig.safeBlockHorizontal * 5,
            endIndent: SizeConfig.safeBlockHorizontal * 5,
            color: Theme.of(context).accentColor,
            thickness: 0.8,
          ),
          GestureDetector(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ContactUs();
            })),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.safeBlockHorizontal * 1.5,
                      SizeConfig.safeBlockVertical,
                      SizeConfig.safeBlockHorizontal * 2.5,
                      0),
                  child: SvgPicture.asset('assets/icons/contact-us.svg'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical,
                  ),
                  child: Text(
                      Applocalizations.of(context).translate('Contact Us')),
                ),
              ],
            ),
          ),
          Divider(
            indent: SizeConfig.safeBlockHorizontal * 5,
            endIndent: SizeConfig.safeBlockHorizontal * 5,
            color: Theme.of(context).accentColor,
            thickness: 0.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    SizeConfig.safeBlockHorizontal * 1.5,
                    SizeConfig.safeBlockVertical,
                    SizeConfig.safeBlockHorizontal * 2.5,
                    0),
                child:
                    SvgPicture.asset('assets/icons/terms-and-conditions.svg'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical,
                ),
                child: Text(Applocalizations.of(context)
                    .translate('Terms and Conditions')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
