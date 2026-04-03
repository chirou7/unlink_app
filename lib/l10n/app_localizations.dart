import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlink App'**
  String get appTitle;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello! {name}'**
  String greeting(String name);

  /// No description provided for @newDayStarted.
  ///
  /// In en, this message translates to:
  /// **'A new day has started'**
  String get newDayStarted;

  /// No description provided for @myDevices.
  ///
  /// In en, this message translates to:
  /// **'My Devices'**
  String get myDevices;

  /// No description provided for @deviceCount.
  ///
  /// In en, this message translates to:
  /// **'{count} device(s) in total'**
  String deviceCount(int count);

  /// No description provided for @noDeviceYet.
  ///
  /// In en, this message translates to:
  /// **'No device yet'**
  String get noDeviceYet;

  /// No description provided for @addDevice.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addDevice;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @deviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Info'**
  String get deviceInfo;

  /// No description provided for @petInfo.
  ///
  /// In en, this message translates to:
  /// **'Pet Info'**
  String get petInfo;

  /// No description provided for @deviceShare.
  ///
  /// In en, this message translates to:
  /// **'Device Share'**
  String get deviceShare;

  /// No description provided for @alertSettings.
  ///
  /// In en, this message translates to:
  /// **'Alert Settings'**
  String get alertSettings;

  /// No description provided for @otherSettings.
  ///
  /// In en, this message translates to:
  /// **'Other Settings'**
  String get otherSettings;

  /// No description provided for @helpAndFeedback.
  ///
  /// In en, this message translates to:
  /// **'Help & Feedback'**
  String get helpAndFeedback;

  /// No description provided for @unbind.
  ///
  /// In en, this message translates to:
  /// **'Unbind'**
  String get unbind;

  /// No description provided for @modelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model: {model}'**
  String modelLabel(String model);

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'{label} copied'**
  String copied(String label);

  /// No description provided for @subscriptionPlan.
  ///
  /// In en, this message translates to:
  /// **'Free - First Year Plan'**
  String get subscriptionPlan;

  /// No description provided for @expireTime.
  ///
  /// In en, this message translates to:
  /// **'Expires on {date}'**
  String expireTime(String date);

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enterEmail;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Please enter your account'**
  String get welcomeBack;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Welcome! Please enter your account'**
  String get createAccount;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextStep;

  /// No description provided for @termsPrefix.
  ///
  /// In en, this message translates to:
  /// **'Registering means you accept '**
  String get termsPrefix;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @andText.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get andText;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get period;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @inUse.
  ///
  /// In en, this message translates to:
  /// **'{used} / {total} In use'**
  String inUse(int used, int total);

  /// No description provided for @devices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get devices;

  /// No description provided for @activated.
  ///
  /// In en, this message translates to:
  /// **'{active} / {total} Active'**
  String activated(int active, int total);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @scanningNearbyDevices.
  ///
  /// In en, this message translates to:
  /// **'Scanning nearby devices..'**
  String get scanningNearbyDevices;

  /// No description provided for @bringPhoneClose.
  ///
  /// In en, this message translates to:
  /// **'Please bring your phone close to the device'**
  String get bringPhoneClose;

  /// No description provided for @keepDevicePoweredOn.
  ///
  /// In en, this message translates to:
  /// **'Keep the device powered on and fully charged'**
  String get keepDevicePoweredOn;

  /// No description provided for @addManually.
  ///
  /// In en, this message translates to:
  /// **'Add manually'**
  String get addManually;

  /// No description provided for @scanToAdd.
  ///
  /// In en, this message translates to:
  /// **'Scan code to add'**
  String get scanToAdd;

  /// No description provided for @alertsTab.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get alertsTab;

  /// No description provided for @messagesTab.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesTab;

  /// No description provided for @noAlerts.
  ///
  /// In en, this message translates to:
  /// **'No Alerts'**
  String get noAlerts;

  /// No description provided for @noAlertsDesc.
  ///
  /// In en, this message translates to:
  /// **'There are currently no alert notifications'**
  String get noAlertsDesc;

  /// No description provided for @noMessages.
  ///
  /// In en, this message translates to:
  /// **'No Messages'**
  String get noMessages;

  /// No description provided for @noMessagesDesc.
  ///
  /// In en, this message translates to:
  /// **'There are currently no message notifications'**
  String get noMessagesDesc;

  /// No description provided for @unitSettings.
  ///
  /// In en, this message translates to:
  /// **'Unit Settings'**
  String get unitSettings;

  /// No description provided for @tempUnit.
  ///
  /// In en, this message translates to:
  /// **'Temperature Unit'**
  String get tempUnit;

  /// No description provided for @mapSelection.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapSelection;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @googleMap.
  ///
  /// In en, this message translates to:
  /// **'Google Maps'**
  String get googleMap;

  /// No description provided for @baiduMap.
  ///
  /// In en, this message translates to:
  /// **'Baidu Map'**
  String get baiduMap;

  /// No description provided for @celsius.
  ///
  /// In en, this message translates to:
  /// **'Celsius ℃'**
  String get celsius;

  /// No description provided for @fahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Fahrenheit ℉'**
  String get fahrenheit;

  /// No description provided for @noDeviceBound.
  ///
  /// In en, this message translates to:
  /// **'No device bound'**
  String get noDeviceBound;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @faqRegister.
  ///
  /// In en, this message translates to:
  /// **'How to register an account?'**
  String get faqRegister;

  /// No description provided for @faqResetPwd.
  ///
  /// In en, this message translates to:
  /// **'How to reset password?'**
  String get faqResetPwd;

  /// No description provided for @faqGeofence.
  ///
  /// In en, this message translates to:
  /// **'Geofence management'**
  String get faqGeofence;

  /// No description provided for @faqBindDevice.
  ///
  /// In en, this message translates to:
  /// **'How to bind a device?'**
  String get faqBindDevice;

  /// No description provided for @faqShareDevice.
  ///
  /// In en, this message translates to:
  /// **'Share device with family'**
  String get faqShareDevice;

  /// No description provided for @faqUnbindDevice.
  ///
  /// In en, this message translates to:
  /// **'How to unbind a device?'**
  String get faqUnbindDevice;

  /// No description provided for @faqOrders.
  ///
  /// In en, this message translates to:
  /// **'View Purchased Orders'**
  String get faqOrders;

  /// No description provided for @faqAlertSettings.
  ///
  /// In en, this message translates to:
  /// **'Alert settings'**
  String get faqAlertSettings;

  /// No description provided for @faqDeviceSettings.
  ///
  /// In en, this message translates to:
  /// **'Device settings'**
  String get faqDeviceSettings;

  /// No description provided for @feedbackButton.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedbackButton;

  /// No description provided for @serviceStatus.
  ///
  /// In en, this message translates to:
  /// **'Service Status'**
  String get serviceStatus;

  /// No description provided for @statusAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get statusAll;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get statusProcessing;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @feedbackDescHint.
  ///
  /// In en, this message translates to:
  /// **'Please describe the issue in detail so we can better assist you.'**
  String get feedbackDescHint;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersion;

  /// No description provided for @findImeiSnHint.
  ///
  /// In en, this message translates to:
  /// **'You can find the IMEI/SN on the back of the box or on the device'**
  String get findImeiSnHint;

  /// No description provided for @enterImeiSn.
  ///
  /// In en, this message translates to:
  /// **'Enter IMEI/SN'**
  String get enterImeiSn;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
