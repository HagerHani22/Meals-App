import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/style/themes.dart';
import 'package:provider/provider.dart' as provider; // Alias provider package
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localization/localization.dart';
import 'layout/tabs_screen.dart';
import 'modules/provider/language_provider.dart';
import 'modules/provider/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguageProvider appLanguage = AppLanguageProvider();
  await appLanguage.fetchLocale();
  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider.loadThemePreference();
  runApp(
    ProviderScope(
      child: MyApp(appLanguage: appLanguage, themeProvider: themeProvider),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppLanguageProvider appLanguage;
  final ThemeProvider themeProvider;

  const MyApp({super.key, required this.appLanguage, required this.themeProvider,});
  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider<AppLanguageProvider>.value(
          value: appLanguage,
        ),
        provider.ChangeNotifierProvider<ThemeProvider>.value(
          value: themeProvider,
        ),
      ],
      child: provider.Consumer2<AppLanguageProvider,ThemeProvider>(
       builder: (context, appLanguage,themeProvider, child) {
         return MaterialApp(
           themeAnimationCurve: Curves.linear ,
           themeAnimationDuration: const Duration(milliseconds: 1500),
           title: 'Catering App',
           themeMode:themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
           theme: lightTheme,
           //       theme: ThemeData(
           //   colorScheme: ColorScheme.fromSeed(
           //     seedColor: const Color.fromARGB(255, 132, 0, 0),
           //   ),
           //   useMaterial3: true,
           //   // textTheme:GoogleFonts.latoTextTheme()
           // ),
           darkTheme: darkTheme,
           home: MyHomePage( toggleTheme: themeProvider.toggleTheme, isDark: themeProvider.isDark),
           locale: appLanguage.appLocal,
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
class SplashScreenState extends State<MyHomePage>  with SingleTickerProviderStateMixin {
  double ballY = 0;
  double widthVal = 50;
  double heightVal = 50;
  double bottomVal = 500;
  bool add = false;
  bool showShadow = false;
  int times = 0;
  bool showSplash = false;

  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6 ),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => TabsScreen(widget.toggleTheme, widget.isDark)
            )
        )
    );
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..addListener(
            () {
          if (add) {
            ballY += 15;
          } else {
            ballY -= 15;
          }
          if (ballY <= -200) {
            times += 1;
            add = true;
            showShadow = true;
          }
          if (ballY >= 0) {
            add = false;
            showShadow = false;
            widthVal += 50;
            heightVal += 50;
            bottomVal -= 200;
          }
          if (times == 3) {
            showShadow = false;
            widthVal = MediaQuery.of(context).size.width;
            heightVal = MediaQuery.of(context).size.height;
            Timer(const Duration(milliseconds: 1500), (){
              setState(() {
                showSplash=true;
              });
            });
            _controller.stop();
          }
          setState(() {});
        },
      );
    _controller.repeat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              bottom: bottomVal,
              duration: const Duration(milliseconds: 600),
              child: Column(
                children: [
                  Transform.translate(
                    offset: Offset(0, ballY),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: times == 3 ? 5 : 1,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: widthVal,
                        height: heightVal,
                        // decoration: BoxDecoration(
                        //     shape: BoxShape.circle, color: Colors.blue),
                        child:Image.asset(
                          'assets/1600w-c63Q4XiumMk.webp',
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        )
                        ,
                      ),
                    ),
                  ),
                  if (showShadow)
                    Container(
                      width: 50,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.2),
                          borderRadius: BorderRadius.circular(100)),
                    )
                ],
              ),
            ),
            if (showSplash)
              Positioned(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/1600w-c63Q4XiumMk.webp',
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      )
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}

