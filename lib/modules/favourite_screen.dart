import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meals/modules/provider/theme_provider.dart';
import 'package:meals/modules/meals_screen.dart';

import '../app_localization/localization.dart';
import '../models/meal_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key, required this.favouriteMeals,});

  final List<Meal> favouriteMeals;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (favouriteMeals.isEmpty) {
      return  Scaffold(
        body: Center(
          child: Text( AppLocalizations.of(context)!.translate('No favorite meals added yet.')??'No favorite meals added yet.' ,
          style: TextStyle(color: themeProvider.isDark ? Theme.of(context).colorScheme.inversePrimary:Theme.of(context).colorScheme.onBackground),
          ),
        ),
      );
    }
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) =>
            mealsItems(favouriteMeals[index], context),
        itemCount: favouriteMeals.length,

      ),
    );
  }
}
