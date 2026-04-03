import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/device_model.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../widgets/common_app_bar.dart';

class FindPetPage extends StatelessWidget {
  final dynamic mode;
  final DeviceModel? device;

  const FindPetPage({super.key, this.mode, this.device});

  DeviceModel get _device => device ?? DeviceModel.getMockDevices().first;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CommonAppBar(
        title: _device.name,
        centerTitle: false,
        trailing: IconButton(
          icon: const Icon(Icons.tune, color: AppColors.textPrimary, size: 24),
          onPressed: () {
            HapticFeedback.selectionClick();
          },
        ),
      ),
      body: Column(
        children: [
          _buildStatusBar(context, l10n),
          Expanded(
            child: Stack(
              children: [
                _buildMapBackground(),
                _buildMapMarker(),
                _buildFloatingControls(),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildBottomPanel(context, l10n),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context, AppLocalizations l10n) {
    return Container(
      color: AppColors.backgroundWhite,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildStatusItem(
              Icons.battery_charging_full, '${_device.batteryLevel}%', AppColors.successGreen),
          const SizedBox(width: 20),
          _buildStatusItem(Icons.pets, _device.status, AppColors.successGreen),
          const SizedBox(width: 20),
          _buildStatusItem(Icons.signal_cellular_alt, _device.networkType, AppColors.successGreen),
          const SizedBox(width: 20),
          _buildStatusItem(Icons.gps_fixed, l10n.gps, AppColors.successGreen),
        ],
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMapBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFEAF4EE), // Very light greenish map color
      child: Image.network(
        'https://images.unsplash.com/photo-1524661135-423995f22d0b?q=80&w=800&auto=format&fit=crop',
        fit: BoxFit.cover,
        opacity: const AlwaysStoppedAnimation(0.6), // Dim it slightly
        errorBuilder: (c, e, s) => Container(
          color: const Color(0xFFEAF4EE),
          alignment: Alignment.center,
          child: const Icon(Icons.map, size: 64, color: AppColors.textHint),
        ),
      ),
    );
  }

  Widget _buildMapMarker() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    _device.imageUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      width: 56,
                      height: 56,
                      color: AppColors.backgroundLight,
                      child: const Icon(Icons.pets, color: AppColors.textHint),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.pets, size: 12, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.infoBlue,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.backgroundWhite, width: 3),
              boxShadow: [
                BoxShadow(color: AppColors.infoBlue.withValues(alpha: 0.4), blurRadius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingControls() {
    return Positioned(
      right: 16,
      bottom: 220, // Adjust based on bottom panel height to stay above
      child: Container(
        width: 44,
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.map_outlined, color: AppColors.textPrimary, size: 22),
              onPressed: () {
                HapticFeedback.selectionClick();
              },
            ),
            const Divider(height: 1, indent: 8, endIndent: 8, color: AppColors.dividerLight),
            IconButton(
              icon: const Icon(Icons.my_location, color: AppColors.textPrimary, size: 22),
              onPressed: () {
                HapticFeedback.selectionClick();
              },
            ),
            const Divider(height: 1, indent: 8, endIndent: 8, color: AppColors.dividerLight),
            IconButton(
              icon: const Icon(Icons.sync, color: AppColors.infoBlue, size: 22),
              onPressed: () {
                HapticFeedback.selectionClick();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPanel(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  _device.address,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryYellow.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.turn_right, color: AppColors.primaryYellow, size: 24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.now,
            style: const TextStyle(fontSize: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: _buildSecondaryButton(Icons.lightbulb_outline, l10n.light),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: _buildSecondaryButton(Icons.volume_up, l10n.sound),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _buildPrimaryButton(Icons.campaign, l10n.findPet),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.textPrimary),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF22C55E),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.backgroundWhite),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
