import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meals/modules/meal_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

import '../app_localization/localization.dart';
import '../models/meal_model.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});
  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate(title)??title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: meals.map((meal) => mealsItems(meal, context)).toList(),
        ),
      ),
    );
  }
}


Widget mealsItems(Meal meal, context) {
  final arabicDuration = formatNumberBasedOnLocale(context, meal.duration);
  final localizedMin = AppLocalizations.of(context)!.translate('min') ?? 'min';

  final displayText = '$arabicDuration $localizedMin';
  return Card(
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailsScreen(
                meal: meal,
              ),
            ));
      },
      child: Column(
        children: [
          Stack(
            children: [
              // FadeInImage(placeholder: AssetImage(), image: NetworkImage())
              FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl)),
              // Image.network(meal.imageUrl),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  color: Colors.white70,
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate(meal.title)?? meal.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            color: Colors.white,
            height: 60,
            child: Row(
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.watch_later_outlined,
                      color: Colors.black,
                    ),
                    label: Text(displayText,
  // AppLocalizations.of(context)!.translate('${meal.duration} ${AppLocalizations.of(context)!.translate('min')}',) ?? '${meal.duration} min',
                      style: const TextStyle(color: Colors.black),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: Colors.black,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.translate(meal.complexity.name)?? meal.complexity.name,
                      style: const TextStyle(color: Colors.black),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_money,
                      color: Colors.black,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.translate(meal.affordability.name)?? meal.affordability.name,
                      style: const TextStyle(color: Colors.black),
                    )),
              ],
            ),
          )
        ],
      ),
    ),
  );
}


String formatNumberBasedOnLocale(BuildContext context, int number) {
  final locale = Localizations.localeOf(context).languageCode;

  if (locale == 'ar') {
    // Format number in Arabic numerals
    return NumberFormat("##", "ar_EG").format(number);
  } else {
    // Default English numerals
    return number.toString();
  }
}