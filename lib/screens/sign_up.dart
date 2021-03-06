import 'package:aqar_bazar/Models/sign_form_model.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/screens/home_screen.dart';
import 'package:aqar_bazar/screens/sign_in.dart';
import 'package:aqar_bazar/widgets/sign_textfield.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  SignFormModel model = SignFormModel();
  bool loading;

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
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Image(
                        image: AssetImage('assets/icons/Logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(width, 270)),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Fisrt Name',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SignTextField(
                          hint: 'First Name',
                          inShadow: Color(0xff21d8a2),
                          outShadow: Color(0xff4e6ec7),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter your first name';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            model.firstName = value;
                            print(model.firstName);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Last Name',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SignTextField(
                          hint: 'Last Name',
                          inShadow: Color(0xff21d8a2),
                          outShadow: Color(0xff4e6ec7),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter your last name';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            model.lastName = value;
                            print(model.lastName);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SignTextField(
                          isEmail: true,
                          hint: 'Enter a valid Email',
                          inShadow: Color(0xff21d8a2),
                          outShadow: Color(0xff4e7ac7),
                          validator: (String value) {
                            if (!validator.isEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            model.email = value;
                            print(model.email);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SignTextField(
                          isPassword: true,
                          hint: '8 characters or more',
                          inShadow: Color(0xff21d8a2),
                          outShadow: Color(0xff4e89c7),
                          validator: (String value) {
                            if (value.length < 8) {
                              return 'Password should be minimum 8 characters';
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
                          height: 20,
                        ),
                        Text(
                          'Confirm Password',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SignTextField(
                          isPassword: true,
                          hint: 'Repeat Password',
                          inShadow: Color(0xff21d8a2),
                          outShadow: Color(0xff4e89c7),
                          validator: (String value) {
                            if (value.length < 8) {
                              return 'Password should be minimum 8 characters';
                            } else if (model.password != null &&
                                value != model.password) {
                              print(value);
                              print(model.password);
                              return 'Password not matched';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SignTextField(
                          hint: '+90 |',
                          inShadow: Color(0xff21d8a2),
                          outShadow: Color(0xff4e89c7),
                          validator: (String value) {
                            if (!validator.isNumeric(value)) {
                              return 'Please enter a valid Number';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            model.phone = value;
                            print(model.phone);
                          },
                        ),
                        SizedBox(
                          height: 30,
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
                                  width: width / 1.2,
                                  height: height / 21,
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
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return SignIn();
                          })),
                          child: Container(
                            width: width / 1.2,
                            height: height / 21,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Powered By #Hashtag',
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
    );
  }
}
