import 'package:aqar_bazar/Models/property_type.dart';
import 'package:flutter/material.dart';

class ExploreCard extends StatefulWidget {
  final PropertyType typeProperty;

  const ExploreCard({Key key, this.typeProperty}) : super(key: key);
  @override
  _ExploreCardState createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  /* bool _isChecked = false;
  void toggle() {
    _isChecked = !_isChecked;
  } */

  String baseUrl = "http://new.aqarbazar.com";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 3.5,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
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
          /* _isChecked
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: width / 4,
                      height: width / 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Container(
                          width: width / 6,
                          height: width / 6,
                          child: Image(
                            image: AssetImage('assets/icons/check-mark.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(), */
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(widget.typeProperty.title)),
        ],
      ),
    );
  }
}
