import 'package:aqar_bazar/Provider/date_provider.dart';
import 'package:aqar_bazar/widgets/date_card.dart';
import 'package:aqar_bazar/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/widgets/date_range_card.dart';

class Booking extends StatefulWidget {
  final String propId;
  final String payCycle;
  final String rentPrice;

  const Booking({Key key, this.propId, this.payCycle, this.rentPrice})
      : super(key: key);

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
    SvgPicture.asset('assets/icons/calendar-uncolored.svg'),
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
      Services.bookProperty(widget.propId, startDate, endDate, widget.payCycle,
              widget.rentPrice, context)
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
    startDate = Provider.of<DateProvider>(context).getStartDate();
    endDate = Provider.of<DateProvider>(context).getEndDate();
    ccNumber = Provider.of<DateProvider>(context).getCCNumber();
    cvc = Provider.of<DateProvider>(context).getCVCNumber();
    month = Provider.of<DateProvider>(context).getMonth();
    year = Provider.of<DateProvider>(context).getYear();

    return SafeArea(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            //height: MediaQuery.of(context).size.height,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Renting Details For',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'property name',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    width: MediaQuery.of(context).size.width,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                "Payment",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: PaymentCard(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                "Pick A Date",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: DateRangeCard(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/All done.png')),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                "All Done",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 35),
                              ),
                              Text(
                                'Enjoy Your Stay!',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _currentPage != _numPages - 1
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  _currentPage != 0 ? previousStep() : cancel();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 21,
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      _currentPage == 0 ? 'Cancel' : 'Previous',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              loading
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              21,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Center(
                                          child: CircularProgressIndicator()))
                                  : InkWell(
                                      onTap: () {
                                        _currentPage != _numPages - 1
                                            ? nextStep()
                                            : backToHome();
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                21,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Theme.of(context).accentColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            _currentPage != _numPages - 1
                                                ? 'Next'
                                                : 'Back to Home',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
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
                            height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width / 2,
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
                                  width: 5,
                                ),
                                Text(
                                  'Back to Home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
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
