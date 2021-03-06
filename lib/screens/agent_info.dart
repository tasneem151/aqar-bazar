import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class AgentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: width / 3,
                  height: width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blueAccent,
                    //boxShadow: [kButtonShadow],
                    image: DecorationImage(
                      image: AssetImage('assets/temp/user.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "agent name",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 40,
              ),
              Divider(
                height: 2,
                thickness: 0.5,
                color: kCustomBlueGrey,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Phone:",
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
              Text(
                "Email:",
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Available On",
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/whatsapp.svg'),
                  SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset('assets/icons/telegram.svg'),
                  SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset('assets/icons/envelope.svg'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 100,
                      width: 60,
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
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff21d8a2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
