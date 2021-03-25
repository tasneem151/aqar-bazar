import 'package:aqar_bazar/Models/featured.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/constants.dart';

class FeatureCard extends StatelessWidget {
  final double width;
  final BoxShadow shadow;
  final Featured property;

  const FeatureCard({Key key, this.width, this.shadow, this.property})
      : super(key: key);
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
                  width: width,
                  //MediaQuery.of(context).size.width / 2.4,
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
                                  image: property.mainImageUrl == "no_image"
                                      ? AssetImage('assets/temp/prop1.png')
                                      : NetworkImage(
                                          baseUrl + property.mainImageUrl),
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
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  property.title,
                  style: TextStyle(fontSize: 18),
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
                height: 30,
              )
            ],
          ),
          //width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 3.5,
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
