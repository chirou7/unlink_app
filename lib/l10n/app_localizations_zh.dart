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

  @override
  String get deviceName => '设备名称';

  @override
  String get shareDeviceTitle => '分享设备';

  @override
  String get noSharedMembers => '无分享成员';

  @override
  String get sharedMembersCanView => '分享成员可以查看设备';

  @override
  String get addSharedMember => '添加分享成员';

  @override
  String get alertSettingsTitle => '告警设置';

  @override
  String get stopCharging => '停止充电';

  @override
  String get startCharging => '开始充电';

  @override
  String get outOfFenceAlert => '出围栏报警(蓝牙)';

  @override
  String get inFenceAlert => '进围栏报警(蓝牙)';

  @override
  String get stopMoving => '停止运动';

  @override
  String get startMoving => '开始运动';

  @override
  String get enterFence => '进入围栏';

  @override
  String get leaveFence => '离开围栏';

  @override
  String get devicePowerOn => '设备开机';

  @override
  String get bluetoothConnected => '蓝牙连接';

  @override
  String get bluetoothDisconnected => '蓝牙断开连接';

  @override
  String get devicePowerOff => '设备关机';

  @override
  String get deviceActivated => '设备激活';

  @override
  String get deviceSettingsTitle => '设备设置';

  @override
  String get findPetMode => '寻宠模式设置';

  @override
  String get findPetModeDesc => '寻宠模式位置更新更快，帮助您迅速找到宠物，电池续航会相应缩短';

  @override
  String get soundSettings => '声音设置';

  @override
  String get soundSettingsDesc => '设备声音设置';

  @override
  String get timesSuffix => '次';

  @override
  String get lightSettings => '灯光设置';

  @override
  String get lightSettingsDesc => '设置灯光参数';

  @override
  String get powerSavingMode => '省电模式';

  @override
  String get sleepSettings => '休眠设置';

  @override
  String get sleepSettingsDesc => '开启后设备在设置时间范围内进入休眠模式，休眠过程中设备离线，设备活动会自动退出休眠。';

  @override
  String get deviceSelfTest => '设备自检';

  @override
  String get bluetoothFirmwareUpgrade => '蓝牙固件升级';

  @override
  String get duration => '持续时长';

  @override
  String get durationDesc => '寻宠模式持续时长，到时间后自动退出';

  @override
  String get updateInterval => '定位更新间隔';

  @override
  String get updateIntervalDesc => '定位更新间隔时间，时间越短位置更新越快';

  @override
  String minute(int count) {
    return '$count分钟';
  }

  @override
  String second(int count) {
    return '$count秒';
  }

  @override
  String get lightColor => '灯颜色';

  @override
  String get lightColorDesc => '设置灯颜色';

  @override
  String get flashMode => '闪烁';

  @override
  String get flashModeDesc => '设置灯闪烁频率';

  @override
  String get flashCount => '闪烁次数';

  @override
  String get flashCountDesc => '设置灯闪烁的次数，数值越大闪烁时间越长';

  @override
  String get colorRainbow => '七彩闪烁';

  @override
  String get colorRed => '红灯';

  @override
  String get colorOrange => '橙灯';

  @override
  String get colorYellow => '黄灯';

  @override
  String get colorGreen => '绿灯';

  @override
  String get flashBreathing => '呼吸灯';

  @override
  String get flashSlow => '慢闪';

  @override
  String get flashFast => '爆闪';

  @override
  String times(int count) {
    return '$count次';
  }

  @override
  String get sleepSwitch => '休眠开关';

  @override
  String get sleepSwitchDesc => '控制休眠开启和关闭';

  @override
  String get startTime => '开始时间';

  @override
  String get startTimeDesc => '休眠开始时间，到时间设备自动进入休眠模式';

  @override
  String get endTime => '结束时间';

  @override
  String get endTimeDesc => '休眠结束时间，到时间设备自动退出休眠模式';

  @override
  String get selectTime => '选择';

  @override
  String get deviceCheckTitle => '故障检测';

  @override
  String get startCheck => '开始';

  @override
  String get checkDesc => '点击开始故障检测，将帮助诊断潜在问题';

  @override
  String get currentVersion => '当前版本';

  @override
  String get versionUpToDate => '版本已是最新';

  @override
  String get petName => '宠物名称';

  @override
  String get petBreed => '品种';

  @override
  String get petGender => '性别';

  @override
  String get petBirthday => '生日';

  @override
  String get petWeight => '体重';

  @override
  String get petHeight => '身高';

  @override
  String get petLength => '体长';

  @override
  String get petNeutered => '绝育';

  @override
  String get petVaccination => '疫苗接种';

  @override
  String get confirm => '确认';

  @override
  String get skip => '跳过';

  @override
  String get selectHint => '选择';

  @override
  String get enterHint => '输入';

  @override
  String get save => '保存';

  @override
  String get male => '雄性';

  @override
  String get female => '雌性';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get pleaseEnter => '请输入';

  @override
  String get vacNotVaccinated => '未接种';

  @override
  String get vacVaccinated => '已接种';

  @override
  String get vaccinationDate => '接种日期';

  @override
  String get forgotVaccinationTime => '若忘记疫苗接种的时间';

  @override
  String get yearSuffix => '年';

  @override
  String get monthSuffix => '月';

  @override
  String get daySuffix => '日';

  @override
  String get selectBreed => '选择品种';

  @override
  String get tabDog => '🐶 狗狗';

  @override
  String get tabCat => '🐱 猫咪';

  @override
  String get searchBreedHint => '搜索品种/别名/拼音';

  @override
  String get hotRecommendation => '🔥 热门推荐';

  @override
  String get allBreeds => '🗂 全部品种';

  @override
  String get searchEmptyHint => '未找到相关品种，您可以：';

  @override
  String get selectMixedBreed => '选择 混血/串串';

  @override
  String get selectUnknownBreed => '选择 未知品种';

  @override
  String get finish => '完成';

  @override
  String get activationSuccessGreeting1 => '你好 ';

  @override
  String get activationSuccessGreeting2 => '！你的设备已激活。';

  @override
  String get virtualPet => '虚拟宠物';

  @override
  String get newBadge => '新';

  @override
  String get addPet => '添加宠物';

  @override
  String get bluetoothPositioning => '蓝牙定位';

  @override
  String minutesAgo(int minutes) {
    return '$minutes分钟前';
  }

  @override
  String get today => '今天';

  @override
  String get goal => '目标';

  @override
  String get activity => '活动';

  @override
  String get minutes => '分钟';

  @override
  String get calories => '卡路里';

  @override
  String get kcal => '千卡';

  @override
  String get rest => '休息';

  @override
  String get hours => '小时';

  @override
  String get steps => '步数';

  @override
  String get trajectory => '轨迹';

  @override
  String get stayTime => '停留时间';

  @override
  String get geofence => '电子围栏';

  @override
  String get viewAll => '查看全部';

  @override
  String get noGeofenceCreated => '未创建地理围栏';

  @override
  String get createNew => '新建';

  @override
  String get light => '灯光';

  @override
  String get sound => '声音';

  @override
  String get findPet => '寻宠';

  @override
  String get gps => 'GPS';

  @override
  String get now => '现在';

  @override
  String get homeTab => '主页';

  @override
  String get healthTab => '健康';

  @override
  String get petTab => '宠物';

  @override
  String get sun => '周日';

  @override
  String get mon => '周一';

  @override
  String get tue => '周二';

  @override
  String get wed => '周三';

  @override
  String get thu => '周四';

  @override
  String get fri => '周五';

  @override
  String get sat => '周六';

  @override
  String get progress => '进度';

  @override
  String get caloriesDesc => '卡路里根据您宠物的品种、年龄、体重和实时步数计算，提供最准确的实际能量消耗估算';

  @override
  String get selectAction => '选择';

  @override
  String ageMonths(int months) {
    return '$months月';
  }

  @override
  String ageYears(int years) {
    return '$years岁';
  }

  @override
  String ageYearsMonths(int years, int months) {
    return '$years岁$months月';
  }
}
