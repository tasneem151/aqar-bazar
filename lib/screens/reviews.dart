import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aqar_bazar/Models/comment.dart';
import 'package:aqar_bazar/Models/show_property.dart';
import 'package:aqar_bazar/networking/services.dart';

class Reviews extends StatefulWidget {
  final ShowProperty prop;

  const Reviews({Key key, this.prop}) : super(key: key);
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  String comment;
  List<Comment> commentsList;
  bool loading;
  TextEditingController controller = TextEditingController();

  void updateUI() {
    loading = true;
    Services.getComments(widget.prop.id, context).then((value) => {
          if (mounted)
            {
              setState(() => {
                    commentsList = value,
                    loading = false,
                  }),
            }
        });
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

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
                    widget.prop.title,
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
                child: loading
                    ? Center(
                        child: LinearProgressIndicator(),
                      )
                    : commentsList.length == 0
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: height / 3,
                            ),
                            child: Center(
                              child: Text(
                                "No Comments Yet.",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: commentsList.length == null
                                ? 0
                                : commentsList.length,
                            itemBuilder: (context, index) {
                              return CommentCard(
                                comment: commentsList[
                                    (commentsList.length - 1) - index],
                              );
                            }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 3,
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width / 1.3,
                    height: height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(0, 0),
                            blurRadius: 10.0),
                      ],
                      color: Colors.white,
                    ),
                    //padding: EdgeInsets.only(top: 10, left: 5),
                    child: TextFormField(
                      controller: controller,
                      onChanged: (value) {
                        comment = value;
                      },
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15),
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/testimonial.svg',
                          fit: BoxFit.scaleDown,
                        ),
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
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      if (comment != null) {
                        Services.writeComment(
                                widget.prop.id.toString(), comment, context)
                            .then((value) => {
                                  setState(() {
                                    updateUI();
                                  }),
                                });
                        setState(() {
                          loading = true;
                          controller.clear();
                        });
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400],
                            offset: Offset(0, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: FaIcon(
                            FontAwesomeIcons.telegramPlane,
                            color: Colors.white,
                          )),
                    ),
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
  final Comment comment;

  const CommentCard({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xff21d8a2),
            child: Text(
              comment.client.firstName == null
                  ? ""
                  : comment.client.firstName[0].toUpperCase() +
                      comment.client.lastName[0].toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 30),
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
                        comment.client.firstName[0].toUpperCase() +
                            comment.client.firstName.substring(1) +
                            " " +
                            comment.client.lastName[0].toUpperCase() +
                            comment.client.lastName.substring(1),
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        comment.createdAt.day.toString() +
                            "-" +
                            comment.createdAt.month.toString() +
                            "-" +
                            comment.createdAt.year.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Text(comment.comment),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
