import 'package:flutter/material.dart';
import 'package:aqar_bazar/widgets/feature_card.dart';

class BookedItem extends StatelessWidget {
  const BookedItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Positioned(
          left: 10,
          top: -20,
          child: FeatureCard(
            width: MediaQuery.of(context).size.width / 2.2,
            shadow: BoxShadow(
              color: Colors.grey[200],
              offset: Offset(2.0, 2.0), //(x,y)
              blurRadius: 10.0,
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 40,
          child: Column(
            children: [
              Text(
                'Price',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '10000 LE',
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).accentColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Status', style: TextStyle(fontSize: 18)),
              Text(
                'Contacted agent',
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).accentColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Square Space', style: TextStyle(fontSize: 18)),
              Text(
                '500 m',
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).accentColor),
              ),
            ],
          ),
        ),
        Positioned(
            right: 5,
            top: 5,
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ],
    );
  }
}
