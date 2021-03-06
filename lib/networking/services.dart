import 'package:aqar_bazar/Manager/manager.dart';
import 'package:aqar_bazar/Models/for_purchase.dart';
import 'package:aqar_bazar/Models/for_rent.dart';
import 'package:aqar_bazar/Models/property_type.dart';
import 'package:aqar_bazar/Models/search_model.dart';
import 'package:aqar_bazar/Models/show_property.dart';
import 'package:aqar_bazar/Provider/modelsProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Services {
  static const String baseUrl = "http://new.aqarbazar.com/api/";

  static Future<ForPurchase> getForPurchase(BuildContext context) async {
    try {
      var response = await http.get(baseUrl + "property/purchase");
      var items = forPurchaseFromJson(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(items);
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return ForPurchase();
    }
  }

  static Future<ForRent> getForRent(BuildContext context) async {
    try {
      var response = await http.get(baseUrl + "property/rent");
      var items = forRentFromJson(response.body);

      if (response.statusCode == 200) {
        print(items);
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return ForRent();
    }
  }

  static Future<ShowProperty> getShowProperty(
      int id, BuildContext context) async {
    try {
      var response = await http.get(baseUrl + "property/$id");
      var items = showPropertyFromJson(response.body);

      if (response.statusCode == 200) {
        print(items);
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return ShowProperty();
    }
  }

  static Future<List<PropertyType>> getPropertyType(
      BuildContext context) async {
    try {
      var response = await http.get(baseUrl + "category/index");
      var items = propertyTypeFromJson(response.body);

      if (response.statusCode == 200) {
        print(items);
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<SearchResponse> getSearchResponse(
      BuildContext context,
      String operation,
      String title,
      String minPrice,
      String maxPrice,
      int area) async {
    try {
      var response = await http.get(baseUrl +
          "property/search?min_price=$minPrice&max_price=$maxPrice&area=$area&operation=$operation&title=$title");
      var items = searchResponseFromJson(response.body);

      if (response.statusCode == 200) {
        print(items.data.length);
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return SearchResponse();
    }
  }

  static Future<int> createAccount(String firstName, String lastName,
      String email, String password, String phone, BuildContext context) async {
    ////Checking Internet Access
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return 0;
    }

    try {
      var response = await http.post(baseUrl + "client/register", body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone": phone,
      });

      print(response.statusCode);

      switch (response.statusCode) {
        case 200:
          {
            var body = convert.json.decode(response.body);
            Manager.setAuthToken(body['token'], context);
            print(body['token']);
            return 200;
          }
        case 422:
          {
            Manager.toastMessage('Email or Phone Already Taken', Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage('Something Went Wrong', Colors.white);
            return 500;
          }
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> login(
      String email, String password, BuildContext context) async {
    ////Checking Internet Access
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return 0;
    }

    try {
      var response = await http.post(baseUrl + "client/login", body: {
        "email": email,
        "password": password,
      });

      print(response.statusCode);

      switch (response.statusCode) {
        case 200:
          {
            var body = convert.json.decode(response.body);
            Manager.setAuthToken(body['token'], context);
            print(body['token']);
            return 200;
          }
        case 422:
          {
            Manager.toastMessage('Wrong Email or Password', Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage('Something Went Wrong', Colors.white);
            return 500;
          }
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }
}

/* var streetsFromJson = parsedJson['streets'];
List<String> streetsList = new List<String>.from(streetsFromJson); */
