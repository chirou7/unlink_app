import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';

class LanguagePage extends StatelessWidget {
  final String currentLang;

  const LanguagePage({
    super.key,
    required this.currentLang,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Using native names for languages
    final languages = [
      'English',
      '中文',
      'Français',
      'Español',
      'Italiano',
      'Português',
      'Türkçe',
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 22),
          onPressed: () {
            HapticFeedback.selectionClick();
            Navigator.pop(context);
          },
        ),
        title: Text(
          l10n.language,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: languages.length,
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
              thickness: 0.5,
              color: AppColors.dividerLighter,
            ),
          ),
          itemBuilder: (context, index) {
            final lang = languages[index];
            final isSelected = lang == currentLang;
            
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                // Return selected language to previous page
                Navigator.pop(context, lang);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check,
                        color: AppColors.primaryYellow,
                        size: 20,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
