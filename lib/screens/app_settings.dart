import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height / 5,
              width: width,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/setting.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "App Settings",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 30, right: 30, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/translate-large.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 30,
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
                    )),
                  ),
                ],
              ),
            ),
            Divider(
              height: 5,
              color: Colors.grey,
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/money-large.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Currency',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 30,
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
                ],
              ),
            ),
            Divider(
              height: 5,
              color: Colors.grey,
              indent: 30,
              endIndent: 30,
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
