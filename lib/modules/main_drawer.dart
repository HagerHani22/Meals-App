import 'package:flutter/material.dart';
import 'package:meals/modules/provider/language_provider.dart';
import 'package:meals/modules/provider/theme_provider.dart';
import 'package:provider/provider.dart' as provider; // Alias provider package

import '../app_localization/localization.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen(
      {super.key,
      required this.onSelectScreen,
      required this.toggleTheme,
      required this.isDark});
  final void Function(String identifier) onSelectScreen;
  final void Function() toggleTheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final appLanguage = provider.Provider.of<AppLanguageProvider>(context);
    final GlobalKey popupMenuKey = GlobalKey();
    final themeProvider = provider.Provider.of<ThemeProvider>(context);

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
            onSelectScreen('Filters');
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
                  color: themeProvider.isDark ? Theme.of(context).colorScheme.inversePrimary:Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        ListTile(
          onTap: () {
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
                      groupValue: appLanguage.appLocal.languageCode == 'en' ? 1 : 0,
                      onChanged: (value) {
              appLanguage.changeLanguage(const Locale("en"));
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
                      groupValue: appLanguage.appLocal.languageCode == 'ar' ? 2 : 0,
                      onChanged: (value) {
                        appLanguage.changeLanguage(const Locale("ar"));
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
                      groupValue: appLanguage.appLocal.languageCode == 'fr' ? 3 : 0,
                      onChanged: (value) {
                     appLanguage.changeLanguage(const Locale("fr"));
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
                  color: themeProvider.isDark ? Theme.of(context).colorScheme.inversePrimary:Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        ListTile(
          onTap:  () {
            toggleTheme();
            Navigator.pop(context);
          },
          leading: Icon(
            themeProvider.isDark ?  Icons.light_mode:Icons.nights_stay ,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            themeProvider.isDark ?AppLocalizations.of(context)!.translate('Light Mode') ?? 'Light Mode':AppLocalizations.of(context)!.translate('Dark Mode') ?? 'Dark Mode',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: themeProvider.isDark ? Theme.of(context).colorScheme.inversePrimary:Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    ));
  }
}
