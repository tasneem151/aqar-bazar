import 'package:aqar_bazar/Models/get_notifications.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';

class NotificationTile extends StatelessWidget {
  final NotificationData notification;

  const NotificationTile({this.notification});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      //color: Colors.blueGrey,
      //height: SizeConfig.safeBlockVertical * 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal * 5,
                right: SizeConfig.safeBlockHorizontal * 5,
                top: SizeConfig.safeBlockVertical * 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  notification.createdAt.day.toString() +
                      '-' +
                      notification.createdAt.month.toString() +
                      '-' +
                      notification.createdAt.year.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 5,
              right: SizeConfig.safeBlockHorizontal * 5,
              top: SizeConfig.safeBlockVertical,
            ),
            child: Text(
              notification.content,
              style: TextStyle(color: Colors.grey, fontSize: 16),
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 4,
          ),
          Divider(
            color: Colors.grey,
            height: 5,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
