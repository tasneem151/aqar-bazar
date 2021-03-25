import 'package:aqar_bazar/Manager/manager.dart';
import 'package:aqar_bazar/Models/for_purchase.dart';
import 'package:aqar_bazar/Models/for_rent.dart';
import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:aqar_bazar/Models/property_type.dart';
import 'package:aqar_bazar/Models/search_model.dart';
import 'package:aqar_bazar/Models/show_property.dart';
import 'package:aqar_bazar/Provider/modelsProvider.dart';
import 'package:aqar_bazar/Models/get_comments.dart';
import 'package:aqar_bazar/Models/wishlist_model.dart';
import 'package:aqar_bazar/Models/book_response.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:aqar_bazar/Models/comment.dart';

class Services {
  static const String baseUrl = "http://new.aqarbazar.com/api/";

  static Future<ForPurchase> getForPurchase(BuildContext context) async {
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      //Manager.noConnectionAlert(context);
      return null;
    }
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
      return null;
    }
  }

  static Future<ForRent> getForRent(BuildContext context) async {
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
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
      return null;
    }
  }

  static Future<ShowProperty> getShowProperty(
      int id, BuildContext context) async {
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.get(baseUrl + "property/$id", headers: {
        'Authorization': 'Bearer ' + token,
      });
      var items = showPropertyFromJson(response.body);

      if (response.statusCode == 200) {
        print(items);
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<PropertyType>> getPropertyType(
      BuildContext context) async {
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      //Manager.noConnectionAlert(context);
      return null;
    }
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

  static Future<int> removeFromWishlist(int id, BuildContext context) async {
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(
        baseUrl + "client/wishList/delete/$id",
        headers: {
          'Authorization': 'Bearer ' + token,
        },
      );

      switch (response.statusCode) {
        case 200:
          {
            //Manager.toastMessage('Item Added Succesfuly', Colors.white);
            return 200;
          }
        case 422:
          {
            //Manager.toastMessage('Invalid', Colors.white);
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

  static Future<int> addToWishlist(
      String id, String type, BuildContext context) async {
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response =
          await http.post(baseUrl + "client/wishList/save", headers: {
        'Authorization': 'Bearer ' + token,
      }, body: {
        "property_id": id,
        "type": type,
      });

      switch (response.statusCode) {
        case 200:
          {
            Manager.toastMessage('Item Added Succesfuly', Colors.white);
            return 200;
          }
        case 422:
          {
            Manager.toastMessage('Invalid', Colors.white);
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

  static Future<List<WishlistModel>> getWishlist(BuildContext context) async {
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response =
          await http.get(baseUrl + "client/wishList/index", headers: {
        'Authorization': 'Bearer ' + token,
      });
      var items = wishlistFromJson(response.body);

      if (response.statusCode == 200) {
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  /*  static Future<SearchResponse> nextSearchPage(
      BuildContext context, String url) async {
    try {
      var response = await http.get(url);
      var items = searchResponseFromJson(response.body);

      if (response.statusCode == 200) {
        //print(items.data.length);
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }

    } catch (e) {
      print(e);
      return SearchResponse();
    }
  } */

  static Future<SearchResponse> getSearchResponse(
    BuildContext context,
    String operation,
    String title,
    int catId,
    String minPrice,
    String maxPrice,
    int area,
    int page,
  ) async {
    try {
      var response = await http.get(baseUrl +
          "property/search?min_price=$minPrice&max_price=$maxPrice&area=$area&operation=$operation&category=$catId&title=$title&page=$page");
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

  static Future<ProfileInfo> getUserInfo(BuildContext context) async {
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.get(baseUrl + "user", headers: {
        'Authorization': 'Bearer ' + token,
      });

      if (response.statusCode == 200) {
        var result = ProfileInfo.fromJson(convert.jsonDecode(response.body));
        Provider.of<ModelsProvider>(context, listen: false).setUserInfo(result);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<int> updatePassword(
      String password, BuildContext context) async {
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }

    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/update", headers: {
        'Authorization': 'Bearer ' + token,
      }, body: {
        "password": password,
      });

      switch (response.statusCode) {
        case 200:
          {
            Manager.toastMessage('Password Updated Succesfuly', Colors.white);
            return 200;
          }
        case 422:
          {
            Manager.toastMessage('Invalid Input', Colors.white);
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
      return null;
    }
  }

  static Future<int> checkOldPassword(
      String password, BuildContext context) async {
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }

    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/checkOldPass", headers: {
        'Authorization': 'Bearer ' + token,
      }, body: {
        "password": password,
      });

      switch (response.statusCode) {
        case 200:
          {
            //Manager.toastMessage('', Colors.white);
            return 200;
          }
        case 422:
          {
            Manager.toastMessage('Old Password is Incorrect', Colors.white);
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
      return null;
    }
  }

  static Future<int> updateUserInfo(String firstName, String lastName,
      String email, String phone, BuildContext context) async {
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/update", headers: {
        'Authorization': 'Bearer ' + token,
      }, body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
      });

      switch (response.statusCode) {
        case 200:
          {
            getUserInfo(context);
            Manager.toastMessage('Updated Succesfuly', Colors.white);
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
      return null;
    }
  }

  static Future<int> writeComment(
      String id, String comment, BuildContext context) async {
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return 0;
    }

    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/comment", headers: {
        'Authorization': 'Bearer ' + token,
      }, body: {
        "property_id": id,
        "comment": comment
      });

      switch (response.statusCode) {
        case 200:
          {
            //Manager.toastMessage('Updated Succesfuly', Colors.white);
            return 200;
          }
        case 422:
          {
            Manager.toastMessage('Something Went Wrong', Colors.white);
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

  static Future<List<Comment>> getComments(
      int propId, BuildContext context) async {
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }

    try {
      var response = await http.get(baseUrl + "property/$propId/comments");
      var result = getCommentsFromJson(response.body);

      if (response.statusCode == 200) {
        print(result.length);
        return result;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return null;
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
            var result = convert.json.decode(response.body);
            Manager.setAuthToken(result['token'], context);
            Manager.getAuthToken().then((value) => print(value));
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

  static Future<int> addCard(String ccNumber, String expMonth, String expYear,
      String cvc, BuildContext context) async {
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/addCard", headers: {
        'Authorization': 'Bearer ' + token,
      }, body: {
        "number": ccNumber,
        "exp_month": expMonth,
        "exp_year": expYear,
        "cvc": cvc,
      });

      switch (response.statusCode) {
        case 200:
          {
            //Manager.toastMessage('Updated Succesfuly', Colors.white);
            return 200;
          }
        case 422:
          {
            Manager.alertDialog("Invalid Credit Card Info",
                "Please check your Credit Card Information.", context);
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
      return null;
    }
  }

  static Future<int> bookProperty(
      String propId,
      String startDate,
      String endDate,
      String payCycle,
      String rentPrice,
      BuildContext context) async {
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/book", headers: {
        'Authorization': 'Bearer ' + token,
      }, body: {
        "property_id": propId,
        "from": startDate,
        "to": endDate,
        "pay_cycle": payCycle,
        "rent_price": rentPrice,
      });

      var result = bookResponseFromJson(response.body);

      switch (response.statusCode) {
        case 200:
          {
            //Manager.toastMessage('Updated Succesfuly', Colors.white);
            return 200;
          }
        case 422:
          {
            result.errors == null
                ? Manager.alertDialog(
                    "Invalid Date Range", result.message, context)
                : Manager.alertDialog(
                    result.message,
                    result.errors.from.first ??= result.errors.to.first,
                    context);
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
      return null;
    }
  }
}

/* var streetsFromJson = parsedJson['streets'];
List<String> streetsList = new List<String>.from(streetsFromJson); */
