import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/icons/logo-short-large.png'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Do you want to contact us?",
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
              Text(
                "It's easy we're only a click away",
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ]),
                child: TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: "Type your message here",
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 10),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 3.3,
                child: Center(
                  child: Text(
                    "Send",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff21d8a2),
                      Color(0xff4e89c7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 1.0],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff4e89c7),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff21d8a2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
