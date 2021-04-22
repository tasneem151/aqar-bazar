import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/screens/agent_info.dart';
import 'package:aqar_bazar/screens/booking.dart';
import 'package:aqar_bazar/screens/reviews.dart';
import 'package:aqar_bazar/widgets/gallery_photo_view_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/Models/show_property.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:aqar_bazar/screens/map_sheet.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/Provider/date_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:html/parser.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BuyDetails extends StatefulWidget {
  final int id;
  final bool buy;

  const BuyDetails({this.id, this.buy});
  @override
  _BuyDetailsState createState() => _BuyDetailsState();
}

class _BuyDetailsState extends State<BuyDetails> {
  bool isFav;
  ShowProperty propDetails;
  bool isLoading;
  bool noWifi;

/*   double latitude = 37.759392;
  double longitude = -122.5107336;
  String title = 'Ocean Beach';
  int zoom = 18; */

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: propDetails.images,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  void updateUI() {
    noWifi = false;
    isLoading = true;
    Services.getShowProperty(widget.id, context).then((value) => {
          if (mounted)
            {
              setState(() => {
                    propDetails = value,
                    //print(propDetails.id),
                    isFav = propDetails.isFavorite,
                    propDetails == null ? noWifi = true : isLoading = false
                  }),
            },
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
    return SafeArea(
      child: Scaffold(
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
                  : Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                    SizeConfig.safeBlockVertical * 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 4.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  height: SizeConfig.safeBlockVertical * 50,
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          open(context, 0);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              image: DecorationImage(
                                                  image: propDetails
                                                              .mainImageUrl ==
                                                          "no_image"
                                                      ? AssetImage(
                                                          'assets/temp/prop1.png')
                                                      : CachedNetworkImageProvider(
                                                          kBaseUrl +
                                                              propDetails
                                                                  .mainImageUrl),
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                      Positioned(
                                        right: SizeConfig.safeBlockHorizontal *
                                            6.5,
                                        top: SizeConfig.safeBlockVertical * 3,
                                        child: Container(
                                          height: SizeConfig.safeBlockVertical *
                                              3.8,
                                          width:
                                              SizeConfig.safeBlockHorizontal *
                                                  15,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              propDetails.images.length == 0
                                                  ? "1 / 1"
                                                  : "1 / ${propDetails.images.length}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                /* fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    4.3, */
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          child: Center(
                                            child: AutoSizeText(
                                              widget.buy
                                                  ? Applocalizations.of(context)
                                                      .translate(
                                                          'Available for Purchase')
                                                  : Applocalizations.of(context)
                                                      .translate(
                                                          'Available for Rental'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      3.5),
                                              maxLines: 2,
                                              minFontSize: 8,
                                            ),
                                          ),
                                          width:
                                              SizeConfig.safeBlockHorizontal *
                                                  28,
                                          height: SizeConfig.safeBlockVertical *
                                              7.4,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(50),
                                                  topLeft:
                                                      Radius.circular(50))),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          child: Container(
                                            width:
                                                SizeConfig.safeBlockHorizontal *
                                                    25,
                                            height:
                                                SizeConfig.safeBlockVertical *
                                                    7.4,
                                            child: Center(
                                              child: isFav == null
                                                  ? Container()
                                                  : Icon(isFav
                                                      ? FontAwesomeIcons
                                                          .solidHeart
                                                      : FontAwesomeIcons.heart),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(50),
                                                    topLeft:
                                                        Radius.circular(50))),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              isFav = !isFav;
                                              isFav
                                                  ? Services.addToWishlist(
                                                      propDetails.id.toString(),
                                                      widget.buy
                                                          ? "buy"
                                                          : "rent",
                                                      context)
                                                  : Services.removeFromWishlist(
                                                      propDetails.id, context);
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.safeBlockHorizontal *
                                                    3),
                                        child: Text(
                                          propDetails.title,
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.safeBlockHorizontal *
                                                    5),
                                        child: InkWell(
                                          onTap: () => Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Reviews(
                                              prop: propDetails,
                                            );
                                          })),
                                          child: Container(
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  8,
                                              height: SizeConfig
                                                      .safeBlockHorizontal *
                                                  8,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [kButtonShadow],
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.white,
                                                      Colors.grey[300],
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    stops: [0.1, 1.0],
                                                  )),
                                              child: SvgPicture.asset(
                                                'assets/icons/testimonial.svg',
                                                fit: BoxFit.scaleDown,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  /* Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        propDetails.location == null
                                            ? "Couldn't find location"
                                            : propDetails.location,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ],
                                  ) */
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.safeBlockHorizontal * 3,
                                    vertical:
                                        SizeConfig.safeBlockVertical * 1.5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.withOpacity(0.3)),
                                  height: SizeConfig.safeBlockVertical * 20,
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.safeBlockHorizontal * 2,
                                      left: SizeConfig.safeBlockHorizontal * 2,
                                      right:
                                          SizeConfig.safeBlockHorizontal * 2),
                                  width: SizeConfig.screenWidth,
                                  child: SingleChildScrollView(
                                    child: Text(
                                        parse(propDetails.description)
                                            .documentElement
                                            .text,
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  4.5,
                                          color: Color(0xff707070),
                                        )),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.safeBlockHorizontal * 3),
                                    child: Container(
                                      height:
                                          SizeConfig.safeBlockVertical * 5.3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.black
                                                  .withOpacity(0.2))),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            SizeConfig.safeBlockHorizontal * 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              propDetails.props['rooms']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                  .safeBlockHorizontal,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.bed,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4.5,
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  6,
                                            ),
                                            Text(
                                              propDetails.props['parking']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                  .safeBlockHorizontal,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.car,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4.5,
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  6,
                                            ),
                                            Text(
                                              propDetails.props['bath_rooms']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                  .safeBlockHorizontal,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.shower,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4.5,
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4,
                                            ),
                                            Text(
                                              propDetails.area.toString() +
                                                  "m\u{00B2}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  2,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.rulerCombined,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4.5,
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4,
                                            ),
                                            InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        actionsPadding:
                                                            EdgeInsets.only(
                                                                right: 8),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                24.0,
                                                                15.0,
                                                                24.0,
                                                                0.0),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                        ),
                                                        title: Text(
                                                            Applocalizations
                                                                    .of(context)
                                                                .translate(
                                                                    "More Details"),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                        content: Container(
                                                          height: SizeConfig
                                                                  .safeBlockVertical *
                                                              20,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: SizeConfig
                                                                        .safeBlockVertical *
                                                                    5.3,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.2))),
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      SizeConfig
                                                                              .safeBlockHorizontal *
                                                                          2),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Text(
                                                                        propDetails
                                                                            .props['rooms']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .bed,
                                                                        size: SizeConfig.safeBlockHorizontal *
                                                                            4.5,
                                                                      ),
                                                                      SizedBox(
                                                                        width: SizeConfig
                                                                            .safeBlockHorizontal,
                                                                      ),
                                                                      Text(
                                                                        propDetails
                                                                            .props['parking']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .car,
                                                                        size: SizeConfig.safeBlockHorizontal *
                                                                            4.5,
                                                                      ),
                                                                      SizedBox(
                                                                        width: SizeConfig
                                                                            .safeBlockHorizontal,
                                                                      ),
                                                                      Text(
                                                                        propDetails
                                                                            .props['bath_rooms']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .shower,
                                                                        size: SizeConfig.safeBlockHorizontal *
                                                                            4.5,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                height: SizeConfig
                                                                        .safeBlockVertical *
                                                                    5.3,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.2))),
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      SizeConfig
                                                                              .safeBlockHorizontal *
                                                                          2),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Text(
                                                                        propDetails.area.toString() +
                                                                            "m\u{00B2}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .rulerCombined,
                                                                        size: SizeConfig.safeBlockHorizontal *
                                                                            4.5,
                                                                      ),
                                                                      SizedBox(
                                                                        width: SizeConfig
                                                                            .safeBlockHorizontal,
                                                                      ),
                                                                      Text(
                                                                        propDetails.props['gates'] ==
                                                                                1
                                                                            ? "Yes"
                                                                            : "N/A",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .dungeon,
                                                                        size: SizeConfig.safeBlockHorizontal *
                                                                            4.5,
                                                                      ),
                                                                      SizedBox(
                                                                        width: SizeConfig
                                                                            .safeBlockHorizontal,
                                                                      ),
                                                                      Text(
                                                                        propDetails.props['security'] ==
                                                                                1
                                                                            ? "Yes"
                                                                            : "N/A",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .shieldAlt,
                                                                        size: SizeConfig.safeBlockHorizontal *
                                                                            4.5,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                height: SizeConfig
                                                                        .safeBlockVertical *
                                                                    5.3,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.2))),
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      SizeConfig
                                                                              .safeBlockHorizontal *
                                                                          2),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Text(
                                                                        propDetails.props['cleaning'] ==
                                                                                1
                                                                            ? "Yes"
                                                                            : "N/A",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .broom,
                                                                        size: SizeConfig.safeBlockHorizontal *
                                                                            4.5,
                                                                      ),
                                                                      SizedBox(
                                                                        width: SizeConfig
                                                                            .safeBlockHorizontal,
                                                                      ),
                                                                      Text(
                                                                        propDetails.props['cctv'] ==
                                                                                1
                                                                            ? "Yes"
                                                                            : "N/A",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .video,
                                                                        size: SizeConfig.safeBlockHorizontal *
                                                                            4.5,
                                                                      ),
                                                                      SizedBox(
                                                                        width: SizeConfig
                                                                            .safeBlockHorizontal,
                                                                      ),
                                                                      Text(
                                                                        propDetails.props['view'] ==
                                                                                1
                                                                            ? "Yes"
                                                                            : "N/A",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .streetView,
                                                                        size: SizeConfig.safeBlockHorizontal *
                                                                            4.5,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          Container(
                                                              height: SizeConfig
                                                                      .safeBlockVertical *
                                                                  6,
                                                              width: SizeConfig
                                                                      .safeBlockHorizontal *
                                                                  75,
                                                              child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                        child:
                                                                            Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: Text(
                                                                            Applocalizations.of(context).translate("Close")),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18.0),
                                                                            side: BorderSide(color: Theme.of(context).primaryColor)),
                                                                      ),
                                                                    )),
                                                                  ]))
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Icon(Icons.more_horiz))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.safeBlockHorizontal * 2),
                                    child: InkWell(
                                      onTap: propDetails.lat == null
                                          ? () {}
                                          : () {
                                              MapsSheet.show(
                                                context: context,
                                                onMapTap: (map) {
                                                  map.showMarker(
                                                    coords: Coords(
                                                        double.parse(
                                                            propDetails.lat),
                                                        double.parse(
                                                            propDetails.lng)),
                                                    title: propDetails.title,
                                                    zoom: 18,
                                                  );
                                                },
                                              );
                                            },
                                      child: Container(
                                        height:
                                            SizeConfig.safeBlockVertical * 5,
                                        width: 40,
                                        child: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff21d8a2),
                                              Color(0xff015ca7),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [0.1, 1.0],
                                          ),
                                          boxShadow: [kButtonShadow],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return widget.buy
                                  ? AgentInfo(
                                      id: propDetails.id.toString(),
                                    )
                                  : ChangeNotifierProvider<DateProvider>(
                                      create: (_) => DateProvider(),
                                      child: Booking(
                                        prop: propDetails,
                                        payCycle: propDetails.payCycle,
                                        rentPrice: propDetails.rentPrice,
                                      ),
                                    );
                            })),
                            child: Container(
                              width: SizeConfig.safeBlockHorizontal * 42,
                              height: SizeConfig.safeBlockVertical * 7.4,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50))),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.safeBlockHorizontal * 3,
                                      top: SizeConfig.safeBlockVertical),
                                  child: AutoSizeText(
                                    widget.buy
                                        ? Applocalizations.of(context)
                                            .translate('Contact Agent')
                                        : Applocalizations.of(context)
                                            .translate('Book'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: widget.buy
                                            ? SizeConfig.safeBlockHorizontal * 4
                                            : SizeConfig.safeBlockHorizontal *
                                                5,
                                        fontWeight: FontWeight.bold),
                                    minFontSize: 12,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: SizeConfig.safeBlockHorizontal * 60,
                            height: SizeConfig.safeBlockVertical * 7.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left:
                                          SizeConfig.safeBlockHorizontal * 2.5,
                                      right:
                                          SizeConfig.safeBlockHorizontal * 2),
                                  width: SizeConfig.safeBlockHorizontal * 60,
                                  child: Center(
                                    child: AutoSizeText(
                                      widget.buy
                                          ? propDetails.purchasePrice + ' TL'
                                          : propDetails.rentPrice +
                                              " TL" +
                                              " / " +
                                              propDetails.payCycle,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  5.5,
                                          fontWeight: FontWeight.w500),
                                      minFontSize: 18,
                                      maxLines: 2,
                                      //overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
    );
  }
}
