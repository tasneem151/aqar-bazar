import 'package:aqar_bazar/Models/book_list.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/widgets/booked_item.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<BookedItemData> bookList = [];
  bool loading;

  void cancel(int id) {
    Services.cancelBooking(id.toString(), context).then((value) => {
          setState(() {
            _updateUI();
          }),
        });
    setState(() {
      loading = true;
    });
  }

  void _updateUI() {
    Services.getBookList(context).then((value) => {
          if (mounted)
            {
              setState(() {
                bookList = value;
                loading = false;
              })
            }
        });
  }

  void showAlert(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(right: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Text(
              Applocalizations.of(context).translate("Cancel Reservation"),
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Text(
              Applocalizations.of(context).translate(
                  "Are You Sure You Want to Cancel Your Reservation?"),
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).accentColor)),
          actions: <Widget>[
            Container(
                height: SizeConfig.safeBlockVertical * 6,
                width: SizeConfig.safeBlockHorizontal * 75,
                child: Row(children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        cancel(id);
                        Navigator.of(context).pop();
                      },
                      child:
                          Text(Applocalizations.of(context).translate("Yes")),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(Applocalizations.of(context).translate("No")),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    ),
                  )),
                ]))
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    _updateUI();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        child: Container(
          color: Color(0xfff6f6f6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 3,
                ),
                child: Text(
                  Applocalizations.of(context).translate("My Bookings"),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5),
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(SizeConfig.safeBlockVertical * 8),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loading
                ? Center(
                    child: LinearProgressIndicator(),
                  )
                : Container(),
            !loading && bookList.length == 0
                ? Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 37,
                    ),
                    child: Center(
                      child: Text(
                        Applocalizations.of(context)
                            .translate("No Bookings Yet"),
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 5),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return BookedItem(
                        onCancel: () {
                          showAlert(bookList[index].id);
                        },
                        item: bookList[index],
                      );
                    },
                    itemCount: bookList.length,
                  ),
          ],
        ),
      ),
    ));
  }
}
