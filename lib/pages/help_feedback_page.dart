import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import 'feedback_submit_page.dart';
import 'service_status_page.dart';

class HelpFeedbackPage extends StatelessWidget {
  const HelpFeedbackPage({super.key});

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
          l10n.helpAndFeedback,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.sms_outlined,
              color: AppColors.textPrimary,
              size: 24,
            ),
            onPressed: () {
              HapticFeedback.selectionClick();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServiceStatusPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildMyDevicesCard(l10n),
                    const SizedBox(height: 16),
                    _buildFaqCard(l10n),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomButton(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildMyDevicesCard(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.myDevices,
            style: const TextStyle(fontSize: 14, color: AppColors.textHint),
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                // Supports local 3D box image if available, otherwise falls back to icon
                Image.asset(
                  'assets/images/empty_device_box.png',
                  width: 64,
                  height: 64,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.inbox_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.noDeviceBound,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textHint,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqCard(AppLocalizations l10n) {
    final faqs = [
      l10n.faqRegister,
      l10n.faqResetPwd,
      l10n.faqGeofence,
      l10n.faqBindDevice,
      l10n.faqShareDevice,
      l10n.faqUnbindDevice,
      l10n.faqOrders,
      l10n.faqAlertSettings,
      l10n.faqDeviceSettings,
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              l10n.faq,
              style: const TextStyle(fontSize: 14, color: AppColors.textHint),
            ),
          ),
          const SizedBox(height: 8),
          ...faqs.map((faq) => _buildFaqItem(faq)),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String title) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        // TODO: Navigate to FAQ detail
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FeedbackSubmitPage()),
          );
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: 56, // Tall button to match design
          decoration: BoxDecoration(
            color: AppColors.primaryYellow,
            borderRadius: BorderRadius.circular(28),
          ),
          alignment: Alignment.center,
          child: Text(
            l10n.feedbackButton,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary, // Black text on yellow background
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
