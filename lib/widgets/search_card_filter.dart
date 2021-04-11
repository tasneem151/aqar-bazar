import 'package:aqar_bazar/Models/property_type.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';

class SearchCardFilter extends StatefulWidget {
  final PropertyType typeProperty;
  final bool isChecked;

  const SearchCardFilter({Key key, this.typeProperty, this.isChecked})
      : super(key: key);
  @override
  _SearchCardFilterState createState() => _SearchCardFilterState();
}

class _SearchCardFilterState extends State<SearchCardFilter> {
  /* bool _isChecked = false;
  int catId;
  void toggle() {
    _isChecked = !_isChecked;
    _isChecked ? catId = widget.typeProperty.id : catId = null;
    print(catId);
  } */

  String baseUrl = "http://new.aqarbazar.com";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.safeBlockHorizontal * 30,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
              child: Container(
                width: SizeConfig.safeBlockHorizontal * 30,
                height: SizeConfig.safeBlockVertical * 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500],
                      offset: Offset(2.0, 2.0),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Container(
                  child: widget.typeProperty.image == "no_image"
                      ? Image(
                          image: AssetImage('assets/icons/no-image.png'),
                          fit: BoxFit.scaleDown,
                        )
                      : Image(
                          image:
                              NetworkImage(baseUrl + widget.typeProperty.image),
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
          ),
          widget.isChecked
              ? Padding(
                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 30,
                      height: SizeConfig.safeBlockVertical * 14,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Container(
                          height: SizeConfig.safeBlockHorizontal * 18,
                          child: Image(
                            image: AssetImage('assets/icons/check-mark.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(widget.typeProperty.title)),
        ],
      ),
    );
  }
}
