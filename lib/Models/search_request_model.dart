import 'package:flutter/cupertino.dart';

class SearchRequestModel {
  String title;
  String minPrice;
  String maxPrice;
  int space;
  /* bool loading;
  int selsectedIndex; */
  int catId;
  String selectedItem;

  SearchRequestModel(
      {this.title = "",
      this.minPrice = "",
      this.maxPrice = "",
      this.space,
      this.catId = 0,
      this.selectedItem = "Purchase"});
}
