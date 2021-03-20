import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/screens/password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/widgets/custom_textfield.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:validators/validators.dart' as validator;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_code_picker/country_code_picker.dart';

class AccountInfo extends StatefulWidget {
  final ProfileInfo accountInfo;

  const AccountInfo({Key key, this.accountInfo}) : super(key: key);
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final _formKey = GlobalKey<FormState>();
  bool loading;
  //TextEditingController myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loading = false;
    //print(model.name + 'jguiguig');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                    height: height / 5,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/account50.svg'),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Account Information",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 30, right: 30),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/change-name.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Change First Name',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: CustomTextField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        widget.accountInfo.firstName = value;
                      },
                      initValue: widget.accountInfo == null
                          ? ""
                          : widget.accountInfo.firstName,
                    ),
                  ),
                  ////////////////////////////////////////////////
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/change-name.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Change Last Name',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: CustomTextField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter your Last name';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        widget.accountInfo.lastName = value;
                      },
                      initValue: widget.accountInfo == null
                          ? ""
                          : widget.accountInfo.lastName,
                    ),
                  ),
                  ////////////////////////////////
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/change-email.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Change Email',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: CustomTextField(
                      validator: (String value) {
                        if (!validator.isEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        widget.accountInfo.email = value;
                      },
                      isEmail: true,
                      initValue: widget.accountInfo.email,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/change-phone.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Change Phone Number',
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
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: CustomTextField(
                      initValue: widget.accountInfo.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter a valid Phone Number';
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      onSaved: (value) {
                        widget.accountInfo.phone = value;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
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
                              'Change Password',
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
                            width: width / 7,
                            height: height / 17,
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
                      top: 30,
                    ),
                    child: loading
                        ? CircularProgressIndicator()
                        : Container(
                            width: width / 1.5,
                            height: height / 17,
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
                                  Services.updateUserInfo(
                                          widget.accountInfo.firstName,
                                          widget.accountInfo.lastName,
                                          widget.accountInfo.email,
                                          widget.accountInfo.phone,
                                          context)
                                      .then((value) => {
                                            if (value == 200)
                                              Navigator.pop(context, true),
                                          });
                                }
                              },
                              child: Text(
                                'Submit Changes',
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
