import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Filter { glutenFree, vegan, vegetarian, lactoseFree }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier() : super({
    Filter.glutenFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
    Filter.lactoseFree: false,
  }) {
    loadFilters();
  }

  Future<void> loadFilters() async {
    final prefs = await SharedPreferences.getInstance();
    state = {
      Filter.glutenFree: prefs.getBool('glutenFree') ?? false,
      Filter.vegan: prefs.getBool('vegan') ?? false,
      Filter.vegetarian: prefs.getBool('vegetarian') ?? false,
      Filter.lactoseFree: prefs.getBool('lactoseFree') ?? false,
    };
  }

  Future<void> saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('glutenFree', state[Filter.glutenFree]!);
    await prefs.setBool('vegan', state[Filter.vegan]!);
    await prefs.setBool('vegetarian', state[Filter.vegetarian]!);
    await prefs.setBool('lactoseFree', state[Filter.lactoseFree]!);
  }

  void setFilter(Filter filter, bool value) {
    state = {...state, filter: value};
    saveFilters();
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});
