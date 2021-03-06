import 'package:aqar_bazar/Models/profile_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/constants.dart';

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({
    @required this.width,
    @required this.height,
    this.model,
  });

  final double width;
  final double height;
  final ProfileFormModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 2 - 20,
      height: height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [kButtonShadow],
      ),
      child: Column(
        children: [
          Container(
            height: height / 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width / 18,
                    height: width / 18,
                    child: SvgPicture.asset(
                      'assets/icons/account small.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Container(
                    width: width / 2 - 70,
                    child: Text(
                      "Account Information",
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/name.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('name'),
                  ],
                ),
                Container(
                  width: 70,
                  child: Text(
                    model.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            color: Theme.of(context).primaryColor,
            thickness: 0.8,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/email.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Email'),
                  ],
                ),
                Container(
                  width: 80,
                  child: Text(
                    model.email,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            color: Theme.of(context).primaryColor,
            thickness: 0.8,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/phone.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Phone'),
                  ],
                ),
                Container(
                  width: 70,
                  child: Text(
                    model.phoneNumber,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            color: Theme.of(context).primaryColor,
            thickness: 0.8,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/padlock.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Password'),
                  ],
                ),
                Container(
                  width: 60,
                  child: Text(
                    '********',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
