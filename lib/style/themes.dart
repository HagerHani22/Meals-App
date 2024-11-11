import 'package:flutter/material.dart';

var myColorScheme =
    ColorScheme.fromSeed(seedColor: const  Color.fromARGB(255, 132, 0, 0));
var myDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 59, 96, 179));

ThemeData lightTheme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: myColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: myColorScheme.onPrimaryContainer,
      foregroundColor: myColorScheme.primaryContainer),
  cardTheme: const CardTheme().copyWith(
      color: myColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: myColorScheme.primaryContainer)),
  textTheme: ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(
          fontWeight: FontWeight.normal,
          color: myColorScheme.onSecondaryContainer,
          fontSize: 24)),
  iconTheme: IconThemeData(color: myColorScheme.onPrimaryContainer),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: myDarkColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: myDarkColorScheme.onPrimaryContainer,
        foregroundColor: myDarkColorScheme.primaryContainer,
      actionsIconTheme: const IconThemeData(color: Colors.white),

    ),

    cardTheme: const CardTheme().copyWith(
        color: myDarkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
    drawerTheme:  const DrawerThemeData().copyWith(backgroundColor: myDarkColorScheme.onPrimaryContainer,),
    listTileTheme:  const ListTileThemeData().copyWith(
      iconColor:  Colors.white,
      textColor:Colors.white,

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: myDarkColorScheme.primaryContainer)),
    textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color:Colors.white,
            fontSize: 24)),
    iconTheme: IconThemeData(color:Colors.white),
    bottomSheetTheme: const BottomSheetThemeData()
        .copyWith(backgroundColor: myDarkColorScheme.onPrimaryContainer));
