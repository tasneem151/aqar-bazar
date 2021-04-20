import 'package:aqar_bazar/networking/services.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  bool loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    String message;

    TextEditingController controller = TextEditingController();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
              child: Center(
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 40,
                  height: SizeConfig.safeBlockHorizontal * 40,
                  child: Image(
                    image: AssetImage('assets/icons/logo-short-large.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal),
              child: AutoSizeText(
                Applocalizations.of(context)
                    .translate("Do you want to contact us?"),
                style: TextStyle(color: Colors.grey, fontSize: 22),
                minFontSize: 18,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal),
              child: AutoSizeText(
                Applocalizations.of(context)
                    .translate("It's easy we're only a click away"),
                style: TextStyle(color: Colors.grey, fontSize: 22),
                minFontSize: 18,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockHorizontal * 5,
            ),
            Container(
              height: SizeConfig.safeBlockVertical * 30,
              width: SizeConfig.safeBlockHorizontal * 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ]),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  message = value;
                },
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: Applocalizations.of(context)
                        .translate("Type your message here"),
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 3,
                        left: SizeConfig.safeBlockHorizontal * 2.5,
                        right: SizeConfig.safeBlockHorizontal * 2.5,
                        bottom: SizeConfig.safeBlockVertical * 1.5),
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            loading
                ? CircularProgressIndicator()
                : GestureDetector(
                    onTap: () {
                      Services.contactUs(
                              'message from client', message, context)
                          .then((value) => {
                                controller.clear(),
                                setState(() {
                                  loading = false;
                                })
                              });
                      setState(() {
                        loading = true;
                      });
                    },
                    child: Container(
                      height: SizeConfig.safeBlockVertical * 5,
                      width: SizeConfig.safeBlockHorizontal * 30,
                      child: Center(
                        child: Text(
                          Applocalizations.of(context).translate("Send"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockHorizontal * 5),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff21d8a2),
                            Color(0xff4e89c7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.1, 1.0],
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: SizeConfig.safeBlockVertical * 15,
                      width: SizeConfig.safeBlockHorizontal * 17,
                      decoration: BoxDecoration(
                          color: Color(0xff4e89c7),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: SizeConfig.safeBlockVertical * 15,
                      width: SizeConfig.safeBlockHorizontal * 17,
                      decoration: BoxDecoration(
                          color: Color(0xff21d8a2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
