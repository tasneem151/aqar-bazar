import 'package:aqar_bazar/screens/buy_details.dart';
import 'package:aqar_bazar/widgets/buy_rent_switch.dart';
import 'package:aqar_bazar/widgets/search_result_card.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/Models/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  bool isBuySelected = true;
  bool isRentSelected = false;
  List<WishlistModel> wishlist;
  List<WishlistModel> buyWishlist;
  List<WishlistModel> rentWishlist;
  bool loading;

  void onBuySwitchCallback() {
    setState(() {
      isBuySelected = true;
      isRentSelected = false;
    });
  }

  void onRentSwitchCallback() {
    setState(() {
      isBuySelected = false;
      isRentSelected = true;
    });
  }

  void onDelete(int id, int indx, bool buy) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(right: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Text(
              Applocalizations.of(context).translate("Remove From Wishlist"),
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Text(
              Applocalizations.of(context).translate(
                  "Are You Sure You Want to Remove this Item From Your Wishlist?"),
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).accentColor)),
          actions: <Widget>[
            Container(
                height: SizeConfig.safeBlockVertical * 6,
                width: SizeConfig.safeBlockHorizontal * 75,
                child: Row(children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          buy
                              ? buyWishlist.removeAt(indx)
                              : rentWishlist.removeAt(indx);
                        });
                        Services.removeFromWishlist(id, context)
                            .then((value) => {});
                        Navigator.of(context).pop();
                      },
                      child:
                          Text(Applocalizations.of(context).translate("Yes")),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(Applocalizations.of(context).translate("No")),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    ),
                  )),
                ]))
          ],
        );
      },
    );
  }

  void _updateUI() {
    loading = true;
    buyWishlist = [];
    rentWishlist = [];
    Services.getWishlist(context).then((value) => {
          if (mounted)
            {
              setState(() {
                //print(value.length);
                wishlist = value;
                for (int i = 0; i < wishlist.length; i++) {
                  if (wishlist[i].type == "rent")
                    rentWishlist.add(wishlist[i]);
                  else
                    buyWishlist.add(wishlist[i]);
                }
                loading = false;
              })
            }
        });
  }

  @override
  void initState() {
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
            color: Color(0xfff6f6f6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal * 3,
                    vertical: SizeConfig.safeBlockVertical * 2,
                  ),
                  child: Text(
                    Applocalizations.of(context).translate("Wishlist"),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.safeBlockHorizontal * 5.2),
                  ),
                ),
                Center(
                  child: BuyRentSwitch(
                    isRentSelected: isRentSelected,
                    isBuySelected: isBuySelected,
                    onBuySwitch: onBuySwitchCallback,
                    onRentSwitch: onRentSwitchCallback,
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(SizeConfig.safeBlockVertical * 19),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal),
                child: isBuySelected && buyWishlist.length == 0
                    ? Center(
                        heightFactor: SizeConfig.safeBlockVertical * 3.5,
                        child: Text(
                          Applocalizations.of(context)
                              .translate("You Haven't Added Any Items Yet"),
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 5),
                        ),
                      )
                    : isRentSelected && rentWishlist.length == 0
                        ? Center(
                            heightFactor: SizeConfig.safeBlockVertical * 3.5,
                            child: Text(
                              Applocalizations.of(context)
                                  .translate("You Haven't Added Any Items Yet"),
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: GridView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing:
                                                SizeConfig.safeBlockHorizontal *
                                                    2.5,
                                            mainAxisSpacing:
                                                SizeConfig.safeBlockHorizontal *
                                                    2.5,
                                            childAspectRatio: 2 / 3),
                                    itemBuilder: (BuildContext context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return BuyDetails(
                                              id: isBuySelected
                                                  ? buyWishlist[index]
                                                      .propertyId
                                                  : rentWishlist[index]
                                                      .propertyId,
                                              buy: isBuySelected,
                                            );
                                          }));
                                        },
                                        child: SearchResultCard(
                                          wishlistItem: true,
                                          buy: isBuySelected,
                                          propertyData: isBuySelected
                                              ? buyWishlist[index].property
                                              : rentWishlist[index].property,
                                          onDelete: () {
                                            onDelete(
                                                isBuySelected
                                                    ? buyWishlist[index]
                                                        .propertyId
                                                    : rentWishlist[index]
                                                        .propertyId,
                                                index,
                                                isBuySelected);
                                          },
                                        ),
                                      );
                                    },
                                    itemCount: isBuySelected
                                        ? buyWishlist.length
                                        : rentWishlist.length,
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
