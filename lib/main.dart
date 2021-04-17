import 'package:aqar_bazar/Manager/manager.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/screens/sign_up.dart';
import 'package:aqar_bazar/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'Provider/modelsProvider.dart';
import 'package:flutter/services.dart';
import 'localization/app_language.dart';
import 'package:aqar_bazar/screens/home_screen.dart';
import 'package:pusher_beams/pusher_beams.dart';

void main() async {
  AppLanguage appLanguage = AppLanguage();
  WidgetsFlutterBinding.ensureInitialized();
  await appLanguage.fetchLocale();
  await PusherBeams.start(kInstanceId);
  Manager.getAuthToken().then((value) => {
        runApp(MyApp(
          appLanguage: appLanguage,
          auth: value,
        )),
      });
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  final String auth;
  const MyApp({Key key, this.appLanguage, this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ModelsProvider>(
            create: (_) => ModelsProvider(),
          ),
          ChangeNotifierProvider<AppLanguage>(
            create: (_) => appLanguage,
          )
        ],
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            return MaterialApp(
              locale: model.appLocal,
              localizationsDelegates: [
                Applocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ar', ''),
                Locale('tr', 'TUR')
              ],
              /* localeResolutionCallback: (locale, locales) {
          if (locale.languageCode == 'ar') {
            Manager.setLang('ar', context);
            return Locale('ar', 'AR');
          } else if (locale.languageCode == 'en') {
            Manager.setLang('en', context);
            return Locale('en', 'EN');
          }
        }, */
              debugShowCheckedModeBanner: false,
              theme: Themes.themeData(context),
              home: auth.isEmpty ? SignUp() : HomeScreen(),
            );
          },
        ));
  }
}
