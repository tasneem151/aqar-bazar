import 'package:aqar_bazar/Models/for_purchase.dart';
import 'package:aqar_bazar/Models/for_rent.dart';
import 'package:aqar_bazar/Models/property_type.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/screens/profile.dart';
import 'package:aqar_bazar/screens/rent_details.dart';
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
import 'package:aqar_bazar/Manager/manager.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/Provider/modelsProvider.dart';

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
              if (isRentSelected)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RentDetails(
                        id: i.id,
                      );
                    },
                  ),
                );
              if (isBuySelected)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BuyDetails(
                        id: i.id,
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

  @override
  void initState() {
    super.initState();
    isLoading = true;
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
                          setState(
                              () => {forRentProp = value, isLoading = false}),
                        }
                    })
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        drawer: SideDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 9),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            color: Color(0xfff6f6f6),
            width: width,
            height: height / 9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: SvgPicture.asset('assets/icons/Layout-Arrange.svg'),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                BuyRentSwitch(
                  isRentSelected: isRentSelected,
                  isBuySelected: isBuySelected,
                  onBuySwitch: onBuySwitchCallback,
                  onRentSwitch: onRentSwitchCallback,
                ),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return Profile();
                  })),
                  child: Container(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/temp/user.png'),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 0,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 5,
                          child: Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isLoading
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
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('Find your location &'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Explore',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Where you want to go?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.search,
                                    color: Color(0xff707070),
                                  ),
                                ],
                              ),
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
                          'Featured Properties',
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
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            height: MediaQuery.of(context).size.height / 3),
                        items: isBuySelected
                            ? buildItems(width, forPurchaseProp.featured)
                            : buildItems(width, forRentProp.featured),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 25, bottom: 10, left: 20, right: 20),
                        child: Text(
                          'Latest Properties',
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
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
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
