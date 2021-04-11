import 'dart:ui';
import 'package:aqar_bazar/Models/search_request_model.dart';
import 'package:aqar_bazar/screens/search_result.dart';
import 'package:aqar_bazar/widgets/search_card_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/Models/property_type.dart';
import 'package:validators/validators.dart' as validator;
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class Search extends StatefulWidget {
  final List<PropertyType> propType;

  const Search({this.propType});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchRequestModel searchParams = SearchRequestModel();
  bool loading;
  int selsectedIndex;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    searchParams.selectedItem = "purchase";
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<DropdownMenuItem> dropDownItems = [
      DropdownMenuItem(
        child: Text(Applocalizations.of(context).translate("Purchase")),
        value: "purchase",
      ),
      DropdownMenuItem(
        child: Text(Applocalizations.of(context).translate("Rent")),
        value: "rent",
      )
    ];
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.safeBlockHorizontal * 5,
                      SizeConfig.safeBlockVertical * 4.5,
                      SizeConfig.safeBlockHorizontal * 5,
                      0),
                  child: Container(
                    height: SizeConfig.safeBlockVertical * 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xffD8D8D8),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 2,
                            right: SizeConfig.safeBlockHorizontal * 2),
                        child: TextField(
                          onSubmitted: (value) {
                            searchParams.title = value;
                            print(value);
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
                      horizontal: SizeConfig.safeBlockHorizontal * 5,
                      vertical: SizeConfig.safeBlockVertical * 3),
                  child: Text(
                    Applocalizations.of(context).translate('Type'),
                    style:
                        TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 6),
                  ),
                ),
                Container(
                  height: SizeConfig.safeBlockVertical * 20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selsectedIndex != index) {
                              selsectedIndex = index;
                              searchParams.catId =
                                  widget.propType[selsectedIndex].id;
                            } else {
                              selsectedIndex = null;
                              searchParams.catId = 0;
                            }
                          });
                        },
                        child: SearchCardFilter(
                          typeProperty: widget.propType[index],
                          isChecked: selsectedIndex == index ? true : false,
                        ),
                      );
                    },
                    itemCount: widget.propType.length,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal * 5),
                      child: Column(
                        children: [
                          Text(
                            Applocalizations.of(context).translate('Min Price'),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal * 2,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.safeBlockHorizontal * 2.5,
                                vertical: 2),
                            width: SizeConfig.safeBlockHorizontal * 32,
                            height: SizeConfig.safeBlockVertical * 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      offset: Offset(1, 3),
                                      blurRadius: 6),
                                ],
                                color: Colors.white),
                            child: TextFormField(
                              validator: (String value) {
                                if (!validator.isNumeric(value) &&
                                    !validator.isNull(value)) {
                                  return Applocalizations.of(context)
                                      .translate('Invalid');
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                searchParams.minPrice = value;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  suffixIcon: Text('LE',
                                      style: TextStyle(
                                        color: Color(0xff015ca7),
                                      )),
                                  suffixIconConstraints: BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal * 5),
                      child: Column(
                        children: [
                          Text(
                            Applocalizations.of(context).translate('Max Price'),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal * 2,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.safeBlockHorizontal * 2.5,
                                vertical: 3),
                            width: SizeConfig.safeBlockHorizontal * 32,
                            height: SizeConfig.safeBlockVertical * 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      offset: Offset(1, 3),
                                      blurRadius: 6),
                                ],
                                color: Colors.white),
                            child: TextFormField(
                              validator: (String value) {
                                if (!validator.isNumeric(value) &&
                                    !validator.isNull(value)) {
                                  return Applocalizations.of(context)
                                      .translate('Invalid');
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                searchParams.maxPrice = value;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  suffixIcon: Text('LE',
                                      style: TextStyle(
                                        color: Color(0xff015ca7),
                                      )),
                                  suffixIconConstraints: BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal * 5),
                      child: Column(
                        children: [
                          Text(
                            Applocalizations.of(context)
                                .translate('Square Space'),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal * 2,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.safeBlockHorizontal * 2.5,
                                vertical: 3),
                            width: SizeConfig.safeBlockHorizontal * 32,
                            height: SizeConfig.safeBlockVertical * 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      offset: Offset(1, 3),
                                      blurRadius: 6),
                                ],
                                color: Colors.white),
                            child: TextFormField(
                              validator: (String value) {
                                if (!validator.isNumeric(value) &&
                                    !validator.isNull(value)) {
                                  return Applocalizations.of(context)
                                      .translate("Invalid");
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                searchParams.space = int.parse(value);
                                print(searchParams.space);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  suffixIcon: Text("m\u{00B2}",
                                      style: TextStyle(
                                        color: Color(0xff015ca7),
                                      )),
                                  suffixIconConstraints: BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal * 5),
                      child: Column(
                        children: [
                          Text(
                            Applocalizations.of(context)
                                .translate('Ownership Type'),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal * 2,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.safeBlockHorizontal * 2.5,
                                vertical: 3),
                            width: SizeConfig.safeBlockHorizontal * 34,
                            height: SizeConfig.safeBlockVertical * 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      offset: Offset(1, 3),
                                      blurRadius: 6),
                                ],
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: searchParams.selectedItem,
                                style: TextStyle(
                                  color: Color(0xff015ca7),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xff015ca7),
                                  size: 30,
                                ),
                                items: dropDownItems,
                                onChanged: (value) {
                                  setState(() {
                                    searchParams.selectedItem = value;
                                    print(searchParams.selectedItem);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 12,
                ),
                Center(
                  child: loading
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchResult(
                                  searchParams: searchParams,
                                  buy: searchParams.selectedItem == "purchase"
                                      ? true
                                      : false,
                                );
                              }));
                            }
                          },
                          child: Container(
                            height: SizeConfig.safeBlockVertical * 6,
                            width: SizeConfig.safeBlockHorizontal * 47,
                            child: Center(
                              child: Text(
                                Applocalizations.of(context)
                                    .translate("Search"),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff4e89c7),
                                  Color(0xff21d8a2),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.1, 1.0],
                              ),
                            ),
                          ),
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

//(min + (max - min) * value).round().toString();
//(value * 10).round().toString();
