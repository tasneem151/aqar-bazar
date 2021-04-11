import 'package:aqar_bazar/screens/account_info.dart';
import 'package:aqar_bazar/screens/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/widgets/account_info_card.dart';
import 'package:aqar_bazar/widgets/app_settings_card.dart';
import 'package:aqar_bazar/widgets/about_aqar_card.dart';
import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/Provider/modelsProvider.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfileInfo user =
        Provider.of<ModelsProvider>(context, listen: true).getUserInfo();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: SizeConfig.safeBlockVertical * 85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(SizeConfig.screenWidth, 270)),
                  color: Color(0xfff6f6f6)),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 12),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xff21d8a2),
                    child: Text(
                      user == null
                          ? ""
                          : user.firstName[0].toUpperCase() +
                              user.lastName[0].toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                ),
                /* Container(
                  width: width / 3,
                  height: width / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent,
                      //boxShadow: [kButtonShadow],
                      image: DecorationImage(
                          image: AssetImage('assets/temp/user.png'))),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: width / 12,
                          width: width / 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(30)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ), */
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockHorizontal * 2.5,
                      bottom: SizeConfig.safeBlockHorizontal * 8),
                  child: Text(
                    user.firstName[0].toUpperCase() +
                        user.firstName.substring(1) +
                        " " +
                        user.lastName[0].toUpperCase() +
                        user.lastName.substring(1),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: AccountInfoCard(),
                        onTap: () async {
                          var val = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AccountInfo();
                          }));
                          setState(() {});
                        },
                      ),
                      InkWell(
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AppSettings();
                                  },
                                ),
                              ),
                          child: AppSettingsCard()),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.safeBlockHorizontal * 8),
                  child: AboutAqarCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
