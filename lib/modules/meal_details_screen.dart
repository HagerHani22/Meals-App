import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/modules/provider/favourite_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  MealDetailsScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavourite = ref.watch(favouriteMealsProvider).any((element) => element.id == meal.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                ref
                    .read(favouriteMealsProvider.notifier)
                    .toggleMealFavouriteStatus(meal);
              },
              icon: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: isFavourite ? Colors.red : Colors.black,
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
              const Text(
                'Ingredients : ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
                            child: Text('${i + 1}- ${meal.ingredients[i]}'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'steps : ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                            child: Text('${i + 1}- ${meal.steps[i]}'),
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
