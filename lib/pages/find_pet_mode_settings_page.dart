import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../utils/app_toast.dart';
import '../widgets/common_bottom_sheet.dart';

class FindPetModeSettingsPage extends StatefulWidget {
  final dynamic device;
  const FindPetModeSettingsPage({super.key, this.device});

  @override
  State<FindPetModeSettingsPage> createState() => _FindPetModeSettingsPageState();
}

class _FindPetModeSettingsPageState extends State<FindPetModeSettingsPage> {
  int _selectedDuration = 5; // 5 minutes
  int _selectedInterval = 5; // 5 seconds

  final List<int> _durationOptions = [1, 5, 30];
  final List<int> _intervalOptions = [3, 5];

  void _showDurationPicker(BuildContext context, AppLocalizations l10n) {
    HapticFeedback.selectionClick();
    CommonBottomSheet.show(
      context,
      title: l10n.duration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _durationOptions.map((duration) {
          final isSelected = _selectedDuration == duration;
          return InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                _selectedDuration = duration;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.dividerLight,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.minute(duration),
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check,
                      color: AppColors.primaryYellow,
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showIntervalPicker(BuildContext context, AppLocalizations l10n) {
    HapticFeedback.selectionClick();
    CommonBottomSheet.show(
      context,
      title: l10n.updateInterval,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _intervalOptions.map((interval) {
          final isSelected = _selectedInterval == interval;
          return InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                _selectedInterval = interval;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.dividerLight,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.second(interval),
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check,
                      color: AppColors.primaryYellow,
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

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
            Icons.arrow_back_ios_new,
            color: Color(0xFF111111),
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.findPetMode,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111111),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      _buildSettingItem(
                        title: l10n.duration,
                        subtitle: l10n.durationDesc,
                        trailingText: l10n.minute(_selectedDuration),
                        onTap: () => _showDurationPicker(context, l10n),
                      ),
                      _buildSettingItem(
                        title: l10n.updateInterval,
                        subtitle: l10n.updateIntervalDesc,
                        trailingText: l10n.second(_selectedInterval),
                        hasBorderBottom: false,
                        onTap: () => _showIntervalPicker(context, l10n),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    AppToast.showSuccess(context, l10n.save);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryYellow,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    l10n.save,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    required String trailingText,
    bool hasBorderBottom = true,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: hasBorderBottom
              ? const Border(
                  bottom: BorderSide(
                    color: AppColors.dividerLight,
                    width: 0.5,
                  ),
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  trailingText,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textHint,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textHint,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}