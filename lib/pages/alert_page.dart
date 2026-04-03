import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';

class AlertPage extends StatefulWidget {
  final dynamic device;
  const AlertPage({super.key, this.device});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  // 0 for Alerts (告警), 1 for Messages (消息)
  final ValueNotifier<int> _tabIndexNotifier = ValueNotifier<int>(1);

  @override
  void dispose() {
    _tabIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomAppBar(context, l10n),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: _tabIndexNotifier,
                builder: (context, tabIndex, _) {
                  return IndexedStack(
                    index: tabIndex,
                    children: [
                      // 0: Alerts
                      _buildEmptyState(
                        title: l10n.noAlerts,
                        description: l10n.noAlertsDesc,
                      ),
                      // 1: Messages
                      _buildEmptyState(
                        title: l10n.noMessages,
                        description: l10n.noMessagesDesc,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context, AppLocalizations l10n) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Back button
          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              Navigator.of(context).pop();
            },
            behavior: HitTestBehavior.opaque,
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
          const SizedBox(width: 16), // Spacing between back arrow and tabs

          // Center-Left: Tab bar
          ValueListenableBuilder<int>(
            valueListenable: _tabIndexNotifier,
            builder: (context, tabIndex, _) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  _buildTabItem(
                    title: l10n.alertsTab,
                    isSelected: tabIndex == 0,
                    hasBadge: false, // Based on screenshot, alerts has no red dot
                    onTap: () {
                      HapticFeedback.selectionClick();
                      _tabIndexNotifier.value = 0;
                    },
                  ),
                  const SizedBox(width: 16), // Spacing between tabs
                  _buildTabItem(
                    title: l10n.messagesTab,
                    isSelected: tabIndex == 1,
                    hasBadge: true, // Based on screenshot, messages has a red dot
                    onTap: () {
                      HapticFeedback.selectionClick();
                      _tabIndexNotifier.value = 1;
                    },
                  ),
                ],
              );
            },
          ),

          const Spacer(),

          // Right: Action icons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionIcon(Icons.checklist_rtl, () {
                HapticFeedback.selectionClick();
              }),
              const SizedBox(width: 16),
              _buildActionIcon(Icons.mail_outline, () {
                HapticFeedback.selectionClick();
              }),
              const SizedBox(width: 16),
              _buildActionIcon(Icons.filter_alt_outlined, () {
                HapticFeedback.selectionClick();
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required String title,
    required bool isSelected,
    required bool hasBadge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isSelected ? 24 : 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.textPrimary : AppColors.textLight,
            ),
          ),
          if (hasBadge)
            Positioned(
              right: -8,
              top: isSelected ? 2 : 0,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.errorRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        icon,
        color: AppColors.textPrimary,
        size: 26,
      ),
    );
  }

  Widget _buildEmptyState({
    required String title,
    required String description,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Use Image.asset for 1:1 restoration (supports future replacement of 3D mailbox asset)
          Image.asset(
            'assets/images/empty_mailbox.png', // The exact 3D asset from the design
            width: 140,
            height: 140,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Graceful fallback to Icon if asset not yet added
              return const Icon(
                Icons.markunread_mailbox_outlined,
                size: 100,
                color: Color(0xFFD4D4D4),
              );
            },
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textHint,
            ),
          ),
          const SizedBox(height: 80), // Offset slightly above center
        ],
      ),
    );
  }
}
