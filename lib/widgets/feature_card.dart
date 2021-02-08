import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(
                      children: [
                        Container(
                          //width: MediaQuery.of(context).size.width / 1.5,
                          height:
                              (MediaQuery.of(context).size.height / 3.5) - 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                  image: AssetImage('assets/temp/prop1.png'),
                                  fit: BoxFit.fill)),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4.5,
                            height: MediaQuery.of(context).size.height / 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40),
                                topLeft: Radius.circular(40),
                              ),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/icons/Logo short.png')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  " Villa Sehr gros",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text("Im Hamburg "),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
          //width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                offset: Offset(2.0, 2.0), //(x,y)
                blurRadius: 6.0,
              )
            ],
          )),
    );
  }
}
