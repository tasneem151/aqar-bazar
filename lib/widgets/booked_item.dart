import 'package:aqar_bazar/Models/book_list.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/widgets/feature_card.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class BookedItem extends StatelessWidget {
  final BookedItemData item;
  final Function onCancel;

  const BookedItem({this.item, this.onCancel});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 2),
      child: Container(
        height: SizeConfig.safeBlockVertical * 26.5,
        color: Colors.white,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
              left: SizeConfig.safeBlockHorizontal * 2.5,
              top: -SizeConfig.safeBlockVertical * 2.5,
              child: FeatureCard(
                property: item.property,
                width: SizeConfig.safeBlockHorizontal * 47,
                shadow: BoxShadow(
                  color: Colors.grey[200],
                  offset: Offset(2.0, 2.0), //(x,y)
                  blurRadius: 10.0,
                ),
              ),
            ),
            Positioned(
              top: SizeConfig.safeBlockVertical * 2,
              right: SizeConfig.safeBlockHorizontal * 3,
              left: SizeConfig.safeBlockHorizontal * 55,
              bottom: SizeConfig.safeBlockVertical * 2,
              child: Column(
                children: [
                  Text(
                    Applocalizations.of(context).translate('Price'),
                    style:
                        TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4),
                  ),
                  Text(
                    item.property.rentPrice,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1.5,
                  ),
                  Text(Applocalizations.of(context).translate('Status'),
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4)),
                  Text(
                    item.status,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1.5,
                  ),
                  Text(Applocalizations.of(context).translate('Square Space'),
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4)),
                  Text(
                    item.property.area.toString(),
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4,
                        color: Theme.of(context).accentColor),
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
