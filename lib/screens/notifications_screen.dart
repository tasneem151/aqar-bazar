import 'package:aqar_bazar/Models/get_notifications.dart';
import 'package:aqar_bazar/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aqar_bazar/networking/services.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool loading;
  bool isLoading = false;
  GetNotifications notifications;
  int page = 1;

  @override
  void initState() {
    super.initState();
    loading = true;
    Services.getNotifications(context).then((value) => {
          if (mounted)
            {
              print(value),
              notifications = value,
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
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!isLoading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          if (page < notifications.lastPage) {
                            page++;
                            setState(() {
                              isLoading = true;
                              Services.getNotifications(context)
                                  .then((value) => {
                                        if (mounted)
                                          {
                                            notifications.data
                                                .addAll(value.data),
                                            setState(() {
                                              isLoading = false;
                                            }),
                                          }
                                      });
                            });
                          }
                        }
                        return true;
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                              child: NotificationTile(
                            notification: notifications.data[index],
                          ));
                        },
                        itemCount: notifications.data.length,
                      ),
                    ),
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}
