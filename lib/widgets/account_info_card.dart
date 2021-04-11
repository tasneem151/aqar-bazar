import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/Provider/modelsProvider.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class AccountInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileInfo userInfo =
        Provider.of<ModelsProvider>(context, listen: true).getUserInfo();
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
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal,
                      right: SizeConfig.safeBlockHorizontal),
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 6,
                    height: SizeConfig.safeBlockHorizontal * 6,
                    child: SvgPicture.asset(
                      'assets/icons/account small.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 30,
                  child: Text(
                    Applocalizations.of(context)
                        .translate("Account Information"),
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
                    child: SvgPicture.asset('assets/icons/name.svg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockHorizontal * 4),
                    child: Text(Applocalizations.of(context).translate('name')),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 4),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 20,
                  child: Text(
                    userInfo == null
                        ? "-"
                        : userInfo.firstName + " " + userInfo.lastName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            indent: SizeConfig.safeBlockHorizontal * 5,
            endIndent: SizeConfig.safeBlockHorizontal * 5,
            color: Theme.of(context).primaryColor,
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
                    child: SvgPicture.asset('assets/icons/email.svg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockHorizontal * 1.5),
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 15,
                      child: Text(
                        Applocalizations.of(context).translate('Email'),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 1.5),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 20,
                  child: Text(
                    userInfo == null ? "-" : userInfo.email,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            indent: SizeConfig.safeBlockHorizontal * 5,
            endIndent: SizeConfig.safeBlockHorizontal * 5,
            color: Theme.of(context).primaryColor,
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
                    child: SvgPicture.asset('assets/icons/phone.svg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockHorizontal * 1.5),
                    child:
                        Text(Applocalizations.of(context).translate('Phone')),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 1.5),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 20,
                  child: Text(
                    userInfo == null ? "-" : userInfo.phone,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            indent: SizeConfig.safeBlockHorizontal * 5,
            endIndent: SizeConfig.safeBlockHorizontal * 5,
            color: Theme.of(context).primaryColor,
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
                    child: SvgPicture.asset('assets/icons/padlock.svg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockHorizontal * 1.5),
                    child: Text(
                        Applocalizations.of(context).translate('Password')),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 1.5),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 10,
                  child: Text(
                    '********',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
