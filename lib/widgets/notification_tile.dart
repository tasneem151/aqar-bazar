import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';

class NotificationTile extends StatelessWidget {
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
                  'property name',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '12 - 4 - 2021',
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
              "noti details",
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
