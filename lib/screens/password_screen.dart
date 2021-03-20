import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    // TODO: implement initState
    super.initState();
    loading = false;
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
                            SvgPicture.asset('assets/icons/lock-large.svg'),
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
                        SvgPicture.asset('assets/icons/key.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Enter Old Password',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: CustomTextField(
                      hint: "Old Password",
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/key-colored-small.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Enter New Password',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: CustomTextField(
                      hint: "New Password",
                      isPassword: true,
                      validator: (String value) {
                        if (value.length < 8) {
                          return 'Password should be minimum 8 characters';
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
