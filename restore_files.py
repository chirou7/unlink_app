import os

files_content = {
    "lib/main.dart": """import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// 引入 Trae 帮你建好的欢迎页（确保你的 lib 下有 pages 文件夹）
import 'pages/welcome_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unlink App',
      debugShowCheckedModeBanner: false, // 关掉右上角红色的 DEBUG 标签
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // 设置默认背景色
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'), // 支持中文
        Locale('en', 'US'), // 支持英文
      ],
      // 这里最关键：把 App 的首页指针，指向你生成的 WelcomePage
      home: const WelcomePage(), 
    );
  }
}
""",
    "lib/models/device_model.dart": """class DeviceModel {
  final String id;
  final String name; // e.g., 'PT02E-99001'
  final String imageUrl; // 设备图片 URL
  final int batteryLevel; // 电量百分比 (0-100)
  final String status; // 状态，如 '休息', '运动' 等
  final String networkType; // 网络类型，如 '4G', 'WIFI' 等
  final int signalStrength; // 信号强度 (0-4)
  final String address; // 定位地址
  final DateTime lastUpdateTime; // 最后更新时间

  DeviceModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.batteryLevel,
    required this.status,
    required this.networkType,
    required this.signalStrength,
    required this.address,
    required this.lastUpdateTime,
  });

  // 预留与后端对接的 API 结构 (fromJson)
  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      batteryLevel: json['batteryLevel'] as int? ?? 0,
      status: json['status'] as String? ?? '离线',
      networkType: json['networkType'] as String? ?? '未知',
      signalStrength: json['signalStrength'] as int? ?? 0,
      address: json['address'] as String? ?? '',
      lastUpdateTime: json['lastUpdateTime'] != null
          ? DateTime.parse(json['lastUpdateTime'])
          : DateTime.now(),
    );
  }

  // 预留序列化方法 (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'batteryLevel': batteryLevel,
      'status': status,
      'networkType': networkType,
      'signalStrength': signalStrength,
      'address': address,
      'lastUpdateTime': lastUpdateTime.toIso8601String(),
    };
  }

  // 前端开发和测试使用的 Mock 数据
  static List<DeviceModel> getMockDevices() {
    return [
      DeviceModel(
        id: 'dev_001',
        name: 'PT02E-99001',
        imageUrl:
            'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=200&auto=format&fit=crop', // 替换为可靠的狗狗/设备占位图
        batteryLevel: 54,
        status: '休息',
        networkType: '4G',
        signalStrength: 3, // 4格信号中占3格
        address: '石鼓路，西丽，西丽街道，南山区，深圳市，广东省，518000...',
        lastUpdateTime: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
  }
}
""",
    "lib/models/pet_profile_model.dart": """class PetProfileModel {
  String name;
  String breed;
  String gender;

  // 生日相关的状态
  String birthdayLabel; // 用于界面展示的文案，如 '2023-05-01'
  DateTime? birthdayDate; // 用于逻辑判断和存储的时间对象

  // 身体指标 (统一以公制 kg/cm 存储在 Model 中)
  String weightKg;
  String heightCm;
  String lengthCm;

  // 健康状态
  String neutered;
  String vaccineStatus;
  String vaccineDateLabel; // 用于界面展示的文案
  DateTime? vaccineDate; // 用于逻辑判断的时间对象

  // 媒体信息
  String avatarPath;

  PetProfileModel({
    this.name = '',
    this.breed = '',
    this.gender = '',
    this.birthdayLabel = '',
    this.birthdayDate,
    this.weightKg = '',
    this.heightCm = '',
    this.lengthCm = '',
    this.neutered = '',
    this.vaccineStatus = '',
    this.vaccineDateLabel = '',
    this.vaccineDate,
    this.avatarPath = '',
  });

  /// 将模型转为 JSON，方便未来提交给后端 API
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'breed': breed,
      'gender': gender,
      'birthday': birthdayDate?.toIso8601String(),
      'weight': double.tryParse(weightKg),
      'height': double.tryParse(heightCm),
      'length': double.tryParse(lengthCm),
      'isNeutered': neutered == '是',
      'isVaccinated': vaccineStatus == '已接种',
      'vaccineDate': vaccineDate?.toIso8601String(),
      'avatarPath': avatarPath,
    };
  }

  /// 从后端返回的 JSON 初始化模型 (预留)
  factory PetProfileModel.fromJson(Map<String, dynamic> json) {
    return PetProfileModel(
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
      gender: json['gender'] ?? '',
      birthdayDate: json['birthday'] != null
          ? DateTime.parse(json['birthday'])
          : null,
      weightKg: json['weight']?.toString() ?? '',
      heightCm: json['height']?.toString() ?? '',
      lengthCm: json['length']?.toString() ?? '',
      neutered: json['isNeutered'] == true
          ? '是'
          : (json['isNeutered'] == false ? '否' : ''),
      vaccineStatus: json['isVaccinated'] == true
          ? '已接种'
          : (json['isVaccinated'] == false ? '未接种' : ''),
      vaccineDate: json['vaccineDate'] != null
          ? DateTime.parse(json['vaccineDate'])
          : null,
      avatarPath: json['avatarPath'] ?? '',
    );
  }
}
""",
    "lib/utils/app_colors.dart": """import 'package:flutter/material.dart';

class AppColors {
  // 品牌核心色
  static const Color primaryYellow = Color(0xFFF5C518);
  static const Color primaryYellowLight = Color(0xFFFFE066);
  static const Color primaryYellowLighter = Color(0xFFFFF8D6);

  // 背景色
  static const Color backgroundLight = Color(0xFFF7F8FA);
  static const Color backgroundWhite = Colors.white;
  static const Color backgroundGray = Color(0xFFF5F5F5); // 用于默认头像、占位图背景
  static const Color backgroundDark = Color(0xFF1A1A1A); // 黑色药丸Toast、盾牌底色

  // 文本色
  static const Color textPrimary = Color(0xFF111111); // 主文本黑
  static const Color textSecondary = Color(0xFF333333); // 次文本深灰
  static const Color textTertiary = Color(0xFF666666); // 辅助说明灰
  static const Color textHint = Color(0xFFAAAAAA); // 输入框提示灰/未选中Tab灰
  static const Color textLight = Color(0xFFBBBBBB); // 更浅的灰（图表刻度等）

  // 功能/状态色
  static const Color successGreen = Color(0xFF22C55E); // 成功、电量、正常状态
  static const Color errorRed = Color(0xFFE84040); // 错误、红点、警示
  static const Color infoBlue = Color(0xFF3B82F6); // 信息、蓝牙连接、轨迹线

  // 边框/分割线色
  static const Color dividerLight = Color(0xFFEEEEEE); // 分割线
  static const Color dividerLighter = Color(0xFFF0F0F0); // 更浅的分割线

  // 浅色卡片底色 (用于不同状态图标的背景)
  static const Color cardBlueLight = Color(0xFFE8F0FE);
  static const Color cardGreenLight = Color(0xFFE8F5E9);
  static const Color cardYellowLight = Color(0xFFFFF9E6);
}
""",
    "lib/utils/app_toast.dart": """import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppToast {
  /// 显示成功提示 (绿色图标，带有轻微震动反馈)
  static void showSuccess(BuildContext context, String message) {
    HapticFeedback.lightImpact();
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.check_circle,
      iconColor: AppColors.successGreen,
    );
  }

  /// 显示错误/警告提示 (红色图标，带有中等震动反馈)
  static void showError(BuildContext context, String message) {
    HapticFeedback.mediumImpact();
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.error,
      iconColor: AppColors.errorRed,
    );
  }

  /// 显示普通信息提示 (蓝色图标)
  static void showInfo(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.info,
      iconColor: AppColors.infoBlue,
    );
  }

  /// 内部核心实现方法
  static void _showCustomSnackBar({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color iconColor,
  }) {
    // 移除当前可能正在显示的 SnackBar，防止排队堆叠
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white, // 白底卡片
        behavior: SnackBarBehavior.floating, // 悬浮样式
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // 大圆角
        ),
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 32, // 距离底部有一定留白，不贴边
        ),
        elevation: 8, // 淡淡的阴影
        duration: const Duration(seconds: 2), // 默认显示2秒
      ),
    );
  }
}
""",
    "lib/utils/unit_converter.dart": """class UnitConverter {
  // 当前全局使用的单位系统。
  // true 表示公制 (Metric): kg, cm
  // false 表示英制 (Imperial): lbs, inch
  // 这里暂时硬编码为 true (公制)，未来可以通过 SharedPreferences 或状态管理动态改变它。
  static bool useMetric = true;

  // -------------------------
  // 单位文案获取
  // -------------------------

  /// 获取当前系统的重量单位文案
  static String get weightUnitLabel => useMetric ? 'kg' : 'lbs';

  /// 获取当前系统的长度单位文案
  static String get lengthUnitLabel => useMetric ? 'cm' : 'inch';

  // -------------------------
  // 常量与换算比例
  // -------------------------
  static const double _kgToLbsRatio = 2.20462;
  static const double _cmToInchRatio = 0.393701;

  // -------------------------
  // 数值换算 (显示给用户)
  // 当数据库中存储的是基准的公制单位时，根据当前配置决定是否转换为英制显示
  // -------------------------

  /// 将数据库中的体重(kg)转换为当前系统单位用于显示
  static String formatWeightForDisplay(String baseWeightKg) {
    if (baseWeightKg.isEmpty) return '';
    final numValue = double.tryParse(baseWeightKg);
    if (numValue == null) return baseWeightKg;

    if (useMetric) {
      return baseWeightKg; // 已经是 kg，直接返回
    } else {
      // 转为 lbs，保留一位小数
      return (numValue * _kgToLbsRatio).toStringAsFixed(1);
    }
  }

  /// 将数据库中的长度(cm)转换为当前系统单位用于显示
  static String formatLengthForDisplay(String baseLengthCm) {
    if (baseLengthCm.isEmpty) return '';
    final numValue = double.tryParse(baseLengthCm);
    if (numValue == null) return baseLengthCm;

    if (useMetric) {
      return baseLengthCm; // 已经是 cm，直接返回
    } else {
      // 转为 inch，保留一位小数
      return (numValue * _cmToInchRatio).toStringAsFixed(1);
    }
  }

  // -------------------------
  // 数值换算 (保存到数据库)
  // 无论用户在界面上输入的是 kg 还是 lbs，统一转换为基准的公制单位 (kg/cm) 保存
  // -------------------------

  /// 将用户在界面上输入的重量，统一转换为 kg 保存
  static String parseWeightToBase(String inputWeight) {
    if (inputWeight.isEmpty) return '';
    final numValue = double.tryParse(inputWeight);
    if (numValue == null) return inputWeight;

    if (useMetric) {
      return inputWeight;
    } else {
      // 输入的是 lbs，转回 kg 保存
      return (numValue / _kgToLbsRatio).toStringAsFixed(2);
    }
  }

  /// 将用户在界面上输入的长度，统一转换为 cm 保存
  static String parseLengthToBase(String inputLength) {
    if (inputLength.isEmpty) return '';
    final numValue = double.tryParse(inputLength);
    if (numValue == null) return inputLength;

    if (useMetric) {
      return inputLength;
    } else {
      // 输入的是 inch，转回 cm 保存
      return (numValue / _cmToInchRatio).toStringAsFixed(2);
    }
  }

  // -------------------------
  // 辅助换算提示 (方案 C：用于在输入时提供另一种单位的实时参考)
  // -------------------------

  /// 根据用户在当前系统单位下输入的数值，返回另一种单位的换算字符串（如：输入 10(kg)，返回 "约等于 22.0 lbs"）
  static String getConversionHint(String inputValue, {required bool isWeight}) {
    if (inputValue.isEmpty) return '';
    final numValue = double.tryParse(inputValue);
    if (numValue == null || numValue <= 0) return '';

    if (isWeight) {
      if (useMetric) {
        // 当前是 kg，计算 lbs
        return '约等于 ${(numValue * _kgToLbsRatio).toStringAsFixed(1)} lbs';
      } else {
        // 当前是 lbs，计算 kg
        return '约等于 ${(numValue / _kgToLbsRatio).toStringAsFixed(1)} kg';
      }
    } else {
      if (useMetric) {
        // 当前是 cm，计算 inch
        return '约等于 ${(numValue * _cmToInchRatio).toStringAsFixed(1)} inch';
      } else {
        // 当前是 inch，计算 cm
        return '约等于 ${(numValue / _cmToInchRatio).toStringAsFixed(1)} cm';
      }
    }
  }

  // -------------------------
  // 校验边界值获取 (根据当前单位动态返回)
  // -------------------------

  /// 获取体重输入的最大限制数值
  static double get maxWeightLimit =>
      useMetric ? 200.0 : 440.0; // 200kg 约等于 440lbs

  /// 获取长度输入的最大限制数值
  static double get maxLengthLimit =>
      useMetric ? 300.0 : 118.0; // 300cm 约等于 118inch
}
""",
    "lib/widgets/common_app_bar.dart": """import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing; // 右侧自定义组件 (如保存按钮、更多图标)
  final VoidCallback? onBack; // 自定义返回逻辑
  final Color backgroundColor;
  final Color titleColor;
  final Color iconColor;
  final bool centerTitle;
  final double elevation;

  const CommonAppBar({
    super.key,
    required this.title,
    this.trailing,
    this.onBack,
    this.backgroundColor = AppColors.backgroundWhite,
    this.titleColor = AppColors.textPrimary,
    this.iconColor = AppColors.textPrimary,
    this.centerTitle = true,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: iconColor, size: 22),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: titleColor,
        ),
      ),
      actions: trailing != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(child: trailing!),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
"""
}

for path, content in files_content.items():
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
