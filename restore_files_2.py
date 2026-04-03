import os

files_content = {
    "lib/pages/home_page.dart": """import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import 'profile_page.dart';
import 'add_device_page.dart';
import 'alert_page.dart';
import 'device_main_page.dart'; // 替换为 device_main_page
import '../widgets/default_avatar.dart';
import '../models/device_model.dart';

class HomePage extends StatefulWidget {
  final bool hasDevice; // 用于控制是否显示设备的标志

  const HomePage({super.key, this.hasDevice = false}); // 默认为 false，表示空状态

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 根据传入的标志决定是否加载 Mock 数据
  List<DeviceModel> devices = [];

  @override
  void initState() {
    super.initState();
    // 初始化时加载
    _loadDevices();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当 widget 属性发生变化时（例如从其他页面带参数跳转回来），重新加载数据
    if (widget.hasDevice != oldWidget.hasDevice) {
      _loadDevices();
    }
  }

  void _loadDevices() {
    setState(() {
      devices = widget.hasDevice ? DeviceModel.getMockDevices() : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          // 顶部黄色渐变区域
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryYellow,
                  AppColors.primaryYellowLight,
                  AppColors.primaryYellowLighter,
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 28),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // 问候语 + 头像
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '你好！ 李杰',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111111),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '新的一天已开始',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF555555),
                            ),
                          ),
                        ],
                      ),
                      const DefaultAvatarWidget(size: 56),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // 我的设备卡片
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '我的设备',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111111),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '共${devices.length}台设备',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF888888),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF9F7EF),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CustomPaint(
                                      painter: ScanIconPainter(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddDevicePage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF9F7EF),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CustomPaint(
                                      painter: AddIconPainter(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AlertPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF9F7EF),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CustomPaint(
                                      painter: BellIconPainter(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 主内容 — 设备列表或空设备状态
          Expanded(
            child: devices.isEmpty
                ? _buildEmptyDeviceState(context)
                : _buildDeviceList(),
          ),
          // 底部 Tab 导航
          Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.home,
                      color: Color(0xFFF5C518),
                      size: 28,
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person_outline,
                      color: Color(0xFFAAAAAA),
                      size: 28,
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const ProfilePage(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建设备列表
  Widget _buildDeviceList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return _buildDeviceCard(device);
      },
    );
  }

  // 构建单个设备卡片 (高保真还原 UI)
  Widget _buildDeviceCard(DeviceModel device) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceMainPage(device: device),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20), // 增大圆角以匹配设计图
          // 添加一点淡淡的点击阴影暗示
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部：图片 + 信息
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // 改为居中对齐，让标签组和图片中心对齐更好看
              children: [
                // 设备图片占位框
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5), // 浅灰色背景
                    borderRadius: BorderRadius.circular(16), // 大圆角
                  ),
                  child: Hero(
                    tag: 'device_image_${device.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        device.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                              child: Icon(
                                Icons.contact_support_outlined, // 类似设计图中的占位图标
                                color: Color(0xFFAAAAAA),
                                size: 28,
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // 设备名称与状态标签
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        device.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111111),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // 状态标签组
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildStatusTag(
                            Icons.battery_charging_full,
                            '${device.batteryLevel}%',
                            const Color(0xFF22C55E), // 绿色电量
                          ),
                          _buildStatusTag(
                            Icons.pets,
                            device.status,
                            const Color(0xFF22C55E), // 绿色爪子
                          ),
                          _buildStatusTag(
                            Icons.signal_cellular_alt,
                            device.networkType,
                            const Color(0xFF22C55E), // 绿色信号
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // 增大图片区和地址区的间距
            // 底部：定位地址
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.location_on,
                    color: Color(0xFFF5C518),
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8), // 稍微增加间距
                Expanded(
                  child: Text(
                    device.address,
                    style: const TextStyle(
                      fontSize: 14, // 稍微增大字体
                      color: Color(0xFF666666),
                      height: 1.5, // 增加行高
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建状态小标签
  Widget _buildStatusTag(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), // 调整为更柔和的灰底色
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF555555),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // 提取出来的空设备状态组件
  Widget _buildEmptyDeviceState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.fromLTRB(24, 36, 24, 32),
        child: Column(
          children: [
            // 摄像头图标插图升级版
            SizedBox(
              height: 140,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // 底部灰色椭圆投影
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 60,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(30, 5),
                        ),
                      ),
                    ),
                  ),
                  // 包含主图标和悬浮气泡的组合
                  Positioned(
                    bottom: 24,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // 左侧大泡泡
                        Positioned(
                          left: -24,
                          top: 12,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5C518).withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // 左侧中泡泡
                        Positioned(
                          left: -12,
                          top: 24,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5C518).withValues(alpha: 0.35),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // 左上小泡泡
                        Positioned(
                          left: -2,
                          top: -8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5C518).withValues(alpha: 0.4),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // 顶部极小泡泡
                        Positioned(
                          left: 20,
                          top: -24,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5C518).withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // 右上小泡泡
                        Positioned(
                          right: 20,
                          top: -12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5C518).withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // 右侧中泡泡
                        Positioned(
                          right: -16,
                          top: 8,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5C518).withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // 右侧极小泡泡
                        Positioned(
                          right: -24,
                          top: 32,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5C518).withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // 中心主图标
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5C518),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF5C518),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '还没有设备',
              style: TextStyle(fontSize: 15, color: Color(0xFF666666)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddDevicePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5C518),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '添加',
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final paint = Paint()
      ..color = const Color(0xFF444444)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // 左上角折线
    final topLeftPath = Path()
      ..moveTo(0, h * 0.3)
      ..lineTo(0, 0)
      ..lineTo(w * 0.3, 0);
    canvas.drawPath(topLeftPath, paint);

    // 右上角折线
    final topRightPath = Path()
      ..moveTo(w * 0.7, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h * 0.3);
    canvas.drawPath(topRightPath, paint);

    // 左下角折线
    final bottomLeftPath = Path()
      ..moveTo(0, h * 0.7)
      ..lineTo(0, h)
      ..lineTo(w * 0.3, h);
    canvas.drawPath(bottomLeftPath, paint);

    // 右下角折线
    final bottomRightPath = Path()
      ..moveTo(w * 0.7, h)
      ..lineTo(w, h)
      ..lineTo(w, h * 0.7);
    canvas.drawPath(bottomRightPath, paint);

    // 中间横向扫描线
    canvas.drawLine(Offset(-w * 0.1, h * 0.5), Offset(w * 1.1, h * 0.5), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AddIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final paint = Paint()
      ..color = const Color(0xFF444444)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // 细线加号
    canvas.drawLine(Offset(w * 0.5, 0), Offset(w * 0.5, h), paint);
    canvas.drawLine(Offset(0, h * 0.5), Offset(w, h * 0.5), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BellIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final paint = Paint()
      ..color = const Color(0xFF444444)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // 铃铛主体路径
    final path = Path();
    path.moveTo(w * 0.5, h * 0.1);
    // 铃铛顶部弧形
    path.quadraticBezierTo(w * 0.2, h * 0.1, w * 0.2, h * 0.5);
    // 向下外扩到底部
    path.quadraticBezierTo(w * 0.2, h * 0.7, w * 0.05, h * 0.85);
    // 底部平直连接
    path.lineTo(w * 0.95, h * 0.85);
    // 回到右上
    path.quadraticBezierTo(w * 0.8, h * 0.7, w * 0.8, h * 0.5);
    path.quadraticBezierTo(w * 0.8, h * 0.1, w * 0.5, h * 0.1);

    canvas.drawPath(path, paint);

    // 底部小圆摆锤
    canvas.drawArc(
      Rect.fromLTRB(w * 0.4, h * 0.85, w * 0.6, h * 1.05),
      0,
      3.14159, // 半圆
      false,
      paint,
    );

    // 右上角的红点
    final redDotPaint = Paint()
      ..color = const Color(0xFFF25448)
      ..style = PaintingStyle.fill;

    // 画一个白底作为红点的描边，遮挡铃铛线条
    final whitePaint = Paint()
      ..color = const Color(0xFFF9F7EF)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(w * 0.85, h * 0.15), 4.5, whitePaint);
    canvas.drawCircle(Offset(w * 0.85, h * 0.15), 3, redDotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
""",
    "lib/pages/device_main_page.dart": """import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/device_model.dart';
import 'device_detail_page.dart';
import 'find_pet_page.dart';
import 'health_page.dart';
import 'pet_detail_page.dart';

class DeviceMainPage extends StatefulWidget {
  final DeviceModel device;
  final int initialIndex;

  const DeviceMainPage({
    super.key,
    required this.device,
    this.initialIndex = 0,
  });

  @override
  State<DeviceMainPage> createState() => _DeviceMainPageState();
}

class _DeviceMainPageState extends State<DeviceMainPage> {
  late int _currentIndex;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    // 使用 IndexedStack 保持各页面状态
    _pages = [
      DeviceDetailPage(device: widget.device),
      FindPetPage(device: widget.device),
      HealthPage(device: widget.device),
      // 暂时直接使用 PetDetailPage，如果是真实业务可以根据设备是否有宠物选择加载 PetEmptyPage
      PetDetailPage(device: widget.device),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      // 统一管理的底部导航栏
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            HapticFeedback.selectionClick();
            setState(() => _currentIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF111111),
          unselectedItemColor: const Color(0xFFAAAAAA),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.location_on_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.location_on),
              ),
              label: '主页',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.surround_sound_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.surround_sound),
              ),
              label: '寻宠',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.monitor_heart_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.monitor_heart),
              ),
              label: '健康',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.pets_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.pets),
              ),
              label: '宠物',
            ),
          ],
        ),
      ),
    );
  }
}
""",
    "lib/pages/device_info_page.dart": """import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/device_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_toast.dart'; // 导入自定义 Toast 工具类
import '../widgets/common_list_tile.dart';
import 'pet_detail_page.dart'; // 导入用于跳转的宠物详情页面
import 'device_share_page.dart'; // 导入设备分享页面
import 'alert_settings_page.dart'; // 导入告警设置页面
import 'device_settings_page.dart'; // 导入其他设备设置页面
import 'help_feedback_page.dart'; // 导入帮助与反馈页面
import 'subscription_plan_page.dart'; // 导入订阅计划页面
import 'home_page.dart'; // 导入首页以便解绑后跳转

class DeviceInfoPage extends StatelessWidget {
  final DeviceModel device;

  const DeviceInfoPage({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF111111),
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '设备信息',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111111),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              // 1. 顶部设备基础信息卡片
              _buildDeviceBaseInfoCard(context),
              const SizedBox(height: 16),

              // 2. 黑色订阅套餐卡片
              _buildSubscriptionCard(context),
              const SizedBox(height: 16),

              // 3. 关联设置卡片组
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    CommonListTile(
                      title: '宠物信息',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.pets,
                            color: AppColors.dividerLight,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            '11',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // 跳转到宠物详情页 (目前用已有的带数据的页面替代)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetDetailPage(device: device),
                          ),
                        );
                      },
                    ),
                    CommonListTile(
                      title: '设备分享',
                      hasBorderBottom: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DeviceSharePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 4. 其他功能设置卡片组
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    CommonListTile(
                      title: '报警设置',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AlertSettingsPage(),
                          ),
                        );
                      },
                    ),
                    CommonListTile(
                      title: '其他设置',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DeviceSettingsPage(),
                          ),
                        );
                      },
                    ),
                    CommonListTile(
                      title: '帮助与反馈',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HelpFeedbackPage(device: device),
                          ),
                        );
                      },
                    ),
                    CommonListTile(
                      title: '解绑',
                      titleColor: AppColors.errorRed,
                      hasBorderBottom: false,
                      showArrow: false,
                      onTap: () => _showUnbindDialog(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40), // 底部留白
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================
  // 局部组件拆分
  // ==============================================

  // 弹出解绑确认弹窗
  void _showUnbindDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '解绑',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '解绑后，设备的历史数据将被完全删除。你确定要解绑吗？',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: AppColors.dividerLight),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          '取消',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // 关闭底部弹窗
                          Navigator.pop(context);

                          // 返回到主页，并传递一个标志表示设备已解绑
                          // 因为中间隔了 DeviceMainPage 和 DeviceDetailPage，
                          // 我们使用 popUntil 一直返回到 HomePage，
                          // 并通过 pushReplacement 重新加载一个空的 HomePage
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HomePage(hasDevice: false),
                            ),
                            (route) => false,
                          );

                          // 显示自定义的成功提示信息
                          AppToast.showSuccess(context, '设备已解绑');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFFFF5252), // 红色解绑按钮
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: const Text(
                          '解绑',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 1. 设备基础信息卡片
  Widget _buildDeviceBaseInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(24), // 根据设计图放大圆角
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧设备图片
          Container(
            width: 80, // 根据设计图放大图片占位
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.backgroundGray,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                device.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(
                    Icons.contact_support_outlined, // 换成类似问号的图标
                    color: AppColors.textHint,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // 右侧详细信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        device.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.textHint,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '型号: PT02E', // 写死模拟数据，后期可换成模型字段
                  style: TextStyle(fontSize: 13, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 6),
                _buildCopyableRow(context, 'IMEI', '865530078499001'),
                const SizedBox(height: 6),
                _buildCopyableRow(context, 'MAC', 'D4:0D:DE:04:F9:46'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 带有复制图标的信息行
  Widget _buildCopyableRow(BuildContext context, String label, String value) {
    return Row(
      children: [
        Text(
          '$label: $value',
          style: const TextStyle(fontSize: 13, color: AppColors.textTertiary),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: value));
            AppToast.showSuccess(context, '$label 已复制'); // 使用自定义 Toast
          },
          child: const Icon(
            Icons.content_copy,
            color: AppColors.textHint,
            size: 14,
          ), // 换成更像设计图的两页纸复制图标
        ),
      ],
    );
  }

  // 2. 黑色的订阅卡片
  Widget _buildSubscriptionCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SubscriptionPlanPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ), // 稍微增加上下边距
        decoration: BoxDecoration(
          color: AppColors.backgroundDark, // 深色底
          borderRadius: BorderRadius.circular(24), // 放大圆角
        ),
        child: Row(
          children: [
            // 左侧黄色徽章图标
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryYellow.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12), // 稍微放大图标底框圆角
              ),
              child: const Center(
                child: Icon(
                  Icons.workspace_premium,
                  color: AppColors.primaryYellow,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '免费 - 随货导入-首年套餐',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '到期时间 2027-03-27',
                    style: TextStyle(fontSize: 13, color: AppColors.textHint),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
"""
}

for path, content in files_content.items():
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
