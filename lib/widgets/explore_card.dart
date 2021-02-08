import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width / 4,
            height: width / 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(2.0, 2.0), //(x,y)
                  blurRadius: 6.0,
                )
              ],
            ),
            child: Container(
              child: Image(
                image: AssetImage('assets/temp/house.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text('House'),
      ],
    );
  }
}
