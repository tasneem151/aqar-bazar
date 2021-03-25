import 'package:aqar_bazar/Manager/manager.dart';
import 'package:aqar_bazar/screens/home_screen.dart';
import 'package:aqar_bazar/screens/sign_up.dart';
import 'package:aqar_bazar/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'Provider/modelsProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelsProvider>(
          create: (_) => ModelsProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
        ],
        debugShowCheckedModeBanner: false,
        theme: Themes.themeData(context),
        home: SignUp(),
      ),
    );
  }
}
