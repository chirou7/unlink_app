import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing; // �Ҳ��Զ������ (�籣�水ť������ͼ��)
  final VoidCallback? onBack; // �Զ��巵���߼�
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
