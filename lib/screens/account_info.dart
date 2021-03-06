import 'package:aqar_bazar/Models/profile_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aqar_bazar/widgets/custom_textfield.dart';
import 'package:aqar_bazar/constants.dart';

class AccountInfo extends StatefulWidget {
  final ProfileFormModel accountInfo;

  const AccountInfo({Key key, this.accountInfo}) : super(key: key);
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final _formKey = GlobalKey<FormState>();
  ProfileFormModel model = ProfileFormModel();
  //TextEditingController myController = TextEditingController();
  @override
  void initState() {
    super.initState();
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
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/change-name.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Change Name',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: CustomTextField(
                    onChanged: (value) {
                      model.name = value;
                    },
                    //controller: myController,
                    initValue: widget.accountInfo.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/change-email.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Change Email',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: CustomTextField(
                    onChanged: (value) {
                      model.email = value;
                    },
                    //controller: myController,
                    initValue: widget.accountInfo.email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/change-phone.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Change Phone Number',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: CustomTextField(
                    onChanged: (value) {
                      model.phoneNumber = value;
                    },
                    //controller: myController,
                    initValue: widget.accountInfo.phoneNumber,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/change-password.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Change Password',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: CustomTextField(
                    onChanged: (value) {
                      model.password = value;
                    },
                    //controller: myController,
                    initValue: widget.accountInfo.password,
                    isPassword: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                  ),
                  child: Container(
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
                            Navigator.pop(context, model);
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
    );
  }
}
