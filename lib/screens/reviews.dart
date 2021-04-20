import 'package:aqar_bazar/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aqar_bazar/Models/comment.dart';
import 'package:aqar_bazar/Models/show_property.dart';
import 'package:aqar_bazar/networking/services.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class Reviews extends StatefulWidget {
  final ShowProperty prop;

  const Reviews({this.prop});
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  String comment;
  List<Comment> commentsList = [];
  bool loading;
  TextEditingController controller = TextEditingController();

  void updateUI() {
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
    loading = true;
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 5,
            right: SizeConfig.safeBlockHorizontal * 5,
            top: SizeConfig.safeBlockVertical * 3,
          ),
          color: Color(0xfff6f6f6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Applocalizations.of(context).translate('Reviews For'),
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 5.5),
                  ),
                  Text(
                    widget.prop.title,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 5.5),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Container(
                width: SizeConfig.safeBlockHorizontal * 13,
                height: SizeConfig.safeBlockVertical * 5,
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
        preferredSize: Size.fromHeight(SizeConfig.safeBlockVertical * 13),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 1.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    loading
                        ? Center(
                            child: LinearProgressIndicator(),
                          )
                        : Container(),
                    !loading && commentsList.length == 0
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: SizeConfig.safeBlockVertical * 37,
                            ),
                            child: Text(
                              Applocalizations.of(context)
                                  .translate("No Comments Yet"),
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.safeBlockHorizontal,
                left: SizeConfig.safeBlockHorizontal * 5,
                right: SizeConfig.safeBlockHorizontal * 5,
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 77,
                    height: SizeConfig.safeBlockVertical * 5.3,
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
                        contentPadding: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 2.5),
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/testimonial.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        hintText: Applocalizations.of(context)
                            .translate('Leave a comment'),
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 1.5,
                  ),
                  GestureDetector(
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
                      height: SizeConfig.safeBlockHorizontal * 11.5,
                      width: SizeConfig.safeBlockHorizontal * 11.5,
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
                          padding: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 2.5,
                              right: SizeConfig.safeBlockHorizontal * 3.5,
                              top: SizeConfig.safeBlockVertical * 1.2),
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

  const CommentCard({this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.safeBlockVertical * 1.2,
          horizontal: SizeConfig.safeBlockHorizontal * 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: SizeConfig.safeBlockHorizontal * 7.5,
            backgroundColor: Color(0xff21d8a2),
            child: Text(
              comment.client.firstName == null
                  ? ""
                  : comment.client.firstName[0].toUpperCase() +
                      comment.client.lastName[0].toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.safeBlockHorizontal * 7.5),
            ),
          ),
          SizedBox(width: SizeConfig.safeBlockHorizontal * 2.5),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.safeBlockVertical * 2,
                horizontal: SizeConfig.safeBlockHorizontal * 2.5),
            width: SizeConfig.safeBlockHorizontal * 67,
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
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.safeBlockVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        comment.client.firstName[0].toUpperCase() +
                            comment.client.firstName.substring(1) +
                            " " +
                            comment.client.lastName[0].toUpperCase() +
                            comment.client.lastName.substring(1),
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 5),
                      ),
                      Text(
                        comment.createdAt.day.toString() +
                            "-" +
                            comment.createdAt.month.toString() +
                            "-" +
                            comment.createdAt.year.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: SizeConfig.safeBlockHorizontal * 3),
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
