import 'package:aqar_bazar/Manager/manager.dart';
import 'package:aqar_bazar/Models/book_list.dart';
import 'package:aqar_bazar/Models/for_purchase.dart';
import 'package:aqar_bazar/Models/for_rent.dart';
import 'package:aqar_bazar/Models/get_notifications.dart';
import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:aqar_bazar/Models/property_type.dart';
import 'package:aqar_bazar/Models/search_model.dart';
import 'package:aqar_bazar/Models/show_property.dart';
import 'package:aqar_bazar/Provider/modelsProvider.dart';
import 'package:aqar_bazar/Models/get_comments.dart';
import 'package:aqar_bazar/Models/wishlist_model.dart';
import 'package:aqar_bazar/Models/book_response.dart';
import 'package:aqar_bazar/localization/app_language.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:aqar_bazar/Models/comment.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/Models/agent_info.dart';

class Services {
  static const String baseUrl = "https://aqarbazar.com/api/";

  static Future<ForPurchase> getForPurchase(BuildContext context) async {
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      //Manager.noConnectionAlert(context);
      return null;
    }
    try {
      var response = await http
          .get(baseUrl + "property/purchase", headers: {'locale': loc});
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      var response =
          await http.get(baseUrl + "property/rent", headers: {'locale': loc});
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
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
        'locale': loc,
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      //Manager.noConnectionAlert(context);
      return null;
    }

