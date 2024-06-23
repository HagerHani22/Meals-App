import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key, required this.onSelectScreen});
final void Function(String identifier) onSelectScreen;
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(.5)
            ])),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood_sharp,
                  size: 80,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Cooking Up!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ],
            ),),
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          leading: Icon(
            Icons.restaurant,size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            'Meals',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            widget.onSelectScreen('Filters');
            // Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen(),));
          },
          leading: Icon(
            Icons.settings,size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            'Filters',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),

      ],
    ));
  }
}
