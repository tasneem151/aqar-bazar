import 'package:aqar_bazar/localization/app_language.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:provider/provider.dart';

class AlertRadio extends StatefulWidget {
  final String language;

  const AlertRadio({Key key, this.language}) : super(key: key);

  @override
  _AlertRadioState createState() => _AlertRadioState();
}

class _AlertRadioState extends State<AlertRadio> {
  String lang;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lang = widget.language;
    //Manager.getLang().then((value) => {lang = value});
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);

    return AlertDialog(
      actionsPadding: EdgeInsets.only(right: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      title: Text(Applocalizations.of(context).translate('Select Language'),
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).primaryColor)),
      content: Container(
        height: SizeConfig.safeBlockVertical * 20,
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: 'en',
                  groupValue: lang,
                  onChanged: (value) {
                    setState(() {
                      lang = value;
                    });
                  },
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 2,
                ),
                Text("English"),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 'ar',
                  groupValue: lang,
                  onChanged: (value) {
                    setState(() {
                      lang = value;
                    });
                  },
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 2,
                ),
                Text("العربية"),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        Container(
            height: SizeConfig.safeBlockVertical * 6,
            width: SizeConfig.safeBlockHorizontal * 35,
            child: Row(children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Applocalizations.of(context).translate("Close")),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                ),
              )),
            ])),
        Container(
            height: SizeConfig.safeBlockVertical * 6,
            width: SizeConfig.safeBlockHorizontal * 35,
            child: Row(children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    appLanguage.changeLanguage(Locale(lang));
                    //Manager.setLang(lang, context);
                    Navigator.of(context).pop();
                  },
                  child: Text(Applocalizations.of(context).translate("Submit")),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                ),
              )),
            ])),
      ],
    );
  }
}
