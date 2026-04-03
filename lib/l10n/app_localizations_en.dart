// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Unlink App';

  @override
  String greeting(String name) {
    return 'Hello! $name';
  }

  @override
  String get newDayStarted => 'A new day has started';

  @override
  String get myDevices => 'My Devices';

  @override
  String deviceCount(int count) {
    return '$count device(s) in total';
  }

  @override
  String get noDeviceYet => 'No device yet';

  @override
  String get addDevice => 'Add';

  @override
  String get register => 'Register';

  @override
  String get login => 'Login';

  @override
  String get deviceInfo => 'Device Info';

  @override
  String get petInfo => 'Pet Info';

  @override
  String get deviceShare => 'Device Share';

  @override
  String get alertSettings => 'Alert Settings';

  @override
  String get otherSettings => 'Other Settings';

  @override
  String get helpAndFeedback => 'Help & Feedback';

  @override
  String get unbind => 'Unbind';

  @override
  String modelLabel(String model) {
    return 'Model: $model';
  }

  @override
  String copied(String label) {
    return '$label copied';
  }

  @override
  String get subscriptionPlan => 'Free - First Year Plan';

  @override
  String expireTime(String date) {
    return 'Expires on $date';
  }

  @override
  String get enterEmail => 'Please enter your email';

  @override
  String get continueAction => 'Continue';
}
