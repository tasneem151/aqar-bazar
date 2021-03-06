import 'package:flutter/material.dart';

import 'contact_us.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child:
                  Image(image: AssetImage('assets/icons/logo-short-large.png')),
            )),
            SizedBox(
              height: 30,
            ),
            Text(
              'About AQAR BAZAR',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff015ca7),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Image(image: AssetImage('assets/temp/about2.png')),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, sapien in mollis tristique, diam ex tristique metus, ut hendrerit ante quam sit amet erat. Fusce aliquet eros vitae quam sodales luctus. Nunc venenatis nunc ac neque interdum vulputate. Etiam eget convallis lacus. Ut viverra nisi ac tortor ultrices ultrices. Aenean aliquet elementum vestibulum. In luctus tempus justo, euismod gravida ante vehicula a. Donec vitae volutpat sapien. Etiam vitae tellus quis magna placerat maximus vel sit amet orci.',
                  overflow: TextOverflow.clip,
                  maxLines: 15,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'What We Do?',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff015ca7),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image(image: AssetImage('assets/temp/about1.png')),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.9,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, sapien in mollis tristique, diam ex tristique metus, ut hendrerit ante quam sit amet erat. Fusce aliquet eros vitae quam sodales luctus. Nunc venenatis nunc ac neque interdum vulputate. Etiam eget convallis lacus. Ut viverra nisi ac tortor ultrices ultrices. Aenean aliquet elementum vestibulum. In luctus tempus justo, euismod gravida ante vehicula a. Donec vitae volutpat sapien. Etiam vitae tellus quis magna placerat maximus vel sit amet orci.',
                            overflow: TextOverflow.clip,
                            maxLines: 15,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.9,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, sapien in mollis tristique, diam ex tristique metus, ut hendrerit ante quam sit amet erat. Fusce aliquet eros vitae quam sodales luctus. Nunc venenatis nunc ac neque interdum vulputate. Etiam eget convallis lacus. Ut viverra nisi ac tortor ultrices ultrices. Aenean aliquet elementum vestibulum. In luctus tempus justo, euismod gravida ante vehicula a. Donec vitae volutpat sapien. Etiam vitae tellus quis magna placerat maximus vel sit amet orci.',
                            overflow: TextOverflow.clip,
                            maxLines: 15,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image(image: AssetImage('assets/temp/about3.png')),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Do You Have A Question?',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff015ca7),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ContactUs();
              })),
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Center(
                  child: Text(
                    "Contact Us",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff4e89c7),
                      Color(0xff21d8a2),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 1.0],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    ));
  }
}
