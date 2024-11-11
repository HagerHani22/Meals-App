import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/modules/filter_screen.dart';
import 'package:meals/modules/provider/favourite_provider.dart';
import 'package:provider/provider.dart' as provider; // Alias provider package
import '../app_localization/localization.dart';
import '../models/meal_model.dart';
import '../modules/categories_screen.dart';
import '../modules/favourite_screen.dart';
import '../modules/main_drawer.dart';
import '../modules/provider/language_provider.dart';
import '../modules/provider/filter_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  final void Function() toggleTheme;
  final bool isDark;
  TabsScreen(this.toggleTheme, this.isDark, {super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int currentIndex = 0;
  late List<Widget> screens;
  late AppLanguageProvider appLanguage;

  List<String> titles = ['Categories', 'Favourites'];

  void selectPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void setScreen(identifier) {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filterProvider);
    final meals = ref.watch(mealsProvider);
    final List<Meal> availableMeals = meals.where((meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    final favouriteMeals = ref.watch(favouriteMealsProvider);
    screens = [
      CategoriesScreen(availableMeals: availableMeals),
      FavouriteScreen(favouriteMeals: favouriteMeals)
    ];
    appLanguage = provider.Provider.of<AppLanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(  AppLocalizations.of(context)!.translate(titles[currentIndex])??titles[currentIndex]),
      ),
      body: screens[currentIndex],
      drawer: DrawerScreen(
        onSelectScreen: setScreen, toggleTheme: widget.toggleTheme, isDark: widget.isDark ,

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: selectPage,
        items:  [
          BottomNavigationBarItem(
            icon: const Icon(Icons.set_meal),
            label:AppLocalizations.of(context)!.translate('Categories')??'Categories',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label:   AppLocalizations.of(context)!.translate('Favourites')??'Favourites',
          ),
        ],
      ),
    );
  }
}
