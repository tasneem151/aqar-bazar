import 'package:aqar_bazar/Models/book_list.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/widgets/feature_card.dart';

class BookedItem extends StatelessWidget {
  final BookedItemData item;
  final Function onCancel;

  const BookedItem({this.item, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.8,
        color: Colors.white,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
              left: 10,
              top: -20,
              child: FeatureCard(
                property: item.property,
                width: MediaQuery.of(context).size.width / 2.2,
                shadow: BoxShadow(
                  color: Colors.grey[200],
                  offset: Offset(2.0, 2.0), //(x,y)
                  blurRadius: 10.0,
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 45,
              child: Column(
                children: [
                  Text(
                    'Price',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    item.property.rentPrice,
                    style: TextStyle(
                        fontSize: 18, color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Status', style: TextStyle(fontSize: 18)),
                  Text(
                    item.status,
                    style: TextStyle(
                        fontSize: 18, color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Square Space', style: TextStyle(fontSize: 18)),
                  Text(
                    item.property.area.toString(),
                    style: TextStyle(
                        fontSize: 18, color: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  onTap: onCancel,
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
