import 'package:flutter/material.dart';
import 'package:meals/modules/meals_screen.dart';

import '../models/meal_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key, required this.favouriteMeals,});

  final List<Meal> favouriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No favorite meals added yet.'),
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
