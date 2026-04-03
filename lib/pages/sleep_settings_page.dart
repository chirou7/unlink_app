import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../utils/app_toast.dart';
import '../widgets/common_bottom_sheet.dart';

class SleepSettingsPage extends StatefulWidget {
  final dynamic device;
  const SleepSettingsPage({super.key, this.device});

  @override
  State<SleepSettingsPage> createState() => _SleepSettingsPageState();
}

class _SleepSettingsPageState extends State<SleepSettingsPage> {
  bool _isSleepEnabled = true;
  TimeOfDay _startTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 6, minute: 0);

  void _toggleSleep(bool value) {
    HapticFeedback.selectionClick();
    setState(() {
      _isSleepEnabled = value;
    });
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _showTimePicker(
    BuildContext context,
    AppLocalizations l10n,
    bool isStart,
  ) {
    HapticFeedback.selectionClick();
    TimeOfDay selectedTime = isStart ? _startTime : _endTime;

    // Define some preset quick times based on context
    List<TimeOfDay> presets = isStart
        ? const [
            TimeOfDay(hour: 21, minute: 0),
            TimeOfDay(hour: 22, minute: 0),
            TimeOfDay(hour: 23, minute: 0),
            TimeOfDay(hour: 0, minute: 0),
          ]
        : const [
            TimeOfDay(hour: 6, minute: 0),
            TimeOfDay(hour: 7, minute: 0),
            TimeOfDay(hour: 8, minute: 0),
            TimeOfDay(hour: 9, minute: 0),
          ];

    CommonBottomSheet.showTimePicker(
      context,
      title: l10n.selectTime,
      initialTime: selectedTime,
      presetTimes: presets,
      onSelected: (time) {
        setState(() {
          if (isStart) {
            _startTime = time;
          } else {
            _endTime = time;
          }
        });
      },
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
          l10n.sleepSettings,
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
                      _buildSwitchItem(
                        title: l10n.sleepSwitch,
                        subtitle: l10n.sleepSwitchDesc,
                        value: _isSleepEnabled,
                        onChanged: _toggleSleep,
                      ),
                      _buildSettingItem(
                        title: l10n.startTime,
                        subtitle: l10n.startTimeDesc,
                        trailingText: _formatTime(_startTime),
                        onTap: () => _showTimePicker(context, l10n, true),
                      ),
                      _buildSettingItem(
                        title: l10n.endTime,
                        subtitle: l10n.endTimeDesc,
                        trailingText: _formatTime(_endTime),
                        hasBorderBottom: false,
                        onTap: () => _showTimePicker(context, l10n, false),
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

  Widget _buildSwitchItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool hasBorderBottom = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: hasBorderBottom
            ? const Border(
                bottom: BorderSide(color: AppColors.dividerLight, width: 0.5),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
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
          const SizedBox(width: 16),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primaryYellow,
            inactiveTrackColor: AppColors.dividerLight,
          ),
        ],
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
                  bottom: BorderSide(color: AppColors.dividerLight, width: 0.5),
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
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
            const SizedBox(width: 16),
            Text(
              trailingText,
              style: const TextStyle(fontSize: 15, color: AppColors.textHint),
            ),
            const SizedBox(width: 4),
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
}
