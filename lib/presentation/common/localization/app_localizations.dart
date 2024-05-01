import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('es')
  ];

  /// No description provided for @app_title.
  ///
  /// In es, this message translates to:
  /// **'PokeApi'**
  String get app_title;

  /// No description provided for @home_title.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home_title;

  /// No description provided for @pokemon_title.
  ///
  /// In es, this message translates to:
  /// **'Pokémons'**
  String get pokemon_title;

  /// No description provided for @about_title.
  ///
  /// In es, this message translates to:
  /// **'Acerca de'**
  String get about_title;

  /// No description provided for @error_title.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get error_title;

  /// No description provided for @error_default.
  ///
  /// In es, this message translates to:
  /// **'Ha ocurrido un error.'**
  String get error_default;

  /// No description provided for @error_timeout.
  ///
  /// In es, this message translates to:
  /// **'Estamos experimentando algunos problemas temporales. Por favor, inténtelo de nuevo en unos minutos.'**
  String get error_timeout;

  /// No description provided for @error_no_internet.
  ///
  /// In es, this message translates to:
  /// **'No hay conexión a Internet. Comprueba tu conexión Wi-Fi o de datos móviles, por favor.'**
  String get error_no_internet;

  /// No description provided for @error_server.
  ///
  /// In es, this message translates to:
  /// **'Estamos experimentando algunos problemas en este momento. Por favor, vuelva de nuevo mas tarde.'**
  String get error_server;

  /// No description provided for @error_empty_field.
  ///
  /// In es, this message translates to:
  /// **'Este campo no puede estar vacío'**
  String get error_empty_field;

  /// No description provided for @action_ok.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get action_ok;

  /// No description provided for @action_cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get action_cancel;

  /// No description provided for @action_retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get action_retry;

  /// No description provided for @how_moves.
  ///
  /// In es, this message translates to:
  /// **'Cómo conseguir este movimiento'**
  String get how_moves;

  /// No description provided for @game.
  ///
  /// In es, this message translates to:
  /// **'Juego'**
  String get game;

  /// No description provided for @level.
  ///
  /// In es, this message translates to:
  /// **'Nivel'**
  String get level;

  /// No description provided for @source.
  ///
  /// In es, this message translates to:
  /// **'Fuente'**
  String get source;

  /// No description provided for @height.
  ///
  /// In es, this message translates to:
  /// **'Altura: '**
  String get height;

  /// No description provided for @weight.
  ///
  /// In es, this message translates to:
  /// **'Peso: '**
  String get weight;

  /// No description provided for @main_type.
  ///
  /// In es, this message translates to:
  /// **'Tipo principal:'**
  String get main_type;

  /// No description provided for @sec_type.
  ///
  /// In es, this message translates to:
  /// **'Tipo secundario:'**
  String get sec_type;

  /// No description provided for @pokemon_title_fav.
  ///
  /// In es, this message translates to:
  /// **'Pokémon Atrapados'**
  String get pokemon_title_fav;

  /// No description provided for @data_title.
  ///
  /// In es, this message translates to:
  /// **'Datos físicos'**
  String get data_title;

  /// No description provided for @stats_title.
  ///
  /// In es, this message translates to:
  /// **'Panel de Estadísticas'**
  String get stats_title;

  /// No description provided for @sprites_title.
  ///
  /// In es, this message translates to:
  /// **'Panel de imágenes'**
  String get sprites_title;

  /// No description provided for @abilities_title.
  ///
  /// In es, this message translates to:
  /// **'Panel de habilidades'**
  String get abilities_title;

  /// No description provided for @moves_title.
  ///
  /// In es, this message translates to:
  /// **'Movimientos'**
  String get moves_title;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
