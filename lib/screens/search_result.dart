import 'package:aqar_bazar/Models/search_model.dart';
import 'package:aqar_bazar/screens/buy_details.dart';
import 'package:aqar_bazar/screens/rent_details.dart';
import 'package:aqar_bazar/widgets/search_result_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResult extends StatefulWidget {
  final SearchResponse searchResponse;
  final bool buy;
  const SearchResult({this.searchResponse, this.buy});
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width / 1.3,
                      height: height / 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Color(0xffD8D8D8),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Property Name",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Color(0xff707070),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SvgPicture.asset('assets/icons/filter.svg'),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: GridView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 3),
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BuyDetails(
                              id: widget.searchResponse.data[index].id,
                              buy: widget.buy,
                            );
                          }));
                        },
                        child: SearchResultCard(
                          propertyData: widget.searchResponse.data[index],
                          buy: widget.buy,
                        ),
                      );
                    },
                    itemCount: widget.searchResponse.data.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
