import 'package:aqar_bazar/Models/property_data.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';

class SearchResultCard extends StatelessWidget {
  final PropertyData propertyData;
  final bool buy;
  final bool wishlistItem;
  final Function onDelete;

  const SearchResultCard(
      {this.propertyData, this.buy, this.wishlistItem = false, this.onDelete});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  //width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        height: SizeConfig.safeBlockVertical * 26,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                                image: AssetImage('assets/temp/prop1.png'),
                                fit: BoxFit.fill)),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: SizeConfig.safeBlockHorizontal * 22,
                          height: SizeConfig.safeBlockVertical * 5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              topLeft: Radius.circular(40),
                            ),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/icons/Logo short.png')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal * 2.5,
                    vertical: 5),
                child: Text(
                  propertyData.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 3),
                    child: Text(
                      buy
                          ? propertyData.purchasePrice + " TL"
                          : propertyData.rentPrice + " TL",
                      style: TextStyle(color: Theme.of(context).accentColor),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  wishlistItem
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.safeBlockHorizontal * 3),
                          child: InkWell(
                            onTap: onDelete,
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              )
            ],
          ),
          height: SizeConfig.safeBlockVertical * 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                offset: Offset(2.0, 2.0),
                blurRadius: 10.0,
              )
            ],
          )),
    );
  }
}
