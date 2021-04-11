import 'package:aqar_bazar/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.safeBlockVertical * 30),
          child: Container(
            height: SizeConfig.safeBlockVertical * 21,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(0, 4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * 5),
                  child: SvgPicture.asset('assets/icons/bell-large.svg'),
                ),
                Text(
                  Applocalizations.of(context).translate("Notifications"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 6,
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(child: NotificationTile());
                },
                itemCount: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
