import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

// Wrappers for strings that are shown in the UI.
// The strings can be translated for different locales using the Dart intl package.
//
// Locale-specific values for the strings live in the i18n/*.arb files.
//
// To generate the lang_messages_*.dart files from the ARB files, run:
//   pub run intl:generate_from_arb \
//     --output-dir=lib/i18n --generated-file-prefix=lang_ --no-use-deferred-loading \
//     lib/strings.dart lib/i18n/lang_*.arb

class Lang extends LocaleQueryData {

  static Lang of(BuildContext context) {
    return LocaleQuery.of(context);
  }

  static final instance = new Lang();

  String title()          => Intl.message('Financial Note', name: 'title');
  String titleSettings()  => Intl.message('Settings',       name: 'titleSettings');

  String drawerHome()     => Intl.message('Home',                 name: 'drawerHome');
  String drawerSettings() => Intl.message('Settings',             name: 'drawerSettings');
  String drawerHelp()     => Intl.message('Help & Feedback',      name: 'drawerHelp');
  String drawerAbout()    => Intl.message('About Financial Note', name: 'drawerAbout');

  String menuSearch()     => Intl.message('Search', name: 'menuSearch');

  String prefUseDark()    => Intl.message('Use Dark Theme', name: 'prefUseDark');
}
