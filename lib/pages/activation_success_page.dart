import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import 'home_page.dart'; // Assuming it navigates to home_page after finish

class ActivationSuccessPage extends StatelessWidget {
  final String userName;

  const ActivationSuccessPage({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon
                  const Icon(
                    Icons.verified,
                    color: AppColors.successGreen,
                    size: 80,
                  ),
                  const SizedBox(height: 32),
                  
                  // Greeting Text
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(text: l10n.activationSuccessGreeting1),
                        TextSpan(
                          text: userName,
                          style: const TextStyle(
                            color: AppColors.primaryYellow,
                          ),
                        ),
                        TextSpan(text: l10n.activationSuccessGreeting2),
                      ],
                    ),
                  ),
                  // Slightly offset the center to match visual balance
                  const SizedBox(height: 60),
                ],
              ),
            ),
            
            // Finish Button
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  HapticFeedback.selectionClick();
                  // Navigate to HomePage and remove all previous routes
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(hasDevice: true),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.finish,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
