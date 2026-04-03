import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import 'find_pet_mode_settings_page.dart';
import 'light_settings_page.dart';
import 'sleep_settings_page.dart';
import 'device_check_page.dart';
import 'firmware_upgrade_page.dart';

class DeviceSettingsPage extends StatefulWidget {
  final dynamic device;
  const DeviceSettingsPage({super.key, this.device});

  @override
  State<DeviceSettingsPage> createState() => _DeviceSettingsPageState();
}

class _DeviceSettingsPageState extends State<DeviceSettingsPage> {
  bool _powerSavingMode = false;

  void _togglePowerSaving(bool value) {
    HapticFeedback.selectionClick();
    setState(() {
      _powerSavingMode = value;
    });
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
          l10n.deviceSettingsTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111111),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                _buildSettingItem(
                  title: l10n.findPetMode,
                  subtitle: l10n.findPetModeDesc,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FindPetModeSettingsPage(device: widget.device),
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  title: l10n.soundSettings,
                  subtitle: l10n.soundSettingsDesc,
                  trailingText: '30${l10n.timesSuffix}',
                  onTap: () {},
                ),
                _buildSettingItem(
                  title: l10n.lightSettings,
                  subtitle: l10n.lightSettingsDesc,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LightSettingsPage(device: widget.device),
                      ),
                    );
                  },
                ),
                _buildSwitchItem(
                  title: l10n.powerSavingMode,
                  value: _powerSavingMode,
                  onChanged: _togglePowerSaving,
                ),
                _buildSettingItem(
                  title: l10n.sleepSettings,
                  subtitle: l10n.sleepSettingsDesc,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SleepSettingsPage(device: widget.device),
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  title: l10n.deviceSelfTest,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DeviceCheckPage(device: widget.device),
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  title: l10n.bluetoothFirmwareUpgrade,
                  hasBorderBottom: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FirmwareUpgradePage(device: widget.device),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    String? subtitle,
    String? trailingText,
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
                if (trailingText != null) ...[
                  Text(
                    trailingText,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textHint,
                  size: 20,
                ),
              ],
            ),
            if (subtitle != null) ...[
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
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool hasBorderBottom = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: hasBorderBottom
            ? const Border(
                bottom: BorderSide(color: AppColors.dividerLight, width: 0.5),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
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
}
