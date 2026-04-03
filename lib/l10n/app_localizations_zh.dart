// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Unlink App';

  @override
  String greeting(String name) {
    return '你好！ $name';
  }

  @override
  String get newDayStarted => '新的一天已开始';

  @override
  String get myDevices => '我的设备';

  @override
  String deviceCount(int count) {
    return '共$count台设备';
  }

  @override
  String get noDeviceYet => '还没有设备';

  @override
  String get addDevice => '添加';

  @override
  String get register => '注册';

  @override
  String get login => '登录';

  @override
  String get deviceInfo => '设备信息';

  @override
  String get petInfo => '宠物信息';

  @override
  String get deviceShare => '设备分享';

  @override
  String get alertSettings => '报警设置';

  @override
  String get otherSettings => '其他设置';

  @override
  String get helpAndFeedback => '帮助与反馈';

  @override
  String get unbind => '解绑';

  @override
  String modelLabel(String model) {
    return '型号: $model';
  }

  @override
  String copied(String label) {
    return '$label 已复制';
  }

  @override
  String get subscriptionPlan => '免费 - 随货导入-首年套餐';

  @override
  String expireTime(String date) {
    return '到期时间 $date';
  }

  @override
  String get enterEmail => '请输入您的邮箱';

  @override
  String get continueAction => '继续';
}
