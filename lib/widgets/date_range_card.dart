import 'package:aqar_bazar/constants.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/Provider/date_provider.dart';
import 'package:provider/provider.dart';

class DateRangeCard extends StatefulWidget {
  @override
  _DateRangeCardState createState() => _DateRangeCardState();
}

class _DateRangeCardState extends State<DateRangeCard> {
  DateTimeRange picked;
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
                Container(
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
                        picked != null
                            ? picked.start.day.toString()
                            : DateTime.now().day.toString(),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      Text('/',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      Text(
                        picked != null
                            ? picked.start.month.toString()
                            : DateTime.now().month.toString(),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      Text('/',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      Text(
                        picked != null
                            ? picked.start.year.toString()
                            : DateTime.now().year.toString(),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
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
                Container(
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
                        picked != null
                            ? picked.end.day.toString()
                            : DateTime.now().day.toString(),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      Text('/',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      Text(
                        picked != null
                            ? picked.end.month.toString()
                            : DateTime.now().month.toString(),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      Text('/',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      Text(
                        picked != null
                            ? picked.end.year.toString()
                            : DateTime.now().year.toString(),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2222),
                ).then((value) => {
                      setState(() {
                        picked = value;
                        Provider.of<DateProvider>(context, listen: false)
                            .setStartDate(picked.start.year.toString() +
                                "-" +
                                picked.start.month.toString() +
                                "-" +
                                picked.start.day.toString());
                        Provider.of<DateProvider>(context, listen: false)
                            .setEndDate(picked.end.year.toString() +
                                "-" +
                                picked.end.month.toString() +
                                "-" +
                                picked.end.day.toString());
                      })
                    });
              },
              child: Container(
                width: width / 4,
                height: height / 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: kGradient,
                ),
                child: Center(
                  child: Text(
                    "Pick A Date",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}