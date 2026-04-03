import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';

class ServiceStatusPage extends StatefulWidget {
  const ServiceStatusPage({super.key});

  @override
  State<ServiceStatusPage> createState() => _ServiceStatusPageState();
}

class _ServiceStatusPageState extends State<ServiceStatusPage> {
  // 0: 全部状态 (All), 1: 待处理 (Pending), 2: 处理中 (Processing), 3: 已完成 (Completed)
  final ValueNotifier<int> _tabIndexNotifier = ValueNotifier<int>(1);

  @override
  void dispose() {
    _tabIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final tabs = [
      l10n.statusAll,
      l10n.statusPending,
      l10n.statusProcessing,
      l10n.statusCompleted,
    ];

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
          l10n.serviceStatus,
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
            // Horizontal Tab Bar
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ValueListenableBuilder<int>(
                valueListenable: _tabIndexNotifier,
                builder: (context, currentIndex, _) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final isSelected = index == currentIndex;
                      return GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          _tabIndexNotifier.value = index;
                        },
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryYellow : AppColors.backgroundWhite,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? AppColors.textPrimary : AppColors.textHint,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            
            // Empty State Content
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: _tabIndexNotifier,
                builder: (context, index, _) {
                  // We show the same empty state for all tabs as per UI
                  return _buildEmptyState(l10n);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Use Image.asset for 1:1 restoration
          Image.asset(
            'assets/images/empty_document.png', // The 3D document asset
            width: 120,
            height: 120,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Graceful fallback to Icon if asset not yet added
              return const Icon(
                Icons.snippet_folder_rounded,
                size: 80,
                color: Color(0xFFD4D4D4),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            l10n.noData,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 100), // offset slightly above center
        ],
      ),
    );
  }
}
