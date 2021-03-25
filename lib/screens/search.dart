import 'dart:ui';
import 'package:aqar_bazar/Models/search_model.dart';
import 'package:aqar_bazar/Models/search_request_model.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/screens/search_result.dart';
import 'package:aqar_bazar/widgets/search_card_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/Models/property_type.dart';
import 'package:validators/validators.dart' as validator;
import 'package:aqar_bazar/Manager/manager.dart';

class Search extends StatefulWidget {
  final List<PropertyType> propType;

  const Search({Key key, this.propType}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  /* String title = "";
  String minPrice = "";
  String maxPrice = "";
  int space;
  int catId = 0;
  String selectedItem; */

  SearchRequestModel searchParams = SearchRequestModel();
  bool loading;
  int selsectedIndex;

  List<String> dropDownItems = [
    "Purchase",
    "Rent",
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    searchParams.selectedItem = dropDownItems[0];
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: width - 20,
                      height: height / 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Color(0xffD8D8D8),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextField(
                            onSubmitted: (value) {
                              searchParams.title = value;
                              print(value);
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Type',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: width / 3,
                    width: width,
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
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Min. Price',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              width: width / 3.2,
                              height: width / 8,
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
                                    return '* invalid entry';
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
                        Column(
                          children: [
                            Text(
                              'Max. Price',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              width: width / 3.2,
                              height: width / 8,
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
                                    return '* invalid entry';
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Square Space',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              width: width / 3.2,
                              height: width / 8,
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
                                    return "* invalid entry";
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
                        Column(
                          children: [
                            Text(
                              'Ownership Type',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              width: width / 3.2,
                              height: width / 8,
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
                                  items: dropDownItems
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      searchParams.selectedItem = newValue;
                                      print(searchParams.selectedItem
                                          .toLowerCase());
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
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
                                    buy: searchParams.selectedItem == "Purchase"
                                        ? true
                                        : false,
                                  );
                                }));
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 18,
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Center(
                                child: Text(
                                  "Search",
                                  style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}

//(min + (max - min) * value).round().toString();
//(value * 10).round().toString();
