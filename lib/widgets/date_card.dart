import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class DateCard extends StatefulWidget {
  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  DateTime startDate;
  DateTime endDate;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width / 1.1,
      height: height / 4.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [kBoxShadow],
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start Date'),
                InkWell(
                  onTap: () {
                    showRoundedDatePicker(
                      height: MediaQuery.of(context).size.height / 2.5,
                      context: context,
                      initialDate:
                          startDate == null ? DateTime.now() : startDate,
                      firstDate: DateTime.now().subtract(Duration(days: 1)),
                      lastDate: DateTime(2222),
                      borderRadius: 20,
                      theme: Themes.themeData(context),
                    ).then((date) {
                      setState(() {
                        startDate = date;
                      });
                    });
                  },
                  child: Container(
                    width: width / 4.5,
                    height: height / 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(0.0, 6.0),
                          blurRadius: 6.0,
                        )
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          startDate == null
                              ? DateTime.now().day.toString()
                              : startDate.day.toString(),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        Text('/',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                        Text(
                          startDate == null
                              ? DateTime.now().month.toString()
                              : startDate.month.toString(),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        Text('/',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                        Text(
                          startDate == null
                              ? DateTime.now().year.toString()
                              : startDate.year.toString(),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('End Date'),
                InkWell(
                  onTap: () {
                    showRoundedDatePicker(
                      height: MediaQuery.of(context).size.height / 2.5,
                      context: context,
                      initialDate: startDate == null
                          ? DateTime.now()
                          : startDate.add(Duration(days: 1)),
                      firstDate: startDate == null
                          ? DateTime.now()
                          : startDate.subtract(Duration(minutes: 60)),
                      lastDate: DateTime(2222),
                      borderRadius: 20,
                      theme: Themes.themeData(context),
                    ).then((date) {
                      setState(() {
                        endDate = date;
                      });
                    });
                  },
                  child: Container(
                    width: width / 4.5,
                    height: height / 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(0.0, 6.0),
                          blurRadius: 6.0,
                        )
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          endDate == null && startDate == null
                              ? (DateTime.now().day + 1).toString()
                              : endDate == null && startDate != null
                                  ? (startDate.day + 1).toString()
                                  : endDate.day.toString(),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        Text('/',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                        Text(
                          endDate == null && startDate == null
                              ? DateTime.now().month.toString()
                              : endDate == null && startDate != null
                                  ? startDate.month.toString()
                                  : endDate.month.toString(),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        Text('/',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                        Text(
                          endDate == null && startDate == null
                              ? DateTime.now().year.toString()
                              : endDate == null && startDate != null
                                  ? startDate.year.toString()
                                  : endDate.year.toString(),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
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
