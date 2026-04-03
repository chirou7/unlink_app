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

  @override
  String get welcomeBack => 'Welcome back! Please enter your account';

  @override
  String get createAccount => 'Welcome! Please enter your account';

  @override
  String get emailHint => 'Email';

  @override
  String get nextStep => 'Next';

  @override
  String get termsPrefix => 'Registering means you accept ';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get andText => ' and ';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get period => '.';

  @override
  String get orders => 'Orders';

  @override
  String inUse(int used, int total) {
    return '$used / $total In use';
  }

  @override
  String get devices => 'Devices';

  @override
  String activated(int active, int total) {
    return '$active / $total Active';
  }

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get scanningNearbyDevices => 'Scanning nearby devices..';

  @override
  String get bringPhoneClose => 'Please bring your phone close to the device';

  @override
  String get keepDevicePoweredOn => 'Keep the device powered on and fully charged';

  @override
  String get addManually => 'Add manually';

  @override
  String get scanToAdd => 'Scan code to add';

  @override
  String get alertsTab => 'Alerts';

  @override
  String get messagesTab => 'Messages';

  @override
  String get noAlerts => 'No Alerts';

  @override
  String get noAlertsDesc => 'There are currently no alert notifications';

  @override
  String get noMessages => 'No Messages';

  @override
  String get noMessagesDesc => 'There are currently no message notifications';

  @override
  String get unitSettings => 'Unit Settings';

  @override
  String get tempUnit => 'Temperature Unit';

  @override
  String get mapSelection => 'Map';

  @override
  String get language => 'Language';

  @override
  String get logout => 'Log out';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get cancel => 'Cancel';

  @override
  String get googleMap => 'Google Maps';

  @override
  String get baiduMap => 'Baidu Map';

  @override
  String get celsius => 'Celsius ℃';

  @override
  String get fahrenheit => 'Fahrenheit ℉';

  @override
  String get noDeviceBound => 'No device bound';

  @override
  String get faq => 'FAQ';

  @override
  String get faqRegister => 'How to register an account?';

  @override
  String get faqResetPwd => 'How to reset password?';

  @override
  String get faqGeofence => 'Geofence management';

  @override
  String get faqBindDevice => 'How to bind a device?';

  @override
  String get faqShareDevice => 'Share device with family';

  @override
  String get faqUnbindDevice => 'How to unbind a device?';

  @override
  String get faqOrders => 'View Purchased Orders';

  @override
  String get faqAlertSettings => 'Alert settings';

  @override
  String get faqDeviceSettings => 'Device settings';

  @override
  String get feedbackButton => 'Feedback';

  @override
  String get serviceStatus => 'Service Status';

  @override
  String get statusAll => 'All';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusProcessing => 'Processing';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get noData => 'No Data';

  @override
  String get feedbackDescHint => 'Please describe the issue in detail so we can better assist you.';

  @override
  String get submit => 'Submit';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get appVersion => 'Version';

  @override
  String get findImeiSnHint => 'You can find the IMEI/SN on the back of the box or on the device';

  @override
  String get enterImeiSn => 'Enter IMEI/SN';
}
