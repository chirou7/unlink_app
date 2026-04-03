import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart'; // Add this line
import '../utils/app_colors.dart';
import 'profile_page.dart';
import 'add_device_page.dart';
import 'alert_page.dart';
import 'device_main_page.dart'; // �滻Ϊ device_main_page
import '../widgets/default_avatar.dart';
import '../models/device_model.dart';

class HomePage extends StatefulWidget {
  final bool hasDevice; // ���ڿ����Ƿ���ʾ�豸�ı�־

  const HomePage({super.key, this.hasDevice = false}); // Ĭ��Ϊ false����ʾ��״̬

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ���ݴ���ı�־�����Ƿ���� Mock ����
  List<DeviceModel> devices = [];

  @override
  void initState() {
    super.initState();
    // ��ʼ��ʱ����
    _loadDevices();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // �� widget ���Է����仯ʱ�����������ҳ���������ת�����������¼�������
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
          // ������ɫ��������
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
                  // �ʺ��� + ͷ��
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.greeting('李杰'),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppLocalizations.of(context)!.newDayStarted,
                            style: const TextStyle(
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
                  // �ҵ��豸��Ƭ
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
                            Text(
                              AppLocalizations.of(context)!.myDevices,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111111),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.deviceCount(devices.length),
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
          // ������ �� �豸�б�����豸״̬
          Expanded(
            child: devices.isEmpty
                ? _buildEmptyDeviceState(context)
                : _buildDeviceList(),
          ),
          // �ײ� Tab ����
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

  // �����豸�б�
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

  // ���������豸��Ƭ (�߱��滹ԭ UI)
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
          borderRadius: BorderRadius.circular(20), // ����Բ����ƥ�����ͼ
          // ����һ�㵭���ĵ����Ӱ��ʾ
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
            // ������ͼƬ + ��Ϣ
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // ��Ϊ���ж��룬�ñ�ǩ���ͼƬ���Ķ�����ÿ�
              children: [
                // �豸ͼƬռλ��
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5), // ǳ��ɫ����
                    borderRadius: BorderRadius.circular(16), // ��Բ��
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
                                Icons
                                    .contact_support_outlined, // �������ͼ�е�ռλͼ��
                                color: Color(0xFFAAAAAA),
                                size: 28,
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // �豸������״̬��ǩ
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
                      // ״̬��ǩ��
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildStatusTag(
                            Icons.battery_charging_full,
                            '${device.batteryLevel}%',
                            const Color(0xFF22C55E), // ��ɫ����
                          ),
                          _buildStatusTag(
                            Icons.pets,
                            device.status,
                            const Color(0xFF22C55E), // ��ɫצ��
                          ),
                          _buildStatusTag(
                            Icons.signal_cellular_alt,
                            device.networkType,
                            const Color(0xFF22C55E), // ��ɫ�ź�
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // ����ͼƬ���͵�ַ���ļ��
            // �ײ�����λ��ַ
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
                const SizedBox(width: 8), // ��΢���Ӽ��
                Expanded(
                  child: Text(
                    device.address,
                    style: const TextStyle(
                      fontSize: 14, // ��΢��������
                      color: Color(0xFF666666),
                      height: 1.5, // �����и�
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

  // ����״̬С��ǩ
  Widget _buildStatusTag(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), // ����Ϊ����͵Ļҵ�ɫ
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

  // ��ȡ�����Ŀ��豸״̬���
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
                              color: const Color(
                                0xFFF5C518,
                              ).withValues(alpha: 0.2),
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
                              color: const Color(
                                0xFFF5C518,
                              ).withValues(alpha: 0.35),
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
                              color: const Color(
                                0xFFF5C518,
                              ).withValues(alpha: 0.4),
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
                              color: const Color(
                                0xFFF5C518,
                              ).withValues(alpha: 0.5),
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
                              color: const Color(
                                0xFFF5C518,
                              ).withValues(alpha: 0.3),
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
                              color: const Color(
                                0xFFF5C518,
                              ).withValues(alpha: 0.3),
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
                              color: const Color(
                                0xFFF5C518,
                              ).withValues(alpha: 0.6),
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
            Text(
              AppLocalizations.of(context)!.noDeviceYet,
              style: const TextStyle(fontSize: 15, color: Color(0xFF666666)),
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
                child: Text(
                  AppLocalizations.of(context)!.addDevice,
                  style: const TextStyle(
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

    // ���Ͻ�����
    final topLeftPath = Path()
      ..moveTo(0, h * 0.3)
      ..lineTo(0, 0)
      ..lineTo(w * 0.3, 0);
    canvas.drawPath(topLeftPath, paint);

    // ���Ͻ�����
    final topRightPath = Path()
      ..moveTo(w * 0.7, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h * 0.3);
    canvas.drawPath(topRightPath, paint);

    // ���½�����
    final bottomLeftPath = Path()
      ..moveTo(0, h * 0.7)
      ..lineTo(0, h)
      ..lineTo(w * 0.3, h);
    canvas.drawPath(bottomLeftPath, paint);

    // ���½�����
    final bottomRightPath = Path()
      ..moveTo(w * 0.7, h)
      ..lineTo(w, h)
      ..lineTo(w, h * 0.7);
    canvas.drawPath(bottomRightPath, paint);

    // �м����ɨ����
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

    // ϸ�߼Ӻ�
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

    // ��������·��
    final path = Path();
    path.moveTo(w * 0.5, h * 0.1);
    // ������������
    path.quadraticBezierTo(w * 0.2, h * 0.1, w * 0.2, h * 0.5);
    // �����������ײ�
    path.quadraticBezierTo(w * 0.2, h * 0.7, w * 0.05, h * 0.85);
    // �ײ�ƽֱ����
    path.lineTo(w * 0.95, h * 0.85);
    // �ص�����
    path.quadraticBezierTo(w * 0.8, h * 0.7, w * 0.8, h * 0.5);
    path.quadraticBezierTo(w * 0.8, h * 0.1, w * 0.5, h * 0.1);

    canvas.drawPath(path, paint);

    // �ײ�СԲ�ڴ�
    canvas.drawArc(
      Rect.fromLTRB(w * 0.4, h * 0.85, w * 0.6, h * 1.05),
      0,
      3.14159, // ��Բ
      false,
      paint,
    );

    // ���Ͻǵĺ��
    final redDotPaint = Paint()
      ..color = const Color(0xFFF25448)
      ..style = PaintingStyle.fill;

    // ��һ���׵���Ϊ������ߣ��ڵ���������
    final whitePaint = Paint()
      ..color = const Color(0xFFF9F7EF)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(w * 0.85, h * 0.15), 4.5, whitePaint);
    canvas.drawCircle(Offset(w * 0.85, h * 0.15), 3, redDotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
