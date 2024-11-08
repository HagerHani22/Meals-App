import 'package:flutter/material.dart';
import 'package:meals/modules/provider/app_language.dart';
import 'package:provider/provider.dart' as provider; // Alias provider package
import 'package:shared_preferences/shared_preferences.dart';

import '../app_localization/localization.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen(
      {super.key,
      required this.onSelectScreen,
      required this.toggleTheme,
      required this.isDark});
  final void Function(String identifier) onSelectScreen;
  final void Function() toggleTheme;
  final bool isDark;
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late AppLanguageProvider appLanguage;

  int _selectedLanguage = 1; // Default language option

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage(); // Load saved language on widget initialization
  }

  // Load the selected language from SharedPreferences
  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getInt('selectedLanguage') ??
          1; // Default to English if none saved
    });
  }

  // Save the selected language in SharedPreferences and update state
  Future<void> _changeLanguage(int value, Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedLanguage', value); // Save language choice

    setState(() {
      _selectedLanguage = value; // Update UI with selected language
    });

    appLanguage.changeLanguage(locale); // Change app language
  }

  @override
  Widget build(BuildContext context) {
    appLanguage = provider.Provider.of<AppLanguageProvider>(context);
    final GlobalKey popupMenuKey = GlobalKey();

    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                AppLocalizations.of(context)!.translate('Cooking Up!') ??
                    'Cooking Up!',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
            ],
          ),
        ),
        // ListTile(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   leading: Icon(
        //     Icons.restaurant,
        //     size: 28,
        //     color: Theme.of(context).colorScheme.primary,
        //   ),
        //   title: Text(
        //     AppLocalizations.of(context)!.translate('Meals') ?? 'Meals',
        //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
        //           color: Theme.of(context).colorScheme.secondary,
        //         ),
        //   ),
        // ),
        ListTile(
          onTap: () {
            widget.onSelectScreen('Filters');
            // Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen(),));
          },
          leading: Icon(
            Icons.filter_alt,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            AppLocalizations.of(context)!.translate('Filters') ?? 'Filters',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        ListTile(
          onTap: () {
            // Open the popup menu when the ListTile is tapped
            final dynamic popupMenu = popupMenuKey.currentState;
            popupMenu?.showButtonMenu();
          },
          trailing: PopupMenuButton<int>(
            popUpAnimationStyle: AnimationStyle(
              curve: Curves.easeInQuad,
              duration: const Duration(milliseconds: 1000),
            ),
            key: popupMenuKey,
            color: Colors.white,
            icon: const Icon(Icons.arrow_drop_down_sharp),
            itemBuilder: (context) => [
              // PopupMenuItem 1 - English
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Radio<int>(
                      value: 1,
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        _changeLanguage(1, const Locale("en"));
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text("English"),
                  ],
                ),
              ),
              // PopupMenuItem 2 - Arabic
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Radio<int>(
                      value: 2,
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        _changeLanguage(2, const Locale("ar"));
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text("Arabic"),
                  ],
                ),
              ),
              // PopupMenuItem 3 - French
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: <Widget>[
                    Radio<int>(
                      value: 3,
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        _changeLanguage(3, const Locale("fr"));
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text("French"),
                  ],
                ),
              ),
            ],
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                appLanguage.changeLanguage(const Locale("en"));
              } else if (value == 2) {
                appLanguage.changeLanguage(const Locale("ar"));
              } else if (value == 3) {
                appLanguage.changeLanguage(const Locale("fr"));
              }
            },
          ),
          leading: Icon(
            Icons.language,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            AppLocalizations.of(context)!.translate('Language') ?? 'Language',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        ListTile(
          onTap:  () {
            widget.toggleTheme();
            setState(() {});  // Ensure this widget rebuilds to reflect the change

            Navigator.pop(context);
          },
          leading: Icon(
            widget.isDark ? Icons.nights_stay : Icons.light_mode,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
    widget.isDark ?AppLocalizations.of(context)!.translate('Dark') ?? 'Dark':AppLocalizations.of(context)!.translate('Light') ?? 'Light',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    ));
  }
}
