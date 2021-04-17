import 'package:aqar_bazar/Models/property_type.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/screens/search_result.dart';
import 'package:aqar_bazar/Models/search_request_model.dart';

class ExploreCard extends StatefulWidget {
  final PropertyType typeProperty;
  final bool buy;

  const ExploreCard({Key key, this.typeProperty, this.buy}) : super(key: key);
  @override
  _ExploreCardState createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  /* bool _isChecked = false;
  void toggle() {
    _isChecked = !_isChecked;
  } */

  SearchRequestModel searchByCategory = SearchRequestModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchByCategory.catId = widget.typeProperty.id;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        widget.buy
            ? searchByCategory.selectedItem = "purchase"
            : searchByCategory.selectedItem = "rent";
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchResult(
            buy: widget.buy,
            searchParams: searchByCategory,
          );
        }));
      },
      child: Container(
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
                            image: NetworkImage(
                                kBaseUrl + widget.typeProperty.image),
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(widget.typeProperty.title)),
          ],
        ),
      ),
    );
  }
}
