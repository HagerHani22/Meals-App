import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/modules/provider/filter_provider.dart';
import 'package:meals/modules/provider/theme_provider.dart';
import 'package:provider/provider.dart' as provider; // Alias provider package

import '../app_localization/localization.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('Filter')??'Filter'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(filters);
          return false;
        },
        child: Column(
          children: [
            customSwitch(
              context: context,
              title:  AppLocalizations.of(context)!.translate('Gluten Free')??'Gluten Free',
              subtitle: AppLocalizations.of(context)!.translate('Only include gluten-free meals')??'Only include gluten-free meals',
              filter: filters[Filter.glutenFree]!,
              onChange: (newValue) {
                ref.read(filterProvider.notifier).setFilter(Filter.glutenFree, newValue);
              },
            ),
            customSwitch(
              context: context,
              title: AppLocalizations.of(context)!.translate('Vegan')??'Vegan',
              subtitle: AppLocalizations.of(context)!.translate('Only include vegan meals')??'Only include vegan meals',
              filter: filters[Filter.vegan]!,
              onChange: (newValue) {
                ref.read(filterProvider.notifier).setFilter(Filter.vegan, newValue);
              },
            ),
            customSwitch(
              context: context,
              title: AppLocalizations.of(context)!.translate('Vegetarian')??'Vegetarian',
              subtitle: AppLocalizations.of(context)!.translate('Only include vegetarian meals')??'Only include vegetarian meals',
              filter: filters[Filter.vegetarian]!,
              onChange: (newValue) {
                ref.read(filterProvider.notifier).setFilter(Filter.vegetarian, newValue);
              },
            ),
            customSwitch(
              context: context,
              title: AppLocalizations.of(context)!.translate('Lactose Free')??'Lactose Free',
              subtitle: AppLocalizations.of(context)!.translate('Only include lactose-free meals')??'Only include lactose-free meals',
              filter: filters[Filter.lactoseFree]!,
              onChange: (newValue) {
                ref.read(filterProvider.notifier).setFilter(Filter.lactoseFree, newValue);
              },
            ),
          ],
        ),
      ),
    );
  }

  SwitchListTile customSwitch({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool filter,
    required Function(bool newValue) onChange,

  }) {
    final themeProvider = provider.Provider.of<ThemeProvider>(context);
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: themeProvider.isDark ? Theme.of(context).colorScheme.inversePrimary:Theme.of(context).colorScheme.onBackground,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: themeProvider.isDark ? Theme.of(context).colorScheme.inversePrimary:Theme.of(context).colorScheme.onBackground,
        ),
      ),
      value: filter,
      onChanged: onChange,
    );
  }
}
