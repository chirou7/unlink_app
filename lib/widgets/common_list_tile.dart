import 'package:flutter/material.dart';

class CommonListTile extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final String? trailingText;
  final VoidCallback? onTap;
  final bool hasBorderBottom;
  final bool showArrow;
  final Color? titleColor;

  const CommonListTile({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.trailingText,
    this.onTap,
    this.hasBorderBottom = true,
    this.showArrow = true,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) =>
      ListTile(title: Text(title), onTap: onTap);
}
