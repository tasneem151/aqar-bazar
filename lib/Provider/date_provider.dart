import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  String _startDate = "";
  String _endDate = "";
  String _ccNumber = "";
  String _cvc = "";
  String _month = "";
  String _year = "";

  void setStartDate(String start) {
    _startDate = start;
    notifyListeners();
  }

  String getStartDate() {
    return _startDate;
  }

  void setEndDate(String end) {
    _endDate = end;
    notifyListeners();
  }

  String getEndDate() {
    return _endDate;
  }

  void setCCNumber(String cc) {
    _ccNumber = cc;
    notifyListeners();
  }

  void setCVCNumber(String cvv) {
    _cvc = cvv;
    notifyListeners();
  }

  void setMonth(String month) {
    _month = month;
    notifyListeners();
  }

  void setYear(String year) {
    _year = year;
    notifyListeners();
  }

  String getCCNumber() {
    return _ccNumber;
  }

  String getCVCNumber() {
    return _cvc;
  }

  String getMonth() {
    return _month;
  }

  String getYear() {
    return _year;
  }
}
