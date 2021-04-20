import 'dart:io';

import 'package:aqar_bazar/Models/agent_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import 'package:aqar_bazar/networking/services.dart';

class AgentInfo extends StatefulWidget {
  final String id;

  const AgentInfo({this.id});
  @override
  _AgentInfoState createState() => _AgentInfoState();
}

class _AgentInfoState extends State<AgentInfo> {
  bool loading;
  Agent agent;

  void launchWhatsApp({
    @required int phone,
  }) async {
    String url() {
      if (Platform.isAndroid) {
        return "https://wa.me/$phone";
      } else {
        return "https://api.whatsapp.com/send?phone=$phone";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  void launchCall({
    @required String phone,
  }) async {
    String url() {
      return 'tel:$phone';
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  void launchEmail({
    @required String email,
  }) async {
    String url() {
      return 'mailto:$email';
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    Services.getAgentInfo(context, widget.id).then((value) => {
          if (mounted)
            {
              print(value),
              agent = value,
              setState(() {
                loading = false;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.safeBlockVertical * 7),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: SizeConfig.safeBlockHorizontal * 15,
                        backgroundColor: Color(0xff21d8a2),
                        child: Text(
                          agent.firstName == null
                              ? " "
                              : agent.firstName[0].toUpperCase() +
                                  agent.lastName[0].toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockHorizontal * 13),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 3,
                    ),
                    Text(
                      agent.firstName == null
                          ? "Agent Not Found"
                          : agent.firstName + ' ' + agent.lastName,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    Divider(
                      height: 2,
                      thickness: 0.5,
                      color: kCustomBlueGrey,
                      indent: SizeConfig.safeBlockHorizontal * 14,
                      endIndent: SizeConfig.safeBlockHorizontal * 14,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 5,
                    ),
                    Text(
                      agent.phone == null ? 'Phone Not Found' : agent.phone,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: SizeConfig.safeBlockHorizontal * 6),
                    ),
                    Text(
                      agent.email == null ? 'Email Not Found' : agent.email,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: SizeConfig.safeBlockHorizontal * 6),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    Text(
                      Applocalizations.of(context).translate("Available On"),
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: SizeConfig.safeBlockHorizontal * 5),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              launchWhatsApp(phone: int.parse(agent.phone));
                            },
                            child:
                                SvgPicture.asset('assets/icons/whatsapp.svg')),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              launchCall(phone: agent.phone);
                            },
                            child: Image(
                              image: AssetImage('assets/icons/call2.png'),
                            )),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              launchEmail(email: agent.email);
                            },
                            child:
                                SvgPicture.asset('assets/icons/envelope.svg')),
                      ],
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: SizeConfig.safeBlockVertical * 12,
                              width: SizeConfig.safeBlockHorizontal * 16,
                              decoration: BoxDecoration(
                                  color: Color(0xff4e89c7),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100))),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: SizeConfig.safeBlockVertical * 12,
                              width: SizeConfig.safeBlockHorizontal * 16,
                              decoration: BoxDecoration(
                                  color: Color(0xff21d8a2),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      bottomLeft: Radius.circular(100))),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    ));
  }
}
