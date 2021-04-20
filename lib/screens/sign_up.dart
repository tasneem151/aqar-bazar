import 'package:aqar_bazar/Models/sign_form_model.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/screens/home_screen.dart';
import 'package:aqar_bazar/screens/sign_in.dart';
import 'package:aqar_bazar/widgets/sign_textfield.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  SignFormModel model = SignFormModel();
  bool loading;
  String auth;
  //bool checking = true;

  @override
  void initState() {
    /* Manager.getAuthToken().then((value) => {
          auth = value,
          print(auth.isNotEmpty),
          print(auth != null),
          if (auth.isNotEmpty)
            {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }))
            },
          setState(() {
            checking = false;
          }),
        }); */

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
                  Center(
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 25,
                      height: SizeConfig.safeBlockVertical * 17,
                      child: Image(
                        image: AssetImage('assets/icons/Logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(SizeConfig.screenWidth, 270)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff4e89c7),
                          Color(0xff21d8a2),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          offset: Offset(0.0, -1.0), //(x,y)
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal * 8,
                          vertical: SizeConfig.safeBlockVertical * 5),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              Applocalizations.of(context).translate("Sign Up"),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.safeBlockHorizontal * 8,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 4,
                          ),
                          Text(
                            Applocalizations.of(context)
                                .translate("First Name"),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          SignTextField(
                            hint: Applocalizations.of(context)
                                .translate("Enter Your First Name"),
                            inShadow: Color(0xff21d8a2),
                            outShadow: Color(0xff4e6ec7),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return Applocalizations.of(context)
                                    .translate("Empty Field");
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              model.firstName = value;
                              print(model.firstName);
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          Text(
                            Applocalizations.of(context).translate('Last Name'),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          SignTextField(
                            hint: Applocalizations.of(context)
                                .translate('Enter Your Last Name'),
                            inShadow: Color(0xff21d8a2),
                            outShadow: Color(0xff4e6ec7),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return Applocalizations.of(context)
                                    .translate('Empty Field');
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              model.lastName = value;
                              print(model.lastName);
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          Text(
                            Applocalizations.of(context).translate('Email'),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          SignTextField(
                            isEmail: true,
                            hint: Applocalizations.of(context)
                                .translate('Enter a valid Email'),
                            inShadow: Color(0xff21d8a2),
                            outShadow: Color(0xff4e7ac7),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return Applocalizations.of(context)
                                    .translate('Empty Field');
                              } else if (!validator.isEmail(value)) {
                                return Applocalizations.of(context)
                                    .translate('Invalid');
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              model.email = value.trim();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          Text(
                            Applocalizations.of(context).translate('Password'),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          SignTextField(
                            isPassword: true,
                            hint: Applocalizations.of(context)
                                .translate('8 characters or more'),
                            inShadow: Color(0xff21d8a2),
                            outShadow: Color(0xff4e89c7),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return Applocalizations.of(context)
                                    .translate('Empty Field');
                              } else if (value.length < 8) {
                                return Applocalizations.of(context)
                                    .translate('Short Password');
                              }

                              _formKey.currentState.save();
                              return null;
                            },
                            onSaved: (String value) {
                              model.password = value;
                              print(model.password);
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          Text(
                            Applocalizations.of(context)
                                .translate('Confirm Password'),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          SignTextField(
                            isPassword: true,
                            hint: Applocalizations.of(context)
                                .translate('Repeat Password'),
                            inShadow: Color(0xff21d8a2),
                            outShadow: Color(0xff4e89c7),
                            validator: (String value) {
                              if (model.password != null &&
                                  value != model.password) {
                                print(value);
                                print(model.password);
                                return Applocalizations.of(context)
                                    .translate('Password not matched');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          Text(
                            Applocalizations.of(context)
                                .translate('Phone Number'),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal * 2,
                                    right: SizeConfig.safeBlockHorizontal * 2),
                                width: SizeConfig.safeBlockHorizontal * 18,
                                height: SizeConfig.safeBlockVertical * 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.safeBlockHorizontal * 5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff4e89c7).withOpacity(0.2),
                                    ),
                                    BoxShadow(
                                      color: Color(0xff21d8a2).withOpacity(0.2),
                                      spreadRadius: -12,
                                      blurRadius: 12,
                                    )
                                  ],
                                ),
                                child: CountryCodePicker(
                                  textStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  onChanged: (value) {
                                    model.countryCode = value.dialCode;
                                  },
                                  initialSelection: '+90',
                                  favorite: ['+966', '+90'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: true,
                                  showFlag: false,
                                ),
                              ),
                              SignTextField(
                                width: SizeConfig.safeBlockHorizontal * 63,
                                hint: Applocalizations.of(context)
                                    .translate("Enter Your Phone Number"),
                                inShadow: Color(0xff21d8a2).withOpacity(0.2),
                                outShadow: Color(0xff4e89c7).withOpacity(0.2),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return Applocalizations.of(context)
                                        .translate('Empty Field');
                                  } else if (!validator.isNumeric(value)) {
                                    return Applocalizations.of(context)
                                        .translate('Invalid Phone Number');
                                  }

                                  _formKey.currentState.save();
                                  return null;
                                },
                                onSaved: (String value) {
                                  model.phone = model.countryCode + value;
                                  print(model.phone);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 4,
                          ),
                          loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : InkWell(
                                  onTap: () {
                                    print(_formKey.currentState.validate());
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      setState(() {
                                        loading = true;
                                      });
                                      Services.createAccount(
                                              model.firstName,
                                              model.lastName,
                                              model.email,
                                              model.password,
                                              model.phone,
                                              context)
                                          .then((value) => {
                                                print(value),
                                                setState(() {
                                                  loading = false;
                                                }),
                                                if (value == 200)
                                                  {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeScreen(),
                                                      ),
                                                    ),
                                                  }
                                              });
                                    }
                                  },
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 85,
                                    height: SizeConfig.safeBlockVertical * 5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(1.0, 3.0), //(x,y)
                                            blurRadius: 6.0,
                                          )
                                        ]),
                                    child: Center(
                                      child: Text(
                                        Applocalizations.of(context)
                                            .translate('Sign Up'),
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    5,
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 4,
                          ),
                          InkWell(
                            onTap: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return SignIn();
                            })),
                            child: Container(
                              width: SizeConfig.safeBlockHorizontal * 85,
                              height: SizeConfig.safeBlockVertical * 5,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                border: Border.all(
                                    color: Colors.white,
                                    width:
                                        SizeConfig.safeBlockHorizontal * 0.5),
                              ),
                              child: Center(
                                child: Text(
                                  Applocalizations.of(context)
                                      .translate('Sign In'),
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 5,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 4,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              Applocalizations.of(context)
                                  .translate('Powered By #Hashtag'),
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                                  color: Colors.white),
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
