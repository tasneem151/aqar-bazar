import 'package:aqar_bazar/screens/about_us.dart';
import 'package:aqar_bazar/screens/contact_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aqar_bazar/constants.dart';

class AboutAqarCard extends StatelessWidget {
  final double width;
  final double height;

  const AboutAqarCard({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 30,
      height: height / 3.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [kButtonShadow]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height / 12,
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/icons/Logo short white.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "About Aqar",
                    maxLines: 2,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 5, right: 5),
            child: GestureDetector(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutUs();
              })),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/information.svg'),
                  SizedBox(
                    width: 5,
                  ),
                  Text('About Us'),
                ],
              ),
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
            child: GestureDetector(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ContactUs();
              })),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/contact-us.svg'),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Contact US'),
                ],
              ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/terms-and-conditions.svg'),
                SizedBox(
                  width: 5,
                ),
                Text('Terms and Conditions'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
