import 'package:aqar_bazar/Models/search_model.dart';
import 'package:aqar_bazar/Models/search_request_model.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/screens/buy_details.dart';
import 'package:aqar_bazar/widgets/search_result_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResult extends StatefulWidget {
  final SearchRequestModel searchParams;
  final bool buy;

  const SearchResult({this.searchParams, this.buy});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  bool loading;
  SearchResponse searchResponse;
  bool isLoading = false;
  int page = 1;
  TextEditingController controller = TextEditingController();

  void _updateUI() {
    controller.clear();
    loading = true;
    Services.getSearchResponse(
            context,
            widget.searchParams.selectedItem.toLowerCase(),
            widget.searchParams.title,
            widget.searchParams.catId,
            widget.searchParams.minPrice,
            widget.searchParams.maxPrice,
            widget.searchParams.space,
            page)
        .then((value) => {
              searchResponse = value,
              setState(() {
                loading = false;
              }),
              widget.searchParams.title = "",
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateUI();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
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
                                controller: controller,
                                onSubmitted: (value) {
                                  setState(() {
                                    widget.searchParams.title = value;
                                    _updateUI();
                                    //widget.searchParams.title = "";
                                  });
                                },
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
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset('assets/icons/filter.svg')),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            if (page < searchResponse.lastPage) {
                              page++;
                              setState(() {
                                isLoading = true;
                              });
                              Services.getSearchResponse(
                                      context,
                                      widget.searchParams.selectedItem
                                          .toLowerCase(),
                                      widget.searchParams.title,
                                      widget.searchParams.catId,
                                      widget.searchParams.minPrice,
                                      widget.searchParams.maxPrice,
                                      widget.searchParams.space,
                                      page)
                                  .then((value) => {
                                        if (mounted)
                                          {
                                            searchResponse.data
                                                .addAll(value.data),
                                            setState(() {
                                              isLoading = false;
                                            }),
                                          }
                                      });
                            }
                          }
                          return true;
                        },
                        child: GridView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                    id: searchResponse.data[index].id,
                                    buy: widget.buy,
                                  );
                                }));
                              },
                              child: SearchResultCard(
                                propertyData: searchResponse.data[index],
                                buy: widget.buy,
                              ),
                            );
                          },
                          itemCount: searchResponse.data.length,
                        ),
                      ),
                    ),
                    isLoading
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
      ),
    );
  }
}
