import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';

class AboutPage extends StatelessWidget {
  final dynamic device;
  const AboutPage({super.key, this.device});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.textPrimary,
            size: 22,
          ),
          onPressed: () {
            HapticFeedback.selectionClick();
            Navigator.pop(context);
          },
        ),
        title: Text(
          l10n.about, // "关于"
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRow(
                  title: l10n.termsOfUse, // "使用条款"
                  showArrow: true,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    // TODO: Navigate to Terms of Use
                  },
                ),
                _buildDivider(),
                _buildRow(
                  title: l10n.privacyPolicy, // "隐私政策"
                  showArrow: true,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    // TODO: Navigate to Privacy Policy
                  },
                ),
                _buildDivider(),
                _buildRow(
                  title: l10n.appVersion, // "版本"
                  valueText: "V2.7.6", // Usually comes from package_info_plus, hardcoded for UI accuracy
                  showArrow: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow({
    required String title,
    String? valueText,
    required bool showArrow,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
            Row(
              children: [
                if (valueText != null)
                  Text(
                    valueText,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textHint,
                    ),
                  ),
                if (valueText != null && showArrow) const SizedBox(width: 8),
                if (showArrow)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.textHint,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: AppColors.dividerLighter,
      ),
    );
  }
}