    try {
      var response =
          await http.get(baseUrl + "category/index", headers: {"locale": loc});
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
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
          'locale': loc,
        },
      );

      switch (response.statusCode) {
        case 200:
          {
            return 200;
          }
        case 422:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Invalid'),
                Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
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
        'locale': loc,
      }, body: {
        "property_id": id,
        "type": type,
      });

      switch (response.statusCode) {
        case 200:
          {
            return 200;
          }
        case 422:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Invalid'),
                Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
            return 500;
          }
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> cancelBooking(String id, BuildContext context) async {
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(
        baseUrl + "client/cancelBooking",
        headers: {
          'Authorization': 'Bearer ' + token,
          'locale': loc,
        },
        body: {
          "booking_id": id,
        },
      );

      switch (response.statusCode) {
        case 200:
          {
            return 200;
          }
        case 422:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Invalid'),
                Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
            return 500;
          }
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<List<BookedItemData>> getBookList(BuildContext context) async {
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.get(baseUrl + "client/bookings", headers: {
        'Authorization': 'Bearer ' + token,
        'locale': loc,
      });
      var items = bookListFromJson(response.body);

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

  static Future<List<WishlistModel>> getWishlist(BuildContext context) async {
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
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
        'locale': loc,
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    try {
      var response = await http.get(
          baseUrl +
              "property/search?min_price=$minPrice&max_price=$maxPrice&area=$area&operation=$operation&category=$catId&title=$title&page=$page",
          headers: {'locale': loc});
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.get(baseUrl + "user", headers: {
        'Authorization': 'Bearer ' + token,
        'locale': loc,
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }

    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/update", headers: {
        'Authorization': 'Bearer ' + token,
        'locale': loc,
      }, body: {
        "password": password,
      });

      switch (response.statusCode) {
        case 200:
          {
            Manager.toastMessage(
                Applocalizations.of(context)
                    .translate('Password Updated Successfully'),
                Colors.white);
            return 200;
          }
        case 422:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Invalid'),
                Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }

    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/checkOldPass", headers: {
        'Authorization': 'Bearer ' + token,
        'locale': loc,
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
            Manager.toastMessage(
                Applocalizations.of(context)
                    .translate('Old Password is Incorrect'),
                Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/update", headers: {
        'Authorization': 'Bearer ' + token,
        'locale': loc,
      }, body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
      });

      switch (response.statusCode) {
        case 200:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Updated Successfully'),
                Colors.white);
            return 200;
          }
        case 422:
          {
            Manager.toastMessage(
                Applocalizations.of(context)
                    .translate('Email or Phone Already Taken'),
                Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
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
        'locale': loc,
      }, body: {
        "property_id": id,
        "comment": comment
      });

      switch (response.statusCode) {
        case 200:
          {
            //Manager.toastMessage('Updated Successfully', Colors.white);
            return 200;
          }
        case 422:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }

    try {
      var response = await http
          .get(baseUrl + "property/$propId/comments", headers: {'locale': loc});
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
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
      }, headers: {
        'locale': loc
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
            Manager.toastMessage(
                Applocalizations.of(context)
                    .translate('Email or Phone Already Taken'),
                Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
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
      }, headers: {
        'locale': loc
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
            Manager.toastMessage(
                Applocalizations.of(context)
                    .translate('Wrong Email or Password'),
                Colors.white);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/addCard", headers: {
        'Authorization': 'Bearer ' + token,
        'locale': loc,
      }, body: {
        "number": ccNumber,
        "exp_month": expMonth,
        "exp_year": expYear,
        "cvc": cvc,
      });

      switch (response.statusCode) {
        case 200:
          {
            //Manager.toastMessage('Updated Successfully', Colors.white);
            return 200;
          }
        case 422:
          {
            Manager.alertDialog(
                Applocalizations.of(context)
                    .translate("Invalid Credit Card Info"),
                Applocalizations.of(context)
                    .translate("Please check your Credit Card Information"),
                context);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
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
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.post(baseUrl + "client/book", headers: {
        'Authorization': 'Bearer ' + token,
        'locale': loc,
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
            //Manager.toastMessage('Updated Successfully', Colors.white);
            return 200;
          }
        case 422:
          {
            result.errors == null
                ? Manager.alertDialog(
                    Applocalizations.of(context)
                        .translate("Invalid Date Range"),
                    Applocalizations.of(context).translate(result.message),
                    context)
                : Manager.alertDialog(
                    Applocalizations.of(context).translate(result.message),
                    Applocalizations.of(context)
                        .translate(result.errors.from.first),
                    context);
            return 422;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
            return 500;
          }
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<GetNotifications> getNotifications(BuildContext context) async {
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      String token = Provider.of<ModelsProvider>(context, listen: false).token;
      await Manager.getAuthToken().then((val) => {token = val});

      var response = await http.get(baseUrl + "client/notifications", headers: {
        'Authorization': 'Bearer ' + token,
        'locale': loc,
      });
      var items = getNotificationsFromJson(response.body);

      if (response.statusCode == 200) {
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return GetNotifications();
    }
  }

  static Future<Agent> getAgentInfo(BuildContext context, String propId) async {
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return null;
    }
    try {
      var response =
          await http.get(baseUrl + "property/$propId/getAgent", headers: {
        'locale': loc,
      });
      var items = agentInfoFromJson(response.body);

      if (response.statusCode == 200) {
        return items;
      } else {
        throw Exception('Error' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return Agent();
    }
  }

  static Future<int> contactUs(
      String title, String content, BuildContext context) async {
    String loc = Provider.of<AppLanguage>(context, listen: false).getlang();
    ////Checking Internet Access
    Manager.checkInternet(context);
    if (!Provider.of<ModelsProvider>(context, listen: false).internetAccess) {
      Manager.noConnectionAlert(context);
      return 0;
    }

    try {
      var response = await http.post(baseUrl + "client/contactUs", body: {
        "title": title,
        "content": content,
      }, headers: {
        'locale': loc
      });

      print(response.statusCode);

      switch (response.statusCode) {
        case 200:
          {
            Manager.toastMessage(
                Applocalizations.of(context)
                    .translate('Your message has been sent'),
                Colors.white);
            return 200;
          }
        default:
          {
            Manager.toastMessage(
                Applocalizations.of(context).translate('Something Went Wrong'),
                Colors.white);
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
