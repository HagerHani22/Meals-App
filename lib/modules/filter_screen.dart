import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/modules/provider/filter_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
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
              title: 'Gluten Free',
              subtitle: 'Only include gluten-free meals',
              filter: filters[Filter.glutenFree]!,
              onChange: (newValue) {
                ref.read(filterProvider.notifier).setFilter(Filter.glutenFree, newValue);
              },
            ),
            customSwitch(
              context: context,
              title: 'Vegan',
              subtitle: 'Only include vegan meals',
              filter: filters[Filter.vegan]!,
              onChange: (newValue) {
                ref.read(filterProvider.notifier).setFilter(Filter.vegan, newValue);
              },
            ),
            customSwitch(
              context: context,
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals',
              filter: filters[Filter.vegetarian]!,
              onChange: (newValue) {
                ref.read(filterProvider.notifier).setFilter(Filter.vegetarian, newValue);
              },
            ),
            customSwitch(
              context: context,
              title: 'Lactose Free',
              subtitle: 'Only include lactose-free meals',
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
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      value: filter,
      onChanged: onChange,
    );
  }
}
