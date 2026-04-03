import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import 'manual_add_page.dart';

class AddDevicePage extends StatefulWidget {
  final dynamic device;
  const AddDevicePage({super.key, this.device});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _radarController;

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () {
            HapticFeedback.selectionClick();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: _buildMainScannerCard(context, l10n),
              ),
              const SizedBox(height: 16),
              _buildBottomActionCard(context, l10n),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainScannerCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            l10n.scanningNearbyDevices,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${l10n.bringPhoneClose}\n${l10n.keepDevicePoweredOn}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textHint,
              height: 1.5,
            ),
          ),
          Expanded(
            child: Center(
              child: _buildRadarAnimation(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarAnimation() {
    return AnimatedBuilder(
      animation: _radarController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Radar circles
            Container(
              width: 140 + (_radarController.value * 60),
              height: 140 + (_radarController.value * 60),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.infoBlue
                    .withValues(alpha: 0.05 * (1 - _radarController.value)),
              ),
            ),
            Container(
              width: 100 + (_radarController.value * 40),
              height: 100 + (_radarController.value * 40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.infoBlue
                    .withValues(alpha: 0.1 * (1 - _radarController.value)),
              ),
            ),
            // Phone icon
            Container(
              width: 80,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.textSecondary,
                  width: 2.5,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 30,
                    child: Container(
                      width: 3,
                      height: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 60,
                    child: Container(
                      width: 3,
                      height: 24,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomActionCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionItem(
            context,
            icon: Icons.video_label_outlined,
            label: l10n.addManually,
            onTap: () {
              HapticFeedback.selectionClick();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManualAddPage(),
                ),
              );
            },
          ),
          _buildActionItem(
            context,
            icon: Icons.qr_code_scanner,
            label: l10n.scanToAdd,
            onTap: () {
              HapticFeedback.selectionClick();
              // TODO: Navigate to scan code
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.backgroundGray,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 28,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
