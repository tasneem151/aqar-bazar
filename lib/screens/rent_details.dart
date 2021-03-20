import 'package:aqar_bazar/Models/featured.dart';
import 'package:aqar_bazar/screens/booking.dart';
import 'package:aqar_bazar/screens/reviews.dart';
import 'package:aqar_bazar/widgets/gallery_photo_view_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/Models/show_property.dart';
import 'package:aqar_bazar/networking/services.dart';

import '../constants.dart';

class RentDetails extends StatefulWidget {
  final int id;

  const RentDetails({this.id});
  @override
  _RentDetailsState createState() => _RentDetailsState();
}

class _RentDetailsState extends State<RentDetails> {
  bool isFav = false;
  ShowProperty propDetails;
  bool isLoading;
  String gates;
  String security;
  String cctv;
  String view;
  String cleaning;
  bool noWifi;

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

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Services.getShowProperty(widget.id, context).then((value) => {
          if (mounted)
            {
              setState(() => {
                    propDetails = value,
                    propDetails.props['gates'] == 1
                        ? gates = "Gates: Gates are available. \n"
                        : gates = "Gates: No Gates are available. \n",
                    propDetails.props['security'] == 1
                        ? security = "Security: Security is available. \n"
                        : security = "Security: No Security is available. \n",
                    propDetails.props['cctv'] == 1
                        ? cctv = "CCTV: CCTV is available. \n"
                        : cctv = "CCTV: No CCTV is available. \n",
                    propDetails.props['view'] == 1
                        ? view = "View: View is available. \n"
                        : view = "View: No View is available. \n",
                    propDetails.props['cleaning'] == 1
                        ? cleaning = "Cleaning: Cleaning is available. \n"
                        : cleaning = "Cleaning: No Cleaning is available. \n",
                    isLoading = false
                  }),
            },
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
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
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2,
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
                                              image: AssetImage(
                                                  'assets/temp/prop1.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'Available for Rental',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ),
                                        ),
                                      ),
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(50),
                                              topLeft: Radius.circular(50))),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        height: 60,
                                        child: Center(
                                          child: Icon(isFav
                                              ? FontAwesomeIcons.solidHeart
                                              : FontAwesomeIcons.heart),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(50),
                                                topLeft: Radius.circular(50))),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isFav = !isFav;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      propDetails.title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Reviews();
                                      })),
                                      child: Container(
                                          width: 30,
                                          height: 30,
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
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      propDetails.location,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 7,
                              child: SingleChildScrollView(
                                child: Text(
                                  gates +
                                      security +
                                      cctv +
                                      view +
                                      cleaning +
                                      propDetails.description,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff707070),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Colors.black.withOpacity(0.2))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          propDetails.props['rooms'].toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.bed,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          propDetails.props['parking']
                                              .toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.car,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          propDetails.props['bath_rooms']
                                              .toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.shower,
                                          size: 17,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          propDetails.area.toString() +
                                              "m\u{00B2}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.rulerCombined,
                                          size: 17,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  width:
                                      MediaQuery.of(context).size.width / 3.3,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "See in Map",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff21d8a2),
                                        Color(0xff015ca7),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.1, 1.0],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Booking();
                        })),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50))),
                          child: Center(
                              child: Text(
                            'Book',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              propDetails.rentPrice + " LE",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "/" + propDetails.payCycle,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
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
