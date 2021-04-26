import 'package:aqar_bazar/Provider/date_provider.dart';
import 'package:aqar_bazar/localization/app_language.dart';
import 'package:aqar_bazar/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/widgets/date_range_card.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/Models/show_property.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class Booking extends StatefulWidget {
  final ShowProperty prop;
  final String payCycle;
  final String rentPrice;

  const Booking({this.prop, this.payCycle, this.rentPrice});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool isActive = true;
  String startDate;
  String endDate;
  String ccNumber;
  String cvc;
  String month;
  String year;
  bool loading = false;
  String lang;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    switch (_currentPage) {
      case 0:
        {
          list.add(enabled[0]);
          list.add(_divider(false));
          list.add(disabled[1]);
          list.add(_divider(false));
          list.add(disabled[2]);
          break;
        }
      case 1:
        {
          list.add(enabled[0]);
          list.add(_divider(true));
          list.add(enabled[1]);
          list.add(_divider(false));
          list.add(disabled[2]);
          break;
        }
      case 2:
        {
          list.add(enabled[0]);
          list.add(_divider(true));
          list.add(enabled[1]);
          list.add(_divider(true));
          list.add(enabled[2]);
        }
    }
    return list;
  }

  List<Widget> enabled = [
    SvgPicture.asset('assets/icons/credit-card colored.svg'),
    SvgPicture.asset('assets/icons/calendar.svg'),
    SvgPicture.asset('assets/icons/key colored.svg'),
  ];

  List<Widget> disabled = [
    SvgPicture.asset('assets/icons/credit-card colored.svg'),
    SvgPicture.asset('assets/icons/calendar-uncolored2.svg'),
    SvgPicture.asset('assets/icons/key.svg'),
  ];

  Container _divider(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 1.0,
      width: 80.0,
      color: isActive ? Colors.blue : Colors.grey.shade400,
    );
  }

  void nextStep() {
    setState(() {
      loading = true;
    });
    if (_pageController.page == 0) {
      Services.addCard(ccNumber, month, year, cvc, context).then((value) => {
            if (value == 200)
              {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
              },
            setState(() {
              loading = false;
            }),
          });
    } else if (_pageController.page == 1) {
      Services.bookProperty(widget.prop.id.toString(), startDate, endDate,
              widget.payCycle, widget.rentPrice, context)
          .then((value) => {
                if (value == 200)
                  {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    ),
                  },
                setState(() {
                  loading = false;
                }),
              });
    }
  }

  void previousStep() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void cancel() {
    Navigator.pop(context);
  }

  void backToHome() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    startDate = Provider.of<DateProvider>(context).getStartDate();
    endDate = Provider.of<DateProvider>(context).getEndDate();
    ccNumber = Provider.of<DateProvider>(context).getCCNumber();
    cvc = Provider.of<DateProvider>(context).getCVCNumber();
    month = Provider.of<DateProvider>(context).getMonth();
    year = Provider.of<DateProvider>(context).getYear();
    lang = Provider.of<AppLanguage>(context, listen: false).getlang();

    return SafeArea(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment:
                        lang != 'ar' ? Alignment.topLeft : Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal * 2.5,
                          right: SizeConfig.safeBlockHorizontal * 2.5,
                          top: SizeConfig.safeBlockVertical * 2),
                      child: Text(
                        Applocalizations.of(context)
                            .translate('Renting Details For'),
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 5.7),
                      ),
                    ),
                  ),
                  Align(
                    alignment:
                        lang != 'ar' ? Alignment.topLeft : Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal * 2.5),
                      child: Text(
                        widget.prop.title,
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 5.7),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal),
                    child: Container(
                      height: SizeConfig.safeBlockVertical * 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                    ),
                  ),
                  Container(
                    height: SizeConfig.safeBlockVertical * 60,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        Column(
                          children: [
                            Text(
                              Applocalizations.of(context).translate("Payment"),
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 6.5),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 1.5,
                            ),
                            Center(
                              child: PaymentCard(),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              Applocalizations.of(context)
                                  .translate("Pick A Date"),
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 6.5),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 1.5,
                            ),
                            Center(
                              child: DateRangeCard(),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.safeBlockHorizontal * 5,
                                  vertical: SizeConfig.safeBlockVertical * 7),
                              child: Container(
                                //color: Colors.red,
                                height: SizeConfig.safeBlockVertical * 20,
                                width: SizeConfig.safeBlockHorizontal * 45,
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/All done.png')),
                              ),
                            ),
                            Text(
                              Applocalizations.of(context)
                                  .translate("All Done"),
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: SizeConfig.safeBlockHorizontal * 9),
                            ),
                            Text(
                              Applocalizations.of(context)
                                  .translate('Enjoy Your Stay'),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 4,
                  ),
                  _currentPage != _numPages - 1
                      ? Padding(
                          padding: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal * 1.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  _currentPage != 0 ? previousStep() : cancel();
                                },
                                child: Container(
                                  height: SizeConfig.safeBlockVertical * 5,
                                  width: SizeConfig.safeBlockHorizontal * 33,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      _currentPage == 0
                                          ? Applocalizations.of(context)
                                              .translate('Cancel')
                                          : Applocalizations.of(context)
                                              .translate('Previous'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal *
                                                4.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.safeBlockHorizontal * 5,
                              ),
                              loading
                                  ? Container(
                                      height: SizeConfig.safeBlockVertical * 5,
                                      width:
                                          SizeConfig.safeBlockHorizontal * 33,
                                      child: Center(
                                          child: CircularProgressIndicator()))
                                  : InkWell(
                                      onTap: () {
                                        nextStep();
                                      },
                                      child: Container(
                                        height:
                                            SizeConfig.safeBlockVertical * 5,
                                        width:
                                            SizeConfig.safeBlockHorizontal * 33,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Theme.of(context).accentColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            Applocalizations.of(context)
                                                .translate('Next'),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            backToHome();
                          },
                          child: Container(
                            height: SizeConfig.safeBlockVertical * 6,
                            width: SizeConfig.safeBlockHorizontal * 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal,
                                ),
                                Text(
                                  Applocalizations.of(context)
                                      .translate('Back to Home'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
