import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppToast {
  /// 显示成功提示
  static void showSuccess(BuildContext context, String message) {
    HapticFeedback.lightImpact();
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.check_circle,
      iconColor: AppColors.successGreen,
    );
  }

  /// 显示错误提示
  static void showError(BuildContext context, String message) {
    HapticFeedback.mediumImpact();
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.error,
      iconColor: AppColors.errorRed,
    );
  }

  /// 显示信息提示
  static void showInfo(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.info,
      iconColor: AppColors.infoBlue,
    );
  }

  /// 内部基础实现
  static void _showCustomSnackBar({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color iconColor,
  }) {
    // 移除当前正在显示的 SnackBar，防止排队堆叠
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
          bottom: 32, // 距离底部留一定间距，防遮挡
        ),
        elevation: 8, // 加大点阴影
        duration: const Duration(seconds: 2), // 默认显示2秒
      ),
    );
  }
}
