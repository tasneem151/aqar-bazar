import 'package:aqar_bazar/Models/featured.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FeatureCard extends StatelessWidget {
  final double width;
  final BoxShadow shadow;
  final Featured property;

  const FeatureCard({this.width, this.shadow, this.property});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
      child: Container(
          height: SizeConfig.safeBlockVertical * 29,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                  image: property.mainImageUrl == "no_image"
                                      ? AssetImage('assets/temp/prop1.png')
                                      : NetworkImage(
                                          baseUrl + property.mainImageUrl),
                                  fit: BoxFit.fill)),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: SizeConfig.safeBlockHorizontal * 22,
                            height: SizeConfig.safeBlockVertical * 4.5,
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
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal * 2.5,
                    right: SizeConfig.safeBlockHorizontal * 2.5),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 40,
                  child: AutoSizeText(
                    property.title,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4.7,
                        fontWeight: FontWeight.w600),
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              /* Padding(
                padding: const EdgeInsets.only(top: 3, left: 20, right: 20),
                child: Text(
                  property.location == null
                      ? "Couldn't find location"
                      : property.location,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ), */
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              shadow
              /* BoxShadow(
                color: Colors.grey[200],
                offset: Offset(2.0, 2.0), //(x,y)
                blurRadius: 10.0,
              ) */
            ],
          )),
    );
  }
}
