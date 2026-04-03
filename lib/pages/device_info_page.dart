import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/device_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_toast.dart'; // �����Զ��� Toast ������
import '../widgets/common_list_tile.dart';
import 'pet_detail_page.dart'; // ����������ת�ĳ�������ҳ��
import 'device_share_page.dart'; // �����豸����ҳ��
import 'alert_settings_page.dart'; // ����澯����ҳ��
import 'device_settings_page.dart'; // ���������豸����ҳ��
import 'help_feedback_page.dart'; // ��������뷴��ҳ��
import 'subscription_plan_page.dart'; // ���붩�ļƻ�ҳ��
import 'home_page.dart'; // ������ҳ�Ա������ת

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
          '�豸��Ϣ',
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
              // 1. �����豸������Ϣ��Ƭ
              _buildDeviceBaseInfoCard(context),
              const SizedBox(height: 16),

              // 2. ��ɫ�����ײͿ�Ƭ
              _buildSubscriptionCard(context),
              const SizedBox(height: 16),

              // 3. �������ÿ�Ƭ��
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    CommonListTile(
                      title: '������Ϣ',
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
                        // ��ת����������ҳ (Ŀǰ�����еĴ����ݵ�ҳ�����)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetDetailPage(device: device),
                          ),
                        );
                      },
                    ),
                    CommonListTile(
                      title: '�豸����',
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

              // 4. �����������ÿ�Ƭ��
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    CommonListTile(
                      title: '��������',
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
                      title: '��������',
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
                      title: '�����뷴��',
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
                      title: '���',
                      titleColor: AppColors.errorRed,
                      hasBorderBottom: false,
                      showArrow: false,
                      onTap: () => _showUnbindDialog(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40), // �ײ�����
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================
  // �ֲ�������
  // ==============================================

  // �������ȷ�ϵ���
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
                  '���',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '�����豸����ʷ���ݽ�����ȫɾ������ȷ��Ҫ�����',
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
                          'ȡ��',
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
                          // �رյײ�����
                          Navigator.pop(context);

                          // ���ص���ҳ��������һ����־��ʾ�豸�ѽ��
                          // ��Ϊ�м���� DeviceMainPage �� DeviceDetailPage��
                          // ����ʹ�� popUntil һֱ���ص� HomePage��
                          // ��ͨ�� pushReplacement ���¼���һ���յ� HomePage
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HomePage(hasDevice: false),
                            ),
                            (route) => false,
                          );

                          // ��ʾ�Զ���ĳɹ���ʾ��Ϣ
                          AppToast.showSuccess(context, '�豸�ѽ��');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFFFF5252), // ��ɫ���ť
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: const Text(
                          '���',
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

  // 1. �豸������Ϣ��Ƭ
  Widget _buildDeviceBaseInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(24), // �������ͼ�Ŵ�Բ��
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ����豸ͼƬ
          Container(
            width: 80, // �������ͼ�Ŵ�ͼƬռλ
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
                    Icons.contact_support_outlined, // ���������ʺŵ�ͼ��
                    color: AppColors.textHint,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // �Ҳ���ϸ��Ϣ
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
                  '�ͺ�: PT02E', // д��ģ�����ݣ����ڿɻ���ģ���ֶ�
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

  // ���и���ͼ�����Ϣ��
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
            AppToast.showSuccess(context, '$label �Ѹ���'); // ʹ���Զ��� Toast
          },
          child: const Icon(
            Icons.content_copy,
            color: AppColors.textHint,
            size: 14,
          ), // ���ɸ������ͼ����ҳֽ����ͼ��
        ),
      ],
    );
  }

  // 2. ��ɫ�Ķ��Ŀ�Ƭ
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
                children: const [
                  Text(
                    '��� - �������-�����ײ�',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '����ʱ�� 2027-03-27',
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
