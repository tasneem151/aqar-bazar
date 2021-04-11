import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading;
  String oldPassword;
  String newPassword;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.safeBlockVertical * 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400],
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: SizeConfig.safeBlockHorizontal * 2,
                                left: SizeConfig.safeBlockHorizontal * 5),
                            child:
                                SvgPicture.asset('assets/icons/lock-large.svg'),
                          ),
                          Text(
                            Applocalizations.of(context)
                                .translate("Account Information"),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.safeBlockHorizontal * 5.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 8,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 6,
                            bottom: SizeConfig.safeBlockVertical * 1.5),
                        child: SvgPicture.asset('assets/icons/key.svg'),
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 6,
                            bottom: SizeConfig.safeBlockVertical * 1.5),
                        child: Text(
                          Applocalizations.of(context)
                              .translate('Old Password'),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8,
                        bottom: SizeConfig.safeBlockVertical * 2),
                    child: CustomTextField(
                      hint: Applocalizations.of(context)
                          .translate("Enter Old Password"),
                      isPassword: true,
                      /* validator: (String value) {
                        if (value.length < 8) {
                          return 'Password should be minimum 8 characters';
                        }
                        _formKey.currentState.save();
                        return null;
                      }, */
                      onSaved: (String value) {
                        oldPassword = value;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.safeBlockVertical * 1.5),
                        child: SvgPicture.asset(
                            'assets/icons/key-colored-small.svg'),
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.safeBlockVertical * 1.5),
                        child: Text(
                          Applocalizations.of(context)
                              .translate('New Password'),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: CustomTextField(
                      hint: Applocalizations.of(context)
                          .translate("Enter New Password"),
                      isPassword: true,
                      validator: (String value) {
                        if (value.length < 8) {
                          return Applocalizations.of(context)
                              .translate('Short Password');
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      onSaved: (String value) {
                        newPassword = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 4,
                    ),
                    child: loading
                        ? CircularProgressIndicator()
                        : Container(
                            width: SizeConfig.safeBlockHorizontal * 60,
                            height: SizeConfig.safeBlockVertical * 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff21d8a2),
                                  Color(0xff4e89c7),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.1, 1.0],
                              ),
                              boxShadow: [kButtonShadow],
                            ),
                            child: FlatButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  setState(() {
                                    loading = true;
                                  });
                                  Services.checkOldPassword(
                                          oldPassword, context)
                                      .then((value) => {
                                            if (value == 422)
                                              setState(() {
                                                loading = false;
                                              }),
                                            if (value == 200)
                                              Services.updatePassword(
                                                      newPassword, context)
                                                  .then((value) => {
                                                        if (value == 200)
                                                          Navigator.pop(context)
                                                      })
                                          });
                                }
                              },
                              child: Text(
                                Applocalizations.of(context)
                                    .translate('Submit Changes'),
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
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
