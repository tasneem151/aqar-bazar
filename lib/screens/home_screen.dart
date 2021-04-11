import 'package:aqar_bazar/Models/for_purchase.dart';
import 'package:aqar_bazar/Models/for_rent.dart';
import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:aqar_bazar/Models/property_type.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/widgets/feature_card.dart';
import 'package:aqar_bazar/widgets/buy_rent_switch.dart';
import 'package:aqar_bazar/widgets/explore_card.dart';
import 'package:aqar_bazar/widgets/side_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/screens/buy_details.dart';
import 'package:aqar_bazar/screens/search.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBuySelected = true;
  bool isRentSelected = false;

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

  List<Widget> buildItems(double width, Iterable<dynamic> t) {
    return t.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return InkWell(
            child: FeatureCard(
              property: i,
              width: width,
              shadow: BoxShadow(
                color: Colors.grey[500],
                offset: Offset(2.0, 2.0), //(x,y)
                blurRadius: 6.0,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BuyDetails(
                      id: i.id,
                      buy: isBuySelected,
                    );
                  },
                ),
              );
            },
          );
        },
      );
    }).toList();
  }

  bool isLoading;
  ForPurchase forPurchaseProp;
  ForRent forRentProp;
  List<PropertyType> propType;
  bool noWifi;
  ProfileInfo user;

  void updateUI() {
    isLoading = true;
    noWifi = false;
    Services.getUserInfo(context).then((value) => {
          if (mounted)
            {
              setState(() => {user = value}),
            },
          Services.getPropertyType(context).then((value) => {
                if (mounted)
                  {
                    setState(() => {propType = value}),
                  },
                Services.getForPurchase(context).then((value) => {
                      if (mounted)
                        {
                          setState(() => {forPurchaseProp = value}),
                        },
                      Services.getForRent(context).then((value) => {
                            if (mounted)
                              {
                                setState(() => {
                                      forRentProp = value,
                                      forRentProp == null
                                          ? noWifi = true
                                          : isLoading = false
                                    }),
                              }
                          })
                    })
              })
        });
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        drawer: SideDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.safeBlockVertical * 30),
          child: Container(
            color: Color(0xfff6f6f6),
            width: width,
            height: SizeConfig.safeBlockVertical * 13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 1.5),
                    child: IconButton(
                      icon: SvgPicture.asset('assets/icons/Layout-Arrange.svg'),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
                BuyRentSwitch(
                  isRentSelected: isRentSelected,
                  isBuySelected: isBuySelected,
                  onBuySwitch: onBuySwitchCallback,
                  onRentSwitch: onRentSwitchCallback,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * 3),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: SizeConfig.safeBlockVertical * 6,
                      width: SizeConfig.safeBlockVertical * 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xff21d8a2),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/bell-large.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: noWifi
            ? Center(
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.refresh,
                      size: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        updateUI();
                      });
                    }),
              )
            : isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(Applocalizations.of(context)
                                .translate('Find Your Next Home')),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              Applocalizations.of(context).translate('Explore'),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: InkWell(
                              onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Search(
                                  propType: propType,
                                );
                              })),
                              child: Container(
                                width: width - 20,
                                height: height / 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Color(0xffD8D8D8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                          SizeConfig.safeBlockHorizontal * 2),
                                      child: Text(
                                        Applocalizations.of(context)
                                            .translate('Search'),
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  4,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          SizeConfig.safeBlockHorizontal * 3),
                                      child: Icon(
                                        CupertinoIcons.search,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                return ExploreCard(
                                  buy: isBuySelected,
                                  typeProperty: propType[index],
                                );
                              },
                              itemCount: propType.length,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 25, bottom: 10, left: 20, right: 20),
                            child: Text(
                              Applocalizations.of(context)
                                  .translate('Featured Properties'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                                enableInfiniteScroll: true,
                                pageSnapping: false,
                                viewportFraction: 0.6,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                height: MediaQuery.of(context).size.height / 3),
                            items: isBuySelected
                                ? buildItems(width, forPurchaseProp.featured)
                                : buildItems(width, forRentProp.featured),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 25, bottom: 10, left: 20, right: 20),
                            child: Text(
                              Applocalizations.of(context)
                                  .translate('Latest Properties'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                                pageSnapping: false,
                                enableInfiniteScroll: true,
                                viewportFraction: 0.6,
                                enlargeCenterPage: true,
                                //disableCenter: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                height: MediaQuery.of(context).size.height / 3),
                            items: isBuySelected
                                ? buildItems(width, forPurchaseProp.latest)
                                : buildItems(width, forRentProp.latest),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
