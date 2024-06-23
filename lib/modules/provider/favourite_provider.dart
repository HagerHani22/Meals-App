import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/meal_model.dart';


//Add dataMeal

final mealsProvider = Provider((ref) => dummyMeals);




//Add FavouriteMeals
class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  void toggleMealFavouriteStatus(Meal meal) {
    final isExisting = state.contains(meal);
    if (isExisting) {
      // state.remove(meal);
      state = state.where((element) => element.id != meal.id).toList();
    } else {
      state = [...state, meal];
      // state.add(meal);
    }
    saveFavoriteMeals();
  }


  // Load favorite meals from SharedPreferences
  Future<void> loadFavoriteMeals() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteMealsJson = prefs.getString('favoriteMeals');
      if (favoriteMealsJson != null) {
        final List<dynamic> favoriteMealsList = json.decode(favoriteMealsJson);
        state = favoriteMealsList.map((e) => Meal.fromJson(e)).toList();
      }
    } catch (e) {
      print('Failed to load favorite meals: $e');
    }
  }

  // Save favorite meals to SharedPreferences
  Future<void> saveFavoriteMeals() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteMealsJson = json.encode(state.map((e) => e.toJson()).toList());
      await prefs.setString('favoriteMeals', favoriteMealsJson);
    } catch (e) {
      print('Failed to save favorite meals: $e');
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
      final provider = FavouriteMealsNotifier();
      provider.loadFavoriteMeals();
      return provider;
    });





