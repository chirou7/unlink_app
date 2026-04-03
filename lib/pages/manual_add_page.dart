import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import 'pet_profile_page.dart';

class ManualAddPage extends StatefulWidget {
  const ManualAddPage({super.key});

  @override
  State<ManualAddPage> createState() => _ManualAddPageState();
}

class _ManualAddPageState extends State<ManualAddPage> {
  final TextEditingController _imeiController = TextEditingController();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _imeiController.addListener(() {
      _isButtonEnabled.value = _imeiController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _imeiController.dispose();
    _isButtonEnabled.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary, size: 26),
          onPressed: () {
            HapticFeedback.selectionClick();
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () =>
              FocusScope.of(context).unfocus(), // Dismiss keyboard on tap
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  l10n.findImeiSnHint, // "你可以在盒子背面或设备上找到IMEI/SN"
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/images/imei_instruction_box.png', // The 3D box instruction asset
                    width: 200,
                    height: 160,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Graceful fallback to Icon if asset not yet added
                      return Container(
                        width: 200,
                        height: 160,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.qr_code_scanner,
                          size: 64,
                          color: AppColors.textHint,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                _buildInputField(l10n),
                const SizedBox(height: 32),
                _buildNextButton(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(AppLocalizations l10n) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryYellow, width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _imeiController,
              focusNode: _focusNode,
              cursorColor: AppColors.primaryYellow,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: l10n.enterImeiSn, // "输入IMEI/SN"
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textHint,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              // TODO: Handle scan QR code
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.qr_code_scanner,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(AppLocalizations l10n) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isButtonEnabled,
      builder: (context, isEnabled, child) {
        return GestureDetector(
          onTap: isEnabled
              ? () {
                  HapticFeedback.selectionClick();
                  _focusNode.unfocus();
                  if (_imeiController.text.trim() == 'admin') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PetProfilePage(),
                      ),
                    );
                  } else {
                    // TODO: Handle next step action
                  }
                }
              : null,
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: isEnabled
                  ? AppColors.primaryYellow
                  : AppColors.primaryYellowLight,
              borderRadius: BorderRadius.circular(26),
            ),
            alignment: Alignment.center,
            child: Text(
              l10n.nextStep, // "下一步"
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isEnabled ? AppColors.textPrimary : AppColors.textHint,
              ),
            ),
          ),
        );
      },
    );
  }
}
