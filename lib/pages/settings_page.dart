import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import 'language_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ValueNotifier<String> _unitNotifier = ValueNotifier('km,km/h');
  final ValueNotifier<String> _tempNotifier = ValueNotifier('celsius');
  final ValueNotifier<String> _mapNotifier = ValueNotifier('baiduMap');
  final ValueNotifier<String> _langNotifier = ValueNotifier('中文');

  @override
  void dispose() {
    _unitNotifier.dispose();
    _tempNotifier.dispose();
    _mapNotifier.dispose();
    _langNotifier.dispose();
    super.dispose();
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
          l10n.settings,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Settings Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildSettingRow(
                    title: l10n.unitSettings,
                    valueNotifier: _unitNotifier,
                    onTap: () => _showUnitBottomSheet(context, l10n),
                  ),
                  _buildDivider(),
                  _buildSettingRow(
                    title: l10n.tempUnit,
                    valueNotifier: _tempNotifier,
                    valueMapper: (val) =>
                        val == 'celsius' ? l10n.celsius : l10n.fahrenheit,
                    onTap: () => _showTempBottomSheet(context, l10n),
                  ),
                  _buildDivider(),
                  _buildSettingRow(
                    title: l10n.mapSelection,
                    valueNotifier: _mapNotifier,
                    valueMapper: (val) =>
                        val == 'baiduMap' ? l10n.baiduMap : l10n.googleMap,
                    onTap: () => _showMapBottomSheet(context, l10n),
                  ),
                  _buildDivider(),
                  _buildSettingRow(
                    title: l10n.language,
                    valueNotifier: _langNotifier,
                    onTap: () async {
                      HapticFeedback.selectionClick();
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LanguagePage(currentLang: _langNotifier.value),
                        ),
                      );
                      if (result != null && result is String) {
                        _langNotifier.value = result;
                      }
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Bottom Buttons
            GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                // TODO: Handle logout
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(28),
                ),
                alignment: Alignment.center,
                child: Text(
                  l10n.logout,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.errorRed,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                // TODO: Handle delete account
              },
              behavior: HitTestBehavior.opaque,
              child: Text(
                l10n.deleteAccount,
                style: const TextStyle(fontSize: 14, color: AppColors.errorRed),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow({
    required String title,
    required ValueNotifier<String> valueNotifier,
    String Function(String)? valueMapper,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                ValueListenableBuilder<String>(
                  valueListenable: valueNotifier,
                  builder: (context, val, _) {
                    final displayValue = valueMapper != null
                        ? valueMapper(val)
                        : val;
                    return Text(
                      displayValue,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textHint,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
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

  void _showUnitBottomSheet(BuildContext context, AppLocalizations l10n) {
    _showSelectionBottomSheet(
      context: context,
      options: ['km,km/h', 'mi,mph'],
      labels: ['km,km/h', 'mi,mph'],
      notifier: _unitNotifier,
      cancelText: l10n.cancel,
    );
  }

  void _showTempBottomSheet(BuildContext context, AppLocalizations l10n) {
    _showSelectionBottomSheet(
      context: context,
      options: ['celsius', 'fahrenheit'],
      labels: [l10n.celsius, l10n.fahrenheit],
      notifier: _tempNotifier,
      cancelText: l10n.cancel,
    );
  }

  void _showMapBottomSheet(BuildContext context, AppLocalizations l10n) {
    _showSelectionBottomSheet(
      context: context,
      options: ['googleMap', 'baiduMap'],
      labels: [l10n.googleMap, l10n.baiduMap],
      notifier: _mapNotifier,
      cancelText: l10n.cancel,
    );
  }

  void _showSelectionBottomSheet({
    required BuildContext context,
    required List<String> options,
    required List<String> labels,
    required ValueNotifier<String> notifier,
    required String cancelText,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(options.length, (index) {
                  final option = options[index];
                  final label = labels[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          notifier.value = option;
                          Navigator.pop(context);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Text(
                                  label,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              if (notifier.value == option)
                                const Positioned(
                                  right: 0,
                                  child: Icon(
                                    Icons.check,
                                    color: AppColors.primaryYellow,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 0.5,
                        color: AppColors.dividerLighter,
                      ),
                    ],
                  );
                }),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.pop(context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: Text(
                      cancelText,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
