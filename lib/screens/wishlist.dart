import 'package:aqar_bazar/screens/buy_details.dart';
import 'package:aqar_bazar/widgets/buy_rent_switch.dart';
import 'package:aqar_bazar/widgets/search_result_card.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/Models/wishlist_model.dart';
import 'package:flutter/material.dart';

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

  void onDelete(int id) {
    setState(() {
      loading = true;
    });
    Services.removeFromWishlist(id, context).then((value) => {
          if (value == 200)
            setState(() {
              _updateUI();
            }),
        });
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
    // TODO: implement initState
    super.initState();
    _updateUI();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            color: Color(0xfff6f6f6),
            width: width,
            height: height / 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wishlist",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
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
          preferredSize: Size.fromHeight(height / 7.8),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: isBuySelected && buyWishlist.length == 0
                    ? Center(
                        heightFactor: 25,
                        child: Text(
                          "You Haven't Added Any Items Yet",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : isRentSelected && rentWishlist.length == 0
                        ? Center(
                            heightFactor: 25,
                            child: Text(
                              "You Haven't Added Any Items Yet",
                              style: TextStyle(fontSize: 20),
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
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
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
                                            onDelete(isBuySelected
                                                ? buyWishlist[index].id
                                                : rentWishlist[index].id);
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
