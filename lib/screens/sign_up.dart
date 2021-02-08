import 'package:aqar_bazar/screens/sign_in.dart';
import 'package:aqar_bazar/widgets/sign_textfield.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
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
                borderRadius:
                    BorderRadius.vertical(top: Radius.elliptical(width, 270)),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
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
                      'Full Name',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SignTextField(
                      hint: 'Full Name',
                      inShadow: Color(0xff21d8a2),
                      outShadow: Color(0xff4e6ec7),
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
                      hint: 'Enter a valid Email',
                      inShadow: Color(0xff21d8a2),
                      outShadow: Color(0xff4e7ac7),
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
                      hint: '8 characters or more',
                      inShadow: Color(0xff21d8a2),
                      outShadow: Color(0xff4e89c7),
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
                      hint: 'Repeat Password',
                      inShadow: Color(0xff21d8a2),
                      outShadow: Color(0xff4e89c7),
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
                      hint: '+90|',
                      inShadow: Color(0xff21d8a2),
                      outShadow: Color(0xff4e89c7),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: width / 1.2,
                      height: height / 21,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).scaffoldBackgroundColor,
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
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              topLeft: Radius.circular(30)),
                          border: Border(
                              top: BorderSide(color: Colors.white, width: 2),
                              right: BorderSide(color: Colors.white, width: 2),
                              bottom: BorderSide(color: Colors.white, width: 2),
                              left: BorderSide(color: Colors.white, width: 2)),
                        ),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
    );
  }
}
