import 'package:aqar_bazar/screens/account_info.dart';
import 'package:aqar_bazar/screens/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/widgets/account_info_card.dart';
import 'package:aqar_bazar/widgets/app_settings_card.dart';
import 'package:aqar_bazar/widgets/about_aqar_card.dart';
import 'package:aqar_bazar/Models/profile_info.dart';

class Profile extends StatefulWidget {
  final ProfileInfo user;

  const Profile({Key key, this.user}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    //updateUI(typedName)
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //width: 200,
              height: height - (height / 7),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.elliptical(width, 270)),
                  color: Color(0xfff6f6f6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xff21d8a2),
                    child: Text(
                      widget.user == null
                          ? ""
                          : widget.user.firstName[0].toUpperCase() +
                              widget.user.lastName[0].toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 50),
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
                    padding: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      widget.user.firstName[0].toUpperCase() +
                          widget.user.firstName.substring(1) +
                          " " +
                          widget.user.lastName[0].toUpperCase() +
                          widget.user.lastName.substring(1),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: AccountInfoCard(
                            width: width,
                            height: height,
                            userInfo: widget.user,
                          ),
                          onTap: () async {
                            var val = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AccountInfo(
                                accountInfo: widget.user,
                              );
                            }));
                            if (val) setState(() {});
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
                            child:
                                AppSettingsCard(width: width, height: height)),
                      ],
                    ),
                  ),
                  AboutAqarCard(width: width, height: height),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
