import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';

class AlertSettingsPage extends StatefulWidget {
  final dynamic device;
  const AlertSettingsPage({super.key, this.device});

  @override
  State<AlertSettingsPage> createState() => _AlertSettingsPageState();
}

class _AlertSettingsPageState extends State<AlertSettingsPage> {
  // Mock state for all the switches
  final Map<String, bool> _switchStates = {
    'stopCharging': true,
    'startCharging': true,
    'outOfFenceAlert': true,
    'inFenceAlert': true,
    'stopMoving': true,
    'startMoving': true,
    'enterFence': true,
    'leaveFence': true,
    'devicePowerOn': true,
    'bluetoothConnected': true,
    'bluetoothDisconnected': true,
    'devicePowerOff': true,
    'deviceActivated': true,
  };

  void _toggleSwitch(String key, bool value) {
    HapticFeedback.selectionClick();
    setState(() {
      _switchStates[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // List of settings mapping to l10n strings and their state keys
    final List<Map<String, dynamic>> settingsList = [
      {'title': l10n.stopCharging, 'key': 'stopCharging'},
      {'title': l10n.startCharging, 'key': 'startCharging'},
      {'title': l10n.outOfFenceAlert, 'key': 'outOfFenceAlert'},
      {'title': l10n.inFenceAlert, 'key': 'inFenceAlert'},
      {'title': l10n.stopMoving, 'key': 'stopMoving'},
      {'title': l10n.startMoving, 'key': 'startMoving'},
      {'title': l10n.enterFence, 'key': 'enterFence'},
      {'title': l10n.leaveFence, 'key': 'leaveFence'},
      {'title': l10n.devicePowerOn, 'key': 'devicePowerOn'},
      {'title': l10n.bluetoothConnected, 'key': 'bluetoothConnected'},
      {'title': l10n.bluetoothDisconnected, 'key': 'bluetoothDisconnected'},
      {'title': l10n.devicePowerOff, 'key': 'devicePowerOff'},
      {'title': l10n.deviceActivated, 'key': 'deviceActivated'},
    ];

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
          l10n.alertSettingsTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111111),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: settingsList.length,
          itemBuilder: (context, index) {
            final setting = settingsList[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                title: Text(
                  setting['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                value: _switchStates[setting['key']] ?? false,
                onChanged: (value) => _toggleSwitch(setting['key'], value),
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primaryYellow,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: AppColors.dividerLight,
              ),
            );
          },
        ),
      ),
    );
  }
}
