import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/device_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_toast.dart'; // �����Զ��� Toast ������
import '../widgets/common_list_tile.dart';
import 'pet_detail_page.dart'; // ����������ת�ĳ�������ҳ��
import 'device_share_page.dart'; // �����豸����ҳ��
import 'alert_settings_page.dart'; // ����澯����ҳ��
import 'device_settings_page.dart';
import 'help_feedback_page.dart';
import 'subscription_plan_page.dart';
import 'home_page.dart';
import 'device_name_edit_page.dart'; // 添加新页面的导入

import '../l10n/app_localizations.dart'; // 引入多语言

class DeviceInfoPage extends StatelessWidget {
  final DeviceModel device;

  const DeviceInfoPage({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
        title: Text(
          l10n.deviceInfo,
          style: const TextStyle(
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
              // 1. 设备基本信息卡片
              _buildDeviceBaseInfoCard(context, l10n),
              const SizedBox(height: 16),

              // 2. 黑色订阅套餐卡片
              _buildSubscriptionCard(context, l10n),
              const SizedBox(height: 16),

              // 3. 第一个设置卡片组
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    CommonListTile(
                      title: l10n.petInfo,
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
                            'lo',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // 跳转到宠物档案页
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetDetailPage(device: device),
                          ),
                        );
                      },
                    ),
                    CommonListTile(
                      title: l10n.deviceShare,
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

              // 4. 第二个设置卡片组
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    CommonListTile(
                      title: l10n.alertSettings,
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
                      title: l10n.otherSettings,
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
                      title: l10n.helpAndFeedback,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpFeedbackPage(),
                          ),
                        );
                      },
                    ),
                    CommonListTile(
                      title: l10n.unbind,
                      titleColor: AppColors.errorRed,
                      hasBorderBottom: false,
                      showArrow: true, // 根据截图显示箭头
                      onTap: () => _showUnbindDialog(context, l10n),
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
  // 局部组件方法
  // ==============================================

  // 弹窗确认解绑
  void _showUnbindDialog(BuildContext context, AppLocalizations l10n) {
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
                Text(
                  l10n.unbind,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '解绑后设备及历史数据将被安全删除，您确定要解绑吗？', // Here we can use l10n if we have it, else hardcode
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
                        child: Text(
                          l10n.cancel,
                          style: const TextStyle(
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

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HomePage(hasDevice: false),
                            ),
                            (route) => false,
                          );

                          AppToast.showSuccess(
                            context,
                            '设备已解绑',
                          ); // Hardcoded for now
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFFFF5252), // 红色按钮
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: Text(
                          l10n.unbind,
                          style: const TextStyle(
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

  // 1. 设备基本信息卡片
  Widget _buildDeviceBaseInfoCard(BuildContext context, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        // 跳转到设备名称编辑页
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceNameEditPage(device: device),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 左侧设备图片
            Container(
              width: 80,
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
                      Icons.contact_support_outlined,
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
                  Text(
                    device.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.modelLabel('PT02E'), // 写入模拟数据，后期可换成模型字段
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildCopyableRow(context, 'IMEI', '865530078499001'),
                  const SizedBox(height: 6),
                  _buildCopyableRow(context, 'MAC', 'D4:0D:DE:04:F9:46'),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textHint,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // 包含可复制图标的信息行
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
            AppToast.showSuccess(
              context,
              AppLocalizations.of(context)!.copied(label),
            ); // 使用多语言
          },
          child: const Icon(
            Icons.content_copy,
            color: AppColors.textHint,
            size: 14,
          ), // 点击复制的图标
        ),
      ],
    );
  }

  // 2. 黑色订阅套餐卡片
  Widget _buildSubscriptionCard(BuildContext context, AppLocalizations l10n) {
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
        ), // ��΢�������±߾�
        decoration: BoxDecoration(
          color: AppColors.backgroundDark, // ��ɫ��
          borderRadius: BorderRadius.circular(24), // �Ŵ�Բ��
        ),
        child: Row(
          children: [
            // ����ɫ����ͼ��
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryYellow.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12), // ��΢�Ŵ�ͼ��׿�Բ��
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
                children: [
                  Text(
                    l10n.subscriptionPlan,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.expireTime('2027-03-27'),
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textHint,
                    ),
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
