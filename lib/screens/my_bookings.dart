import 'package:aqar_bazar/Models/book_list.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/widgets/buy_rent_switch.dart';
import 'package:aqar_bazar/widgets/booked_item.dart';
import 'package:flutter/material.dart';

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
          title: Text("Cancel Reservation",
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Text("Are You Sure You Want to Cancel Your Reservation?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).accentColor)),
          actions: <Widget>[
            Container(
                height: 50,
                width: 280,
                child: Row(children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        cancel(id);
                        Navigator.of(context).pop();
                      },
                      child: Text("Yes"),
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
                      child: Text("No"),
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 17, 10, 0),
          color: Color(0xfff6f6f6),
          width: width,
          height: height / 17,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Bookings",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(height / 20),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              loading
                  ? Center(
                      child: LinearProgressIndicator(),
                    )
                  : Container(),
              !loading && bookList.length == 0
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: height / 3,
                      ),
                      child: Center(
                        child: Text(
                          "No Bookings Yet.",
                          style: TextStyle(fontSize: 20),
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
      ),
    ));
  }
}
