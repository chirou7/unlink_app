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

  /// No description provided for @deviceName.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get deviceName;

  /// No description provided for @shareDeviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Device'**
  String get shareDeviceTitle;

  /// No description provided for @noSharedMembers.
  ///
  /// In en, this message translates to:
  /// **'No shared members'**
  String get noSharedMembers;

  /// No description provided for @sharedMembersCanView.
  ///
  /// In en, this message translates to:
  /// **'Shared members can view the device'**
  String get sharedMembersCanView;

  /// No description provided for @addSharedMember.
  ///
  /// In en, this message translates to:
  /// **'Add shared member'**
  String get addSharedMember;

  /// No description provided for @alertSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert Settings'**
  String get alertSettingsTitle;

  /// No description provided for @stopCharging.
  ///
  /// In en, this message translates to:
  /// **'Stop Charging'**
  String get stopCharging;

  /// No description provided for @startCharging.
  ///
  /// In en, this message translates to:
  /// **'Start Charging'**
  String get startCharging;

  /// No description provided for @outOfFenceAlert.
  ///
  /// In en, this message translates to:
  /// **'Out of fence alert (Bluetooth)'**
  String get outOfFenceAlert;

  /// No description provided for @inFenceAlert.
  ///
  /// In en, this message translates to:
  /// **'In fence alert (Bluetooth)'**
  String get inFenceAlert;

  /// No description provided for @stopMoving.
  ///
  /// In en, this message translates to:
  /// **'Stop moving'**
  String get stopMoving;

  /// No description provided for @startMoving.
  ///
  /// In en, this message translates to:
  /// **'Start moving'**
  String get startMoving;

  /// No description provided for @enterFence.
  ///
  /// In en, this message translates to:
  /// **'Enter fence'**
  String get enterFence;

  /// No description provided for @leaveFence.
  ///
  /// In en, this message translates to:
  /// **'Leave fence'**
  String get leaveFence;

  /// No description provided for @devicePowerOn.
  ///
  /// In en, this message translates to:
  /// **'Device powered on'**
  String get devicePowerOn;

  /// No description provided for @bluetoothConnected.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth connected'**
  String get bluetoothConnected;

  /// No description provided for @bluetoothDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth disconnected'**
  String get bluetoothDisconnected;

  /// No description provided for @devicePowerOff.
  ///
  /// In en, this message translates to:
  /// **'Device powered off'**
  String get devicePowerOff;

  /// No description provided for @deviceActivated.
  ///
  /// In en, this message translates to:
  /// **'Device activated'**
  String get deviceActivated;

  /// No description provided for @deviceSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Device Settings'**
  String get deviceSettingsTitle;

  /// No description provided for @findPetMode.
  ///
  /// In en, this message translates to:
  /// **'Find Pet Mode Settings'**
  String get findPetMode;

  /// No description provided for @findPetModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Location updates faster in Find Pet Mode to help you quickly find your pet, battery life will be shortened accordingly'**
  String get findPetModeDesc;

  /// No description provided for @soundSettings.
  ///
  /// In en, this message translates to:
  /// **'Sound Settings'**
  String get soundSettings;

  /// No description provided for @soundSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Device sound settings'**
  String get soundSettingsDesc;

  /// No description provided for @timesSuffix.
  ///
  /// In en, this message translates to:
  /// **'times'**
  String get timesSuffix;

  /// No description provided for @lightSettings.
  ///
  /// In en, this message translates to:
  /// **'Light Settings'**
  String get lightSettings;

  /// No description provided for @lightSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Set light parameters'**
  String get lightSettingsDesc;

  /// No description provided for @powerSavingMode.
  ///
  /// In en, this message translates to:
  /// **'Power Saving Mode'**
  String get powerSavingMode;

  /// No description provided for @sleepSettings.
  ///
  /// In en, this message translates to:
  /// **'Sleep Settings'**
  String get sleepSettings;

  /// No description provided for @sleepSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'When enabled, the device enters sleep mode during the set time range. The device is offline during sleep, and device activity will automatically exit sleep mode.'**
  String get sleepSettingsDesc;

  /// No description provided for @deviceSelfTest.
  ///
  /// In en, this message translates to:
  /// **'Device Self-test'**
  String get deviceSelfTest;

  /// No description provided for @bluetoothFirmwareUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Firmware Upgrade'**
  String get bluetoothFirmwareUpgrade;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @durationDesc.
  ///
  /// In en, this message translates to:
  /// **'Find Pet Mode duration, automatically exits after time is up'**
  String get durationDesc;

  /// No description provided for @updateInterval.
  ///
  /// In en, this message translates to:
  /// **'Update Interval'**
  String get updateInterval;

  /// No description provided for @updateIntervalDesc.
  ///
  /// In en, this message translates to:
  /// **'Location update interval, shorter time means faster updates'**
  String get updateIntervalDesc;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String minute(int count);

  /// No description provided for @second.
  ///
  /// In en, this message translates to:
  /// **'{count} sec'**
  String second(int count);

  /// No description provided for @lightColor.
  ///
  /// In en, this message translates to:
  /// **'Light Color'**
  String get lightColor;

  /// No description provided for @lightColorDesc.
  ///
  /// In en, this message translates to:
  /// **'Set light color'**
  String get lightColorDesc;

  /// No description provided for @flashMode.
  ///
  /// In en, this message translates to:
  /// **'Flash Mode'**
  String get flashMode;

  /// No description provided for @flashModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Set light flash frequency'**
  String get flashModeDesc;

  /// No description provided for @flashCount.
  ///
  /// In en, this message translates to:
  /// **'Flash Count'**
  String get flashCount;

  /// No description provided for @flashCountDesc.
  ///
  /// In en, this message translates to:
  /// **'Set the number of times the light flashes, the larger the value, the longer the flashing time'**
  String get flashCountDesc;

  /// No description provided for @colorRainbow.
  ///
  /// In en, this message translates to:
  /// **'Rainbow Flashing'**
  String get colorRainbow;

  /// No description provided for @colorRed.
  ///
  /// In en, this message translates to:
  /// **'Red Light'**
  String get colorRed;

  /// No description provided for @colorOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange Light'**
  String get colorOrange;

  /// No description provided for @colorYellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow Light'**
  String get colorYellow;

  /// No description provided for @colorGreen.
  ///
  /// In en, this message translates to:
  /// **'Green Light'**
  String get colorGreen;

  /// No description provided for @flashBreathing.
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get flashBreathing;

  /// No description provided for @flashSlow.
  ///
  /// In en, this message translates to:
  /// **'Slow Flash'**
  String get flashSlow;

  /// No description provided for @flashFast.
  ///
  /// In en, this message translates to:
  /// **'Burst Flash'**
  String get flashFast;

  /// No description provided for @times.
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String times(int count);

  /// No description provided for @sleepSwitch.
  ///
  /// In en, this message translates to:
  /// **'Sleep Switch'**
  String get sleepSwitch;

  /// No description provided for @sleepSwitchDesc.
  ///
  /// In en, this message translates to:
  /// **'Control sleep mode on and off'**
  String get sleepSwitchDesc;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @startTimeDesc.
  ///
  /// In en, this message translates to:
  /// **'Sleep start time, device will automatically enter sleep mode at this time'**
  String get startTimeDesc;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @endTimeDesc.
  ///
  /// In en, this message translates to:
  /// **'Sleep end time, device will automatically exit sleep mode at this time'**
  String get endTimeDesc;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectTime;

  /// No description provided for @deviceCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Device Self-test'**
  String get deviceCheckTitle;

  /// No description provided for @startCheck.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startCheck;

  /// No description provided for @checkDesc.
  ///
  /// In en, this message translates to:
  /// **'Click start to run device self-test, which helps diagnose potential issues'**
  String get checkDesc;

  /// No description provided for @currentVersion.
  ///
  /// In en, this message translates to:
  /// **'Current Version'**
  String get currentVersion;

  /// No description provided for @versionUpToDate.
  ///
  /// In en, this message translates to:
  /// **'Version is up to date'**
  String get versionUpToDate;

  /// No description provided for @petName.
  ///
  /// In en, this message translates to:
  /// **'Pet Name'**
  String get petName;

  /// No description provided for @petBreed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get petBreed;

  /// No description provided for @petGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get petGender;

  /// No description provided for @petBirthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get petBirthday;

  /// No description provided for @petWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get petWeight;

  /// No description provided for @petHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get petHeight;

  /// No description provided for @petLength.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get petLength;

  /// No description provided for @petNeutered.
  ///
  /// In en, this message translates to:
  /// **'Neutered'**
  String get petNeutered;

  /// No description provided for @petVaccination.
  ///
  /// In en, this message translates to:
  /// **'Vaccination'**
  String get petVaccination;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @selectHint.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectHint;

  /// No description provided for @enterHint.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enterHint;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter'**
  String get pleaseEnter;

  /// No description provided for @vacNotVaccinated.
  ///
  /// In en, this message translates to:
  /// **'Not Vaccinated'**
  String get vacNotVaccinated;

  /// No description provided for @vacVaccinated.
  ///
  /// In en, this message translates to:
  /// **'Vaccinated'**
  String get vacVaccinated;

  /// No description provided for @vaccinationDate.
  ///
  /// In en, this message translates to:
  /// **'Vaccination Date'**
  String get vaccinationDate;

  /// No description provided for @forgotVaccinationTime.
  ///
  /// In en, this message translates to:
  /// **'Forgot vaccination time?'**
  String get forgotVaccinationTime;

  /// No description provided for @yearSuffix.
  ///
  /// In en, this message translates to:
  /// **''**
  String get yearSuffix;

  /// No description provided for @monthSuffix.
  ///
  /// In en, this message translates to:
  /// **''**
  String get monthSuffix;

  /// No description provided for @daySuffix.
  ///
  /// In en, this message translates to:
  /// **''**
  String get daySuffix;

  /// No description provided for @selectBreed.
  ///
  /// In en, this message translates to:
  /// **'Select Breed'**
  String get selectBreed;

  /// No description provided for @tabDog.
  ///
  /// In en, this message translates to:
  /// **'🐶 Dog'**
  String get tabDog;

  /// No description provided for @tabCat.
  ///
  /// In en, this message translates to:
  /// **'🐱 Cat'**
  String get tabCat;

  /// No description provided for @searchBreedHint.
  ///
  /// In en, this message translates to:
  /// **'Search breed/alias/pinyin'**
  String get searchBreedHint;

  /// No description provided for @hotRecommendation.
  ///
  /// In en, this message translates to:
  /// **'🔥 Hot Recommendation'**
  String get hotRecommendation;

  /// No description provided for @allBreeds.
  ///
  /// In en, this message translates to:
  /// **'🗂 All Breeds'**
  String get allBreeds;

  /// No description provided for @searchEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'No matching breed found, you can:'**
  String get searchEmptyHint;

  /// No description provided for @selectMixedBreed.
  ///
  /// In en, this message translates to:
  /// **'Select Mixed Breed'**
  String get selectMixedBreed;

  /// No description provided for @selectUnknownBreed.
  ///
  /// In en, this message translates to:
  /// **'Select Unknown Breed'**
  String get selectUnknownBreed;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @activationSuccessGreeting1.
  ///
  /// In en, this message translates to:
  /// **'Hello '**
  String get activationSuccessGreeting1;

  /// No description provided for @activationSuccessGreeting2.
  ///
  /// In en, this message translates to:
  /// **'! Your device is activated.'**
  String get activationSuccessGreeting2;

  /// No description provided for @virtualPet.
  ///
  /// In en, this message translates to:
  /// **'Virtual Pet'**
  String get virtualPet;

  /// No description provided for @newBadge.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newBadge;

  /// No description provided for @addPet.
  ///
  /// In en, this message translates to:
  /// **'Add Pet'**
  String get addPet;

  /// No description provided for @bluetoothPositioning.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Positioning'**
  String get bluetoothPositioning;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} mins ago'**
  String minutesAgo(int minutes);

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'mins'**
  String get minutes;

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @kcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get kcal;

  /// No description provided for @rest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get rest;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get hours;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @trajectory.
  ///
  /// In en, this message translates to:
  /// **'Trajectory'**
  String get trajectory;

  /// No description provided for @stayTime.
  ///
  /// In en, this message translates to:
  /// **'Stay time'**
  String get stayTime;

  /// No description provided for @geofence.
  ///
  /// In en, this message translates to:
  /// **'Geofence'**
  String get geofence;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @noGeofenceCreated.
  ///
  /// In en, this message translates to:
  /// **'No geofence created'**
  String get noGeofenceCreated;

  /// No description provided for @createNew.
  ///
  /// In en, this message translates to:
  /// **'Create new'**
  String get createNew;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @findPet.
  ///
  /// In en, this message translates to:
  /// **'Find Pet'**
  String get findPet;

  /// No description provided for @gps.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get gps;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @healthTab.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get healthTab;

  /// No description provided for @petTab.
  ///
  /// In en, this message translates to:
  /// **'Pet'**
  String get petTab;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @caloriesDesc.
  ///
  /// In en, this message translates to:
  /// **'Calories are calculated based on your pet\'s breed, age, weight, and real-time steps to provide the most accurate estimate of actual energy expenditure.'**
  String get caloriesDesc;

  /// No description provided for @selectAction.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectAction;

  /// No description provided for @ageMonths.
  ///
  /// In en, this message translates to:
  /// **'{months} mo'**
  String ageMonths(int months);

  /// No description provided for @ageYears.
  ///
  /// In en, this message translates to:
  /// **'{years} yr'**
  String ageYears(int years);

  /// No description provided for @ageYearsMonths.
  ///
  /// In en, this message translates to:
  /// **'{years}y {months}m'**
  String ageYearsMonths(int years, int months);
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
