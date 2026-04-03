import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppToast {
  /// ��ʾ�ɹ���ʾ (��ɫͼ�꣬������΢�𶯷���)
  static void showSuccess(BuildContext context, String message) {
    HapticFeedback.lightImpact();
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.check_circle,
      iconColor: AppColors.successGreen,
    );
  }

  /// ��ʾ����/������ʾ (��ɫͼ�꣬�����е��𶯷���)
  static void showError(BuildContext context, String message) {
    HapticFeedback.mediumImpact();
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.error,
      iconColor: AppColors.errorRed,
    );
  }

  /// ��ʾ��ͨ��Ϣ��ʾ (��ɫͼ��)
  static void showInfo(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.info,
      iconColor: AppColors.infoBlue,
    );
  }

  /// �ڲ�����ʵ�ַ���
  static void _showCustomSnackBar({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color iconColor,
  }) {
    // �Ƴ���ǰ����������ʾ�� SnackBar����ֹ�ŶӶѵ�
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
        backgroundColor: Colors.white, // �׵׿�Ƭ
        behavior: SnackBarBehavior.floating, // ������ʽ
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // ��Բ��
        ),
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 32, // ����ײ���һ�����ף�������
        ),
        elevation: 8, // ��������Ӱ
        duration: const Duration(seconds: 2), // Ĭ����ʾ2��
      ),
    );
  }
}
