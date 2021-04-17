import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'contact_us.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 5,
                  bottom: SizeConfig.safeBlockVertical * 4.5),
              child:
                  Image(image: AssetImage('assets/icons/logo-short-large.png')),
            )),
            Text(
              Applocalizations.of(context).translate('About AQAR BAZAR'),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 5,
                color: Color(0xff015ca7),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 2,
                  bottom: SizeConfig.safeBlockVertical * 2),
              child: Image(image: AssetImage('assets/temp/about2.png')),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                SizeConfig.safeBlockHorizontal * 2,
                SizeConfig.safeBlockHorizontal * 2,
                SizeConfig.safeBlockHorizontal * 2,
                SizeConfig.safeBlockHorizontal * 12,
              ),
              child: Container(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, sapien in mollis tristique, diam ex tristique metus, ut hendrerit ante quam sit amet erat. Fusce aliquet eros vitae quam sodales luctus. Nunc venenatis nunc ac neque interdum vulputate. Etiam eget convallis lacus. Ut viverra nisi ac tortor ultrices ultrices. Aenean aliquet elementum vestibulum. In luctus tempus justo, euismod gravida ante vehicula a. Donec vitae volutpat sapien. Etiam vitae tellus quis magna placerat maximus vel sit amet orci.',
                  overflow: TextOverflow.clip,
                  maxLines: 15,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Text(
              Applocalizations.of(context).translate('What Do We Do?'),
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff015ca7),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 3,
                      right: SizeConfig.safeBlockHorizontal * 2),
                  child: Image(image: AssetImage('assets/temp/about1.png')),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * 50,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, sapien in mollis tristique, diam ex tristique metus, ut hendrerit ante quam sit amet erat. Fusce aliquet eros vitae quam sodales luctus. Nunc venenatis nunc ac neque interdum vulputate. Etiam eget convallis lacus. Ut viverra nisi ac tortor ultrices ultrices. Aenean aliquet elementum vestibulum. In luctus tempus justo, euismod gravida ante vehicula a. Donec vitae volutpat sapien. Etiam vitae tellus quis magna placerat maximus vel sit amet orci.',
                          overflow: TextOverflow.clip,
                          maxLines: 15,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * 50,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, sapien in mollis tristique, diam ex tristique metus, ut hendrerit ante quam sit amet erat. Fusce aliquet eros vitae quam sodales luctus. Nunc venenatis nunc ac neque interdum vulputate. Etiam eget convallis lacus. Ut viverra nisi ac tortor ultrices ultrices. Aenean aliquet elementum vestibulum. In luctus tempus justo, euismod gravida ante vehicula a. Donec vitae volutpat sapien. Etiam vitae tellus quis magna placerat maximus vel sit amet orci.',
                          overflow: TextOverflow.clip,
                          maxLines: 15,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: SizeConfig.safeBlockHorizontal * 3),
                  child: Image(image: AssetImage('assets/temp/about3.png')),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            Text(
              Applocalizations.of(context).translate('Do You Have A Question?'),
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff015ca7),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            InkWell(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ContactUs();
              })),
              child: Container(
                height: SizeConfig.safeBlockVertical * 6,
                width: SizeConfig.safeBlockHorizontal * 45,
                child: Center(
                  child: Text(
                    Applocalizations.of(context).translate("Contact Us"),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 6,
            ),
          ],
        ),
      ),
    ));
  }
}
