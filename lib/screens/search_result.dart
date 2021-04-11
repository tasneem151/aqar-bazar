import 'package:aqar_bazar/Models/search_model.dart';
import 'package:aqar_bazar/Models/search_request_model.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/screens/buy_details.dart';
import 'package:aqar_bazar/widgets/search_result_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

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
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            height: SizeConfig.safeBlockVertical * 12,
            //width: width,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * 3),
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 77,
                    height: SizeConfig.safeBlockVertical * 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xffD8D8D8),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 2),
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
                            hintText: Applocalizations.of(context)
                                .translate("Property Name"),
                            hintStyle: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * 3),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/icons/filter.svg')),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(SizeConfig.safeBlockVertical * 20),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 2),
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
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}
