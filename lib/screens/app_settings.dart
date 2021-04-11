import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/widgets/alert_radio.dart';
import 'package:aqar_bazar/localization/app_language.dart';
import 'package:provider/provider.dart';

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  String lang;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //Manager.getLang().then((value) => {lang = value});
    lang = Provider.of<AppLanguage>(context, listen: true).getlang();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: SizeConfig.safeBlockVertical * 21,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 5),
                    child: SvgPicture.asset('assets/icons/setting.svg'),
                  ),
                  Text(
                    Applocalizations.of(context).translate("App Settings"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 6,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    child: AlertRadio(
                      language: lang,
                    ));
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            SizeConfig.safeBlockHorizontal * 8,
                            SizeConfig.safeBlockVertical * 6,
                            SizeConfig.safeBlockHorizontal * 5,
                            SizeConfig.safeBlockVertical * 3),
                        child: SvgPicture.asset(
                            'assets/icons/translate-large.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 6,
                            bottom: SizeConfig.safeBlockVertical * 3),
                        child: Text(
                          Applocalizations.of(context).translate('Language'),
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 5,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.safeBlockHorizontal * 8,
                        SizeConfig.safeBlockVertical * 6,
                        SizeConfig.safeBlockHorizontal * 8,
                        SizeConfig.safeBlockVertical * 3),
                    child: Container(
                      height: SizeConfig.safeBlockHorizontal * 8,
                      width: SizeConfig.safeBlockHorizontal * 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Color(0xfff9f9f9),
                              Color(0xffebf5f2),
                              Color(0xff21d8a2),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.1, 0.3, 0.4, 1.0],
                            tileMode: TileMode.clamp,
                          )),
                      child: Center(
                        child: Text(
                          'EN',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 5,
              color: Colors.grey,
              indent: SizeConfig.safeBlockHorizontal * 8,
              endIndent: SizeConfig.safeBlockHorizontal * 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.safeBlockHorizontal * 8,
                          SizeConfig.safeBlockVertical * 3,
                          SizeConfig.safeBlockHorizontal * 7,
                          SizeConfig.safeBlockVertical * 3),
                      child: SvgPicture.asset('assets/icons/money-large.svg'),
                    ),
                    Text(
                      Applocalizations.of(context).translate('Currency'),
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.safeBlockHorizontal * 8,
                      SizeConfig.safeBlockVertical * 3,
                      SizeConfig.safeBlockHorizontal * 8,
                      SizeConfig.safeBlockVertical * 3),
                  child: Container(
                    height: SizeConfig.safeBlockHorizontal * 8,
                    width: SizeConfig.safeBlockHorizontal * 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Color(0xfff9f9f9),
                            Color(0xffebf5f2),
                            Color(0xff21d8a2),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.1, 0.3, 0.4, 1.0],
                          tileMode: TileMode.clamp,
                        )),
                    child: Center(
                        child: Text(
                      'LE',
                      style: TextStyle(color: Colors.black54),
                    )),
                  ),
                ),
              ],
            ),
            Divider(
              height: 5,
              color: Colors.grey,
              indent: SizeConfig.safeBlockHorizontal * 8,
              endIndent: SizeConfig.safeBlockHorizontal * 8,
            ),
            /*  SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/bell-large.svg'),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Notification',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.grey[100],
                          Colors.grey[200],
                          Colors.grey[300],
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.1, 0.5, 0.7, 1.0],
                        tileMode: TileMode.clamp,
                      )),
                  child: Center(
                      child: Text(
                    'On',
                    style: TextStyle(color: Colors.black54),
                  )),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.grey[100],
                          Colors.grey[200],
                          Colors.grey[300],
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.1, 0.5, 0.7, 1.0],
                        tileMode: TileMode.clamp,
                      )),
                  child: Center(
                      child: Text(
                    'Off',
                    style: TextStyle(color: Colors.black54),
                  )),
                ),
              ],
            ), */
          ],
        ),
      ),
    );
  }
}
