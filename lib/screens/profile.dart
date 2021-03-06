import 'package:aqar_bazar/Models/profile_form_model.dart';
import 'package:aqar_bazar/screens/account_info.dart';
import 'package:aqar_bazar/screens/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/widgets/account_info_card.dart';
import 'package:aqar_bazar/widgets/app_settings_card.dart';
import 'package:aqar_bazar/widgets/about_aqar_card.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileFormModel myModel = ProfileFormModel();

  void updateUI(ProfileFormModel model) {
    setState(() {
      myModel = model;
    });
  }

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
                  Container(
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'Username',
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
                            model: myModel,
                          ),
                          onTap: () async {
                            var model = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AccountInfo(
                                accountInfo: myModel,
                              );
                            }));
                            if (model != null) updateUI(model);
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
