import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Reviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
          ),
          color: Color(0xfff6f6f6),
          width: width,
          height: height / 9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reviews For',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    'Property name',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
              Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 15.0,
                      )
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.grey[300],
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 1.0],
                    )),
                child: Center(
                    child: Image(
                        image: AssetImage(
                          'assets/icons/Logo short.png',
                        ),
                        fit: BoxFit.scaleDown)),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(height / 9),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return CommentCard();
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3,),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width / 1.3,
                    height: height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.grey[300], offset: Offset(0,0), blurRadius: 10.0),
                      ],
                      color: Colors.white,
                    ),
                    //padding: EdgeInsets.only(top: 10, left: 5),
                    child: TextFormField(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15),
                        prefixIcon: SvgPicture.asset('assets/icons/testimonial.svg', fit: BoxFit.scaleDown,),
                        hintText: 'Leave a comment',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).accentColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400],
                          offset: Offset(0,2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                        child: FaIcon(FontAwesomeIcons.telegramPlane, color: Colors.white,)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
              image: DecorationImage(image: AssetImage('assets/temp/user.png')),
            ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(0, 2),
                  blurRadius: 8.0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Feb 06,2021',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Text(
                    'Very peaceful area really unique Rick formations. Some famous Westerns were filmed here including The Lone Ranger and Bonanza.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
