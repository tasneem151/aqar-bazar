import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aqar_bazar/constants.dart';

class AppSettingsCard extends StatelessWidget {
  const AppSettingsCard({
    @required this.width,
    @required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 2 - 20,
      height: height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [kButtonShadow],
      ),
      child: Column(
        children: [
          Container(
            height: height / 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Theme.of(context).accentColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/setting.svg'),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: width / 2 - 100,
                    child: Text(
                      "App Settings",
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/translate.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Language'),
                  ],
                ),
                Container(
                  width: 50,
                  child: Text(
                    'EN',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Divider(
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
                    SvgPicture.asset('assets/icons/money.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Currency'),
                  ],
                ),
                Container(
                  width: 50,
                  child: Text(
                    'LE',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Divider(
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
          ),
        ],
      ),
    );
  }
}
