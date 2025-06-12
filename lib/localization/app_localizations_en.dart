// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get about => 'About';

  @override
  String get close => 'Close';

  @override
  String get reload => 'Reload';

  @override
  String get settings => 'Settings';

  @override
  String get acknowledgements => 'Acknowledgements';

  @override
  String get feedback => 'Feedback';

  @override
  String get kagiSearch => 'Kagi Search';

  @override
  String get developedWithLove => 'Developed with love by';

  @override
  String get appVersion => 'App Version';

  @override
  String get userActionItems => 'User Action Items';

  @override
  String get didYouKnow => 'Did you know?';

  @override
  String get technicalDetails => 'Technical Details';

  @override
  String get industryImpact => 'Industry Impact';

  @override
  String get gameplayMechanics => 'Gameplay Mechanics';

  @override
  String get destinationHighlights => 'Destination Highlights';

  @override
  String get timelineOfEvents => 'Timeline of Events';

  @override
  String get historicalBackground => 'Historical Background';

  @override
  String get humanitarianImpact => 'Humanitarian Impact';

  @override
  String get perspectives => 'Perspectives';

  @override
  String get highlights => 'Highlights';

  @override
  String get showMore => 'Show More';

  @override
  String get showLess => 'Show Less';

  @override
  String get sources => 'Sources';

  @override
  String numberOfArticles(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString articles',
      one: '1 article',
      zero: 'no articles',
    );
    return '$_temp0';
  }
}
