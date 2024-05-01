import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pokedex/presentation/common/localization/app_localizations.dart';
import 'package:flutter_pokedex/presentation/navigation/navigation_routes.dart';

import 'di/app_modules.dart';
import 'presentation/common/resources/app_styles.dart';

void main() {
  AppModules().setup(); // Setup dependency injection
  runApp(const Pokedex());
}

class Pokedex extends StatelessWidget {
  const Pokedex({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp.router(
      title: 'Pokedex',
      theme: AppStyles.appTheme,
      themeMode: ThemeMode.light, // Enable automatic dark theme support
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.app_title,
      debugShowCheckedModeBanner: false,
    );
  }
}
