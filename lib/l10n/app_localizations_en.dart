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

  @override
  String get deviceName => 'Device Name';

  @override
  String get shareDeviceTitle => 'Share Device';

  @override
  String get noSharedMembers => 'No shared members';

  @override
  String get sharedMembersCanView => 'Shared members can view the device';

  @override
  String get addSharedMember => 'Add shared member';

  @override
  String get alertSettingsTitle => 'Alert Settings';

  @override
  String get stopCharging => 'Stop Charging';

  @override
  String get startCharging => 'Start Charging';

  @override
  String get outOfFenceAlert => 'Out of fence alert (Bluetooth)';

  @override
  String get inFenceAlert => 'In fence alert (Bluetooth)';

  @override
  String get stopMoving => 'Stop moving';

  @override
  String get startMoving => 'Start moving';

  @override
  String get enterFence => 'Enter fence';

  @override
  String get leaveFence => 'Leave fence';

  @override
  String get devicePowerOn => 'Device powered on';

  @override
  String get bluetoothConnected => 'Bluetooth connected';

  @override
  String get bluetoothDisconnected => 'Bluetooth disconnected';

  @override
  String get devicePowerOff => 'Device powered off';

  @override
  String get deviceActivated => 'Device activated';

  @override
  String get deviceSettingsTitle => 'Device Settings';

  @override
  String get findPetMode => 'Find Pet Mode Settings';

  @override
  String get findPetModeDesc => 'Location updates faster in Find Pet Mode to help you quickly find your pet, battery life will be shortened accordingly';

  @override
  String get soundSettings => 'Sound Settings';

  @override
  String get soundSettingsDesc => 'Device sound settings';

  @override
  String get timesSuffix => 'times';

  @override
  String get lightSettings => 'Light Settings';

  @override
  String get lightSettingsDesc => 'Set light parameters';

  @override
  String get powerSavingMode => 'Power Saving Mode';

  @override
  String get sleepSettings => 'Sleep Settings';

  @override
  String get sleepSettingsDesc => 'When enabled, the device enters sleep mode during the set time range. The device is offline during sleep, and device activity will automatically exit sleep mode.';

  @override
  String get deviceSelfTest => 'Device Self-test';

  @override
  String get bluetoothFirmwareUpgrade => 'Bluetooth Firmware Upgrade';

  @override
  String get duration => 'Duration';

  @override
  String get durationDesc => 'Find Pet Mode duration, automatically exits after time is up';

  @override
  String get updateInterval => 'Update Interval';

  @override
  String get updateIntervalDesc => 'Location update interval, shorter time means faster updates';

  @override
  String minute(int count) {
    return '$count min';
  }

  @override
  String second(int count) {
    return '$count sec';
  }

  @override
  String get lightColor => 'Light Color';

  @override
  String get lightColorDesc => 'Set light color';

  @override
  String get flashMode => 'Flash Mode';

  @override
  String get flashModeDesc => 'Set light flash frequency';

  @override
  String get flashCount => 'Flash Count';

  @override
  String get flashCountDesc => 'Set the number of times the light flashes, the larger the value, the longer the flashing time';

  @override
  String get colorRainbow => 'Rainbow Flashing';

  @override
  String get colorRed => 'Red Light';

  @override
  String get colorOrange => 'Orange Light';

  @override
  String get colorYellow => 'Yellow Light';

  @override
  String get colorGreen => 'Green Light';

  @override
  String get flashBreathing => 'Breathing';

  @override
  String get flashSlow => 'Slow Flash';

  @override
  String get flashFast => 'Burst Flash';

  @override
  String times(int count) {
    return '$count times';
  }

  @override
  String get sleepSwitch => 'Sleep Switch';

  @override
  String get sleepSwitchDesc => 'Control sleep mode on and off';

  @override
  String get startTime => 'Start Time';

  @override
  String get startTimeDesc => 'Sleep start time, device will automatically enter sleep mode at this time';

  @override
  String get endTime => 'End Time';

  @override
  String get endTimeDesc => 'Sleep end time, device will automatically exit sleep mode at this time';

  @override
  String get selectTime => 'Select';

  @override
  String get deviceCheckTitle => 'Device Self-test';

  @override
  String get startCheck => 'Start';

  @override
  String get checkDesc => 'Click start to run device self-test, which helps diagnose potential issues';

  @override
  String get currentVersion => 'Current Version';

  @override
  String get versionUpToDate => 'Version is up to date';

  @override
  String get petName => 'Pet Name';

  @override
  String get petBreed => 'Breed';

  @override
  String get petGender => 'Gender';

  @override
  String get petBirthday => 'Birthday';

  @override
  String get petWeight => 'Weight';

  @override
  String get petHeight => 'Height';

  @override
  String get petLength => 'Length';

  @override
  String get petNeutered => 'Neutered';

  @override
  String get petVaccination => 'Vaccination';

  @override
  String get confirm => 'Confirm';

  @override
  String get skip => 'Skip';

  @override
  String get selectHint => 'Select';

  @override
  String get enterHint => 'Enter';

  @override
  String get save => 'Save';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get pleaseEnter => 'Please enter';

  @override
  String get vacNotVaccinated => 'Not Vaccinated';

  @override
  String get vacVaccinated => 'Vaccinated';

  @override
  String get vaccinationDate => 'Vaccination Date';

  @override
  String get forgotVaccinationTime => 'Forgot vaccination time?';

  @override
  String get yearSuffix => '';

  @override
  String get monthSuffix => '';

  @override
  String get daySuffix => '';

  @override
  String get selectBreed => 'Select Breed';

  @override
  String get tabDog => '🐶 Dog';

  @override
  String get tabCat => '🐱 Cat';

  @override
  String get searchBreedHint => 'Search breed/alias/pinyin';

  @override
  String get hotRecommendation => '🔥 Hot Recommendation';

  @override
  String get allBreeds => '🗂 All Breeds';

  @override
  String get searchEmptyHint => 'No matching breed found, you can:';

  @override
  String get selectMixedBreed => 'Select Mixed Breed';

  @override
  String get selectUnknownBreed => 'Select Unknown Breed';

  @override
  String get finish => 'Finish';

  @override
  String get activationSuccessGreeting1 => 'Hello ';

  @override
  String get activationSuccessGreeting2 => '! Your device is activated.';

  @override
  String get virtualPet => 'Virtual Pet';

  @override
  String get newBadge => 'New';

  @override
  String get addPet => 'Add Pet';

  @override
  String get bluetoothPositioning => 'Bluetooth Positioning';

  @override
  String minutesAgo(int minutes) {
    return '$minutes mins ago';
  }

  @override
  String get today => 'Today';

  @override
  String get goal => 'Goal';

  @override
  String get activity => 'Activity';

  @override
  String get minutes => 'mins';

  @override
  String get calories => 'Calories';

  @override
  String get kcal => 'kcal';

  @override
  String get rest => 'Rest';

  @override
  String get hours => 'h';

  @override
  String get steps => 'Steps';

  @override
  String get trajectory => 'Trajectory';

  @override
  String get stayTime => 'Stay time';

  @override
  String get geofence => 'Geofence';

  @override
  String get viewAll => 'View all';

  @override
  String get noGeofenceCreated => 'No geofence created';

  @override
  String get createNew => 'Create new';

  @override
  String get light => 'Light';

  @override
  String get sound => 'Sound';

  @override
  String get findPet => 'Find Pet';

  @override
  String get gps => 'GPS';

  @override
  String get now => 'Now';

  @override
  String get homeTab => 'Home';

  @override
  String get healthTab => 'Health';

  @override
  String get petTab => 'Pet';

  @override
  String get sun => 'Sun';

  @override
  String get mon => 'Mon';

  @override
  String get tue => 'Tue';

  @override
  String get wed => 'Wed';

  @override
  String get thu => 'Thu';

  @override
  String get fri => 'Fri';

  @override
  String get sat => 'Sat';

  @override
  String get progress => 'Progress';

  @override
  String get caloriesDesc => 'Calories are calculated based on your pet\'s breed, age, weight, and real-time steps to provide the most accurate estimate of actual energy expenditure.';

  @override
  String get selectAction => 'Select';

  @override
  String ageMonths(int months) {
    return '$months mo';
  }

  @override
  String ageYears(int years) {
    return '$years yr';
  }

  @override
  String ageYearsMonths(int years, int months) {
    return '${years}y ${months}m';
  }
}
