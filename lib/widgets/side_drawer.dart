import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/screens/about_us.dart';
import 'package:aqar_bazar/screens/contact_us.dart';
import 'package:aqar_bazar/screens/my_bookings.dart';
import 'package:aqar_bazar/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aqar_bazar/screens/wishlist.dart';
import 'package:aqar_bazar/Manager/manager.dart';
import 'package:aqar_bazar/screens/sign_in.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/Provider/modelsProvider.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileInfo account =
        Provider.of<ModelsProvider>(context, listen: true).getUserInfo();
    SizeConfig().init(context);
    return Drawer(
      child: Column(
        children: [
          GestureDetector(
            onTap: account != null
                ? () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Profile();
                    }));
                  }
                : () {},
            child: UserAccountsDrawerHeader(
              accountName: Text(
                account == null
                    ? ""
                    : account.firstName[0].toUpperCase() +
                        account.firstName.substring(1) +
                        " " +
                        account.lastName[0].toUpperCase() +
                        account.lastName.substring(1),
                style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 5),
              ),
              accountEmail: Text(account == null ? "" : account.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xff21d8a2),
                child: Text(
                  account == null
                      ? ""
                      : account.firstName[0].toUpperCase() +
                          account.lastName[0].toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 8),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyBookings();
            })),
            title: Text(
              Applocalizations.of(context).translate('My Bookings'),
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
              Applocalizations.of(context).translate('Wishlist'),
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
              Applocalizations.of(context).translate('About Us'),
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
              Applocalizations.of(context).translate('Contact Us'),
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
              Applocalizations.of(context).translate('Log Out'),
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
    );
  }
}
