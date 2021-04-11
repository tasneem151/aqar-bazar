import 'package:aqar_bazar/Manager/manager.dart';
import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/screens/password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/widgets/custom_textfield.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:validators/validators.dart' as validator;
import 'package:aqar_bazar/size_config.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/Provider/modelsProvider.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class AccountInfo extends StatefulWidget {
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final _formKey = GlobalKey<FormState>();
  bool loading;
  String lang;
  //TextEditingController myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    ProfileInfo user =
        Provider.of<ModelsProvider>(context, listen: true).getUserInfo();
    //Manager.getLang().then((value) => {lang = value});
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
                    height: SizeConfig.safeBlockVertical * 21,
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
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 5,
                              right: SizeConfig.safeBlockHorizontal * 5),
                          child: SvgPicture.asset('assets/icons/account50.svg'),
                        ),
                        Text(
                          Applocalizations.of(context)
                              .translate("Account Information"),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 7,
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/change-name.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          Applocalizations.of(context)
                              .translate('Change First Name'),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1.5,
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: CustomTextField(
                      /* validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter your first name';
                        }
                        return null;
                      }, */
                      onSaved: (String value) {
                        user.firstName = value;
                      },
                      initValue: user == null ? "" : user.firstName,
                    ),
                  ),
                  ////////////////////////////////////////////////
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1.5,
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/change-name.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          Applocalizations.of(context)
                              .translate('Change Last Name'),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1.5,
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: CustomTextField(
                      /* validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter your Last name';
                        }
                        return null;
                      }, */
                      onSaved: (String value) {
                        user.lastName = value;
                      },
                      initValue: user == null ? "" : user.lastName,
                    ),
                  ),
                  ////////////////////////////////
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1.5,
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/change-email.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          Applocalizations.of(context)
                              .translate('Change Email'),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1.5,
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: CustomTextField(
                      validator: (String value) {
                        if (!validator.isEmail(value)) {
                          return Applocalizations.of(context)
                              .translate('Enter a valid Email');
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        user.email = value;
                      },
                      isEmail: true,
                      initValue: user.email,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1.5,
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/change-phone.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          Applocalizations.of(context)
                              .translate('Change Phone Number'),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  /* Padding(
            padding: EdgeInsets.only(top: 10, left: 40),
            child: Container(
              //padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width / 7.2,
              //height: MediaQuery.of(context).size.height / 15.4,
              child: CountryCodePicker(
                onChanged: (value) {
                  countryCode = value.dialCode;
                },
                initialSelection: '+90',
                favorite: ['+966', '+90'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: true,
                showFlag: false,
              ),
            ),
          ), */
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1.5,
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: CustomTextField(
                      initValue: user.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return Applocalizations.of(context)
                              .translate('Invalid');
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      onSaved: (value) {
                        user.phone = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1.5,
                        left: SizeConfig.safeBlockHorizontal * 8,
                        right: SizeConfig.safeBlockHorizontal * 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                                'assets/icons/change-password.svg'),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              Applocalizations.of(context)
                                  .translate('Change Password'),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChangePasswordScreen();
                            }));
                          },
                          child: Container(
                            width: SizeConfig.safeBlockHorizontal * 15,
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
                            child: Center(
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* Padding(
            padding: EdgeInsets.only(top: 10, left: 30, right: 30),
            child: CustomTextField(
              hint: "Enter New Password",
              isPassword: true,
              validator: (String value) {
                if (value.length < 8) {
                  return 'Password should be minimum 8 characters';
                }
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) {},
            ),
          ), */
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockHorizontal * 8,
                      bottom: SizeConfig.safeBlockHorizontal * 8,
                    ),
                    child: loading
                        ? CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.safeBlockHorizontal * 5),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 35,
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
                                      Navigator.pop(context, false);
                                    },
                                    child: Text(
                                      Applocalizations.of(context)
                                          .translate('Cancel'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.safeBlockHorizontal * 5),
                                child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 35,
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
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          setState(() {
                                            loading = true;
                                          });
                                          Services.updateUserInfo(
                                                  user.firstName,
                                                  user.lastName,
                                                  user.email,
                                                  user.phone,
                                                  context)
                                              .then((value) => {
                                                    if (value == 200)
                                                      Navigator.pop(
                                                          context, true),
                                                  });
                                        }
                                      },
                                      child: Text(
                                        Applocalizations.of(context)
                                            .translate('Submit'),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
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
