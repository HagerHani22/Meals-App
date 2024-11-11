import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/modules/provider/favourite_provider.dart';
import 'package:meals/modules/provider/theme_provider.dart';
import 'package:provider/provider.dart' as provider; // Alias provider package
import '../app_localization/localization.dart';
import 'meals_screen.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavourite = ref.watch(favouriteMealsProvider).any((element) => element.id == meal.id);
    final themeProvider = provider.Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text( AppLocalizations.of(context)!.translate(meal.title) ?? meal.title),
        actions: [
          IconButton(
              onPressed: () {
                ref
                    .read(favouriteMealsProvider.notifier)
                    .toggleMealFavouriteStatus(meal);
              },
              icon: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: isFavourite ? Colors.red : Colors.white,

              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                meal.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.contain,

              ),
               Text(
                AppLocalizations.of(context)!.translate('Ingredients : ') ?? 'Ingredients : ',
                style:  TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDark ? Theme.of(context).colorScheme.inversePrimary:Colors.black,
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  color: HexColor('FEF6E4'),
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < meal.ingredients.length; i++)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              '${formatNumberBasedOnLocale(context, i + 1)}-${AppLocalizations.of(context)!.translate(meal.ingredients[i]) ?? meal.ingredients[i]}',)
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
               Text(
                AppLocalizations.of(context)!.translate( 'Steps : ') ?? 'Steps : ',
                style:  TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                    color: themeProvider.isDark ? Theme.of(context).colorScheme.inversePrimary:Colors.black),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  color: HexColor('FEF6E4'),
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < meal.steps.length; i++)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '${formatNumberBasedOnLocale(context, i + 1)}- ${AppLocalizations.of(context)!.translate(meal.steps[i]) ?? meal.steps[i]}',)
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
