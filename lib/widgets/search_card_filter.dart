import 'package:aqar_bazar/Models/property_type.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchCardFilter extends StatefulWidget {
  final PropertyType typeProperty;
  final bool isChecked;

  const SearchCardFilter({Key key, this.typeProperty, this.isChecked})
      : super(key: key);
  @override
  _SearchCardFilterState createState() => _SearchCardFilterState();
}

class _SearchCardFilterState extends State<SearchCardFilter> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.safeBlockHorizontal * 30,
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 25,
                  height: SizeConfig.safeBlockHorizontal * 25,
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
                    image: widget.typeProperty.image == "no_image"
                        ? DecorationImage(
                            image: AssetImage('assets/icons/no-image.png'),
                            fit: BoxFit.scaleDown,
                          )
                        : DecorationImage(
                            image: CachedNetworkImageProvider(
                                kBaseUrl + widget.typeProperty.image),
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              widget.isChecked
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * 25,
                        height: SizeConfig.safeBlockHorizontal * 25,
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
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical,
          ),
          Text(widget.typeProperty.title),
        ],
      ),
    );
  }
}
