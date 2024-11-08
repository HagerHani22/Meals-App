import 'package:flutter/material.dart';
import 'package:meals/modules/provider/app_language.dart';
import 'package:provider/provider.dart';

import '../app_localization/localization.dart';
import '../data/dummy_data.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';
import 'meals_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals,});
  final List<Meal> availableMeals;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        children: [
          for (final category in availableCategories)
            categoryGridItem(category, context,availableMeals),
        ],
      ),
    );
  }
}

Widget categoryGridItem(CategoryModel category, context,List<Meal> availableMeals ) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {

        final filteredMeal = availableMeals
            .where((element) => element.categories.contains(category.id))
            .toList();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MealsScreen(
            title: category.title,
            meals: filteredMeal,
          ),
        ));
      },
      borderRadius: BorderRadius.circular(12),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(.5),
                category.color.withOpacity(.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Center(
            child: Text(
              AppLocalizations.of(context)!.translate(category.title) ?? category.title,

          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        )),
      ),
    ),
  );
}
