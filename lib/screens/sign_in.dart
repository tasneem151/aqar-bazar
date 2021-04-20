import 'package:aqar_bazar/Models/sign_form_model.dart';
import 'package:aqar_bazar/screens/home_screen.dart';
import 'package:aqar_bazar/screens/sign_up.dart';
import 'package:aqar_bazar/widgets/sign_textfield.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  SignFormModel model = SignFormModel();
  bool loading;

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
                    height: SizeConfig.screenHeight,
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
                          offset: Offset(0.0, -1.0),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal * 8,
                          vertical: SizeConfig.safeBlockVertical * 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              Applocalizations.of(context).translate('Sign In'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.safeBlockHorizontal * 8,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 12,
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
                            hint: Applocalizations.of(context)
                                .translate('Enter Your Email'),
                            inShadow: Color(0xff21d8a2),
                            outShadow: Color(0xff4e7ac7),
                            isEmail: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return Applocalizations.of(context)
                                    .translate('Empty Field');
                              } else if (!validator.isEmail(value.trim())) {
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
                            hint: Applocalizations.of(context)
                                .translate('Enter Your Password'),
                            inShadow: Color(0xff21d8a2),
                            outShadow: Color(0xff4e89c7),
                            isPassword: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return Applocalizations.of(context)
                                    .translate('Empty Field');
                              } else if (value.length < 8) {
                                return Applocalizations.of(context)
                                    .translate('Incorrect Password');
                              }
                              _formKey.currentState.save();
                              return null;
                            },
                            onSaved: (String value) {
                              model.password = value;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : InkWell(
                                  onTap: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      setState(() {
                                        loading = true;
                                      });
                                      Services.login(model.email,
                                              model.password, context)
                                          .then((value) => {
                                                setState(() {
                                                  loading = false;
                                                }),
                                                if (value == 200)
                                                  {
                                                    Navigator.pushReplacement(
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
                                            offset: Offset(1.0, 3.0),
                                            blurRadius: 6.0,
                                          )
                                        ]),
                                    child: Center(
                                      child: Text(
                                        Applocalizations.of(context)
                                            .translate('Sign In'),
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
                              return SignUp();
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
                                      .translate('Sign Up'),
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
                          Center(
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
