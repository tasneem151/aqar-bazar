import 'package:aqar_bazar/Models/sign_form_model.dart';
import 'package:aqar_bazar/screens/home_screen.dart';
import 'package:aqar_bazar/screens/sign_up.dart';
import 'package:aqar_bazar/widgets/sign_textfield.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'package:aqar_bazar/networking/services.dart';

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
                    height: height,
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
                          offset: Offset(0.0, -1.0),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 115,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SignTextField(
                            hint: 'Enter Your Email',
                            inShadow: Color(0xff21d8a2),
                            outShadow: Color(0xff4e7ac7),
                            isEmail: true,
                            validator: (String value) {
                              if (!validator.isEmail(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              model.email = value;
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
                            hint: 'Enter Your Password',
                            inShadow: Color(0xff21d8a2),
                            outShadow: Color(0xff4e89c7),
                            isPassword: true,
                            validator: (String value) {
                              if (value.length < 8) {
                                return 'Incorrect Password';
                              }
                              _formKey.currentState.save();
                              return null;
                            },
                            onSaved: (String value) {
                              model.password = value;
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
                                    /* Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    ); */
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
                                    width: width / 1.2,
                                    height: height / 21,
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
                                        'Sign In',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).accentColor),
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
                              return SignUp();
                            })),
                            child: Container(
                              width: width / 1.2,
                              height: height / 21,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              'Powered By #Hashtag',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
