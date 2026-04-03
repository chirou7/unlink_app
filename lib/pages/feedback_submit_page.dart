import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';

class FeedbackSubmitPage extends StatefulWidget {
  const FeedbackSubmitPage({super.key});

  @override
  State<FeedbackSubmitPage> createState() => _FeedbackSubmitPageState();
}

class _FeedbackSubmitPageState extends State<FeedbackSubmitPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
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
        centerTitle: false,
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
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                l10n.feedbackButton, // "反馈"
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text Input Area
                      TextField(
                        controller: _textController,
                        maxLines: 8,
                        maxLength: 500,
                        decoration: InputDecoration(
                          hintText: l10n.feedbackDescHint,
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textHint,
                          ),
                          border: InputBorder.none,
                          counterText: '', // Hide default counter to match UI
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Image Upload Button
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          // TODO: Handle image picker
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              color: AppColors.textHint,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom Submit Button
            _buildBottomButton(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          // TODO: Handle submit action
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primaryYellow,
            borderRadius: BorderRadius.circular(28),
          ),
          alignment: Alignment.center,
          child: Text(
            l10n.submit, // "提交"
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
