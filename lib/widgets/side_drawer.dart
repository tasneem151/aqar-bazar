import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/screens/about_us.dart';
import 'package:aqar_bazar/screens/contact_us.dart';
import 'package:aqar_bazar/screens/my_bookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aqar_bazar/screens/wishlist.dart';
import 'package:aqar_bazar/Manager/manager.dart';
import 'package:aqar_bazar/screens/sign_in.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Image(image: AssetImage('assets/icons/aqar drawer.png')),
            /* Container(
              height: 100,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
            ), */
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 2,
              indent: 50,
              endIndent: 50,
              color: kCustomBlueGrey,
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyBookings();
              })),
              title: Text(
                'My Bookings',
                style: TextStyle(color: kCustomBlueGrey),
              ),
              trailing: SvgPicture.asset('assets/icons/booking.svg'),
            ),
            Divider(
              height: 2,
              thickness: 0.5,
              color: kCustomBlueGrey,
            ),
            ListTile(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Wishlist();
              })),
              title: Text(
                'Wishlist',
                style: TextStyle(color: kCustomBlueGrey),
              ),
              trailing: Icon(
                FontAwesomeIcons.solidHeart,
                color: Theme.of(context).accentColor,
              ),
            ),
            Divider(
              height: 2,
              thickness: 0.5,
              color: kCustomBlueGrey,
            ),
            ListTile(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutUs();
              })),
              title: Text(
                'About us',
                style: TextStyle(color: kCustomBlueGrey),
              ),
              trailing: SvgPicture.asset('assets/icons/information-25.svg'),
            ),
            Divider(
              height: 2,
              thickness: 0.5,
              color: kCustomBlueGrey,
            ),
            ListTile(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ContactUs();
              })),
              title: Text(
                'Contact us',
                style: TextStyle(color: kCustomBlueGrey),
              ),
              trailing: SvgPicture.asset('assets/icons/contact-25.svg'),
            ),
            Divider(
              height: 2,
              thickness: 0.5,
              color: kCustomBlueGrey,
            ),
            ListTile(
              onTap: () {
                Manager.logout(context).then((value) => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SignIn();
                      }))
                    });
              },
              title: Text(
                'Log Out',
                style: TextStyle(color: kCustomBlueGrey),
              ),
              trailing: SvgPicture.asset('assets/icons/logout.svg'),
            ),
            Divider(
              height: 2,
              thickness: 0.5,
              color: kCustomBlueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
