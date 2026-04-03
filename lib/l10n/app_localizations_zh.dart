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

  @override
  String get welcomeBack => '欢迎回来！请输入你的账号';

  @override
  String get createAccount => '欢迎！请输入你的账号';

  @override
  String get emailHint => '邮箱';

  @override
  String get nextStep => '下一步';

  @override
  String get termsPrefix => '注册即表示你接受';

  @override
  String get termsOfService => '服务条款';

  @override
  String get andText => '和';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get period => '。';

  @override
  String get orders => '订单';

  @override
  String inUse(int used, int total) {
    return '$used / $total 使用中';
  }

  @override
  String get devices => '设备';

  @override
  String activated(int active, int total) {
    return '$active / $total 激活';
  }

  @override
  String get settings => '设置';

  @override
  String get about => '关于';

  @override
  String get scanningNearbyDevices => '扫描附近设备..';

  @override
  String get bringPhoneClose => '请将手机靠近设备';

  @override
  String get keepDevicePoweredOn => '保持设备开机并充满电';

  @override
  String get addManually => '手动添加';

  @override
  String get scanToAdd => '扫码添加';

  @override
  String get alertsTab => '告警';

  @override
  String get messagesTab => '消息';

  @override
  String get noAlerts => '暂无报警';

  @override
  String get noAlertsDesc => '目前没有报警通知';

  @override
  String get noMessages => '暂无消息';

  @override
  String get noMessagesDesc => '目前没有消息通知';

  @override
  String get unitSettings => '单位设置';

  @override
  String get tempUnit => '温度单位';

  @override
  String get mapSelection => '地图';

  @override
  String get language => '语言';

  @override
  String get logout => '退出登录';

  @override
  String get deleteAccount => '删除账号';

  @override
  String get cancel => '取消';

  @override
  String get googleMap => '谷歌地图';

  @override
  String get baiduMap => '百度地图';

  @override
  String get celsius => '摄氏度 ℃';

  @override
  String get fahrenheit => '华氏度 ℉';

  @override
  String get noDeviceBound => '未绑定设备';

  @override
  String get faq => '常见问题';

  @override
  String get faqRegister => '如何注册账号？';

  @override
  String get faqResetPwd => '如何重置密码？';

  @override
  String get faqGeofence => '电子围栏管理';

  @override
  String get faqBindDevice => '如何绑定设备？';

  @override
  String get faqShareDevice => '分享设备给家人';

  @override
  String get faqUnbindDevice => '如何解绑设备？';

  @override
  String get faqOrders => 'View Purchased Orders';

  @override
  String get faqAlertSettings => '告警设置';

  @override
  String get faqDeviceSettings => '设备设置';

  @override
  String get feedbackButton => '反馈';

  @override
  String get serviceStatus => '服务状态';

  @override
  String get statusAll => '全部状态';

  @override
  String get statusPending => '待处理';

  @override
  String get statusProcessing => '处理中';

  @override
  String get statusCompleted => '已完成';

  @override
  String get noData => '暂无数据';

  @override
  String get feedbackDescHint => '请详细描述问题，以便我们更好地为您提供帮助。';

  @override
  String get submit => '提交';

  @override
  String get termsOfUse => '使用条款';

  @override
  String get appVersion => '版本';

  @override
  String get findImeiSnHint => '你可以在盒子背面或设备上找到IMEI/SN';

  @override
  String get enterImeiSn => '输入IMEI/SN';
}
