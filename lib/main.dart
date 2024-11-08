import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/style/themes.dart';
import 'package:provider/provider.dart' as provider; // Alias provider package
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localization/localization.dart';
import 'layout/tabs_screen.dart';
import 'modules/provider/app_language.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguageProvider appLanguage = AppLanguageProvider();
  await appLanguage.fetchLocale();
  var prefs = await SharedPreferences.getInstance();
  bool? isDark = prefs.getBool('isDark') ?? false;
  runApp(
    ProviderScope(
      child: MyApp(appLanguage: appLanguage,isDark: isDark),
    ),
  );
}

class MyApp extends StatefulWidget {
  final AppLanguageProvider appLanguage;
  final bool? isDark;

  MyApp({super.key, required this.appLanguage, this.isDark});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDark;
  @override
  void initState() {
    super.initState();
    isDark = widget.isDark ?? false;
  }

  void toggleTheme()async {

    print("Toggling theme: $isDark");
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = !isDark;
      prefs.setBool('isDark', isDark);
    });
  }

    @override
  Widget build(BuildContext context) {
    return provider.ChangeNotifierProvider(
      create: (BuildContext context) => widget.appLanguage,
      child: provider.Consumer<AppLanguageProvider>(
        builder: (context, model, child) {
          return MaterialApp(
            themeAnimationCurve: Curves.linear ,
            themeAnimationDuration: const Duration(milliseconds: 1500),
            title: 'Catering App',
            themeMode:isDark ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
      //       theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const Color.fromARGB(255, 132, 0, 0),
      //   ),
      //   useMaterial3: true,
      //   // textTheme:GoogleFonts.latoTextTheme()
      // ),
            darkTheme: darkTheme,
            home: MyHomePage( toggleTheme: toggleTheme, isDark: isDark),
            locale: model.appLocal,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ar', 'EG'),
              Locale('fr', 'FR'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  final void Function() toggleTheme;
  final bool isDark;
  const MyHomePage({super.key, required this.toggleTheme, required this.isDark});

  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => TabsScreen(widget.toggleTheme, widget.isDark)
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/1600w-c63Q4XiumMk.webp', // Replace with the path to your photo
      fit: BoxFit.fill,     // Adjusts image to fill the screen
      height: MediaQuery.of(context).size.height, // Matches screen height
      width: MediaQuery.of(context).size.width,   // Matches screen width
    );
  }
}

