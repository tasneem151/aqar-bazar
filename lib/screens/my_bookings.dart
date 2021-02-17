import 'package:aqar_bazar/widgets/buy_rent_switch.dart';
import 'package:aqar_bazar/widgets/booked_item.dart';
import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  bool isBuySelected = true;

  bool isRentSelected = false;

  void onBuySwitchCallback() {
    setState(() {
      isBuySelected = true;
      isRentSelected = false;
    });
  }

  void onRentSwitchCallback() {
    setState(() {
      isBuySelected = false;
      isRentSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "My Bookings",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: BuyRentSwitch(
                  isRentSelected: isRentSelected,
                  isBuySelected: isBuySelected,
                  onBuySwitch: onBuySwitchCallback,
                  onRentSwitch: onRentSwitchCallback,
                  shadow: BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 10.0,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.8,
                color: Colors.white,
                child: BookedItem(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
