import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';

class CommonBottomSheet {
  static void showRadioList(
    BuildContext context, {
    required String title,
    required List<String> options,
    required String value,
    required Function(String) onChanged,
  }) {}
  static void showInput(
    BuildContext context, {
    required String title,
    required String hint,
    required String value,
    required Function(String) onChanged,
  }) {}
  static void showNumberPicker(
    BuildContext context, {
    required String title,
    required int initialValue,
    required int min,
    required int max,
    required Function(int) onSelected,
  }) {}
  static void show(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              // Top drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }

  static void showTimePicker(
    BuildContext context, {
    required String title,
    required TimeOfDay initialTime,
    required Function(TimeOfDay) onSelected,
    List<TimeOfDay>? presetTimes, // Optional preset quick choices
  }) {
    final l10n = AppLocalizations.of(context)!;
    int selectedHour = initialTime.hour;
    int selectedMinute = initialTime.minute;

    // Use FixedExtentScrollController so we can jump to specific items programmatically
    final FixedExtentScrollController hourController =
        FixedExtentScrollController(initialItem: selectedHour);
    final FixedExtentScrollController minuteController =
        FixedExtentScrollController(initialItem: selectedMinute);

    show(
      context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Optional Preset Chips
          if (presetTimes != null && presetTimes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: presetTimes.map((time) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        label: Text(
                          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        backgroundColor: AppColors.backgroundGray,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          selectedHour = time.hour;
                          selectedMinute = time.minute;
                          // Animate to selected item
                          hourController.animateToItem(
                            selectedHour,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          minuteController.animateToItem(
                            selectedMinute,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 自定义选中背景
                Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker.builder(
                        scrollController: hourController,
                        itemExtent: 40,
                        selectionOverlay: null,
                        childCount: null, // null means infinite looping
                        onSelectedItemChanged: (index) {
                          HapticFeedback.selectionClick();
                          // Adjust for infinite loop mapping
                          selectedHour = index % 24;
                          if (selectedHour < 0) selectedHour += 24;
                        },
                        itemBuilder: (context, index) {
                          int hour = index % 24;
                          if (hour < 0) hour += 24;
                          return Center(
                            child: Text(
                              hour.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                fontSize: 20,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker.builder(
                        scrollController: minuteController,
                        itemExtent: 40,
                        selectionOverlay: null,
                        childCount: null, // null means infinite looping
                        onSelectedItemChanged: (index) {
                          HapticFeedback.selectionClick();
                          // Adjust for infinite loop mapping
                          selectedMinute = index % 60;
                          if (selectedMinute < 0) selectedMinute += 60;
                        },
                        itemBuilder: (context, index) {
                          int minute = index % 60;
                          if (minute < 0) minute += 60;
                          return Center(
                            child: Text(
                              minute.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                fontSize: 20,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  HapticFeedback.selectionClick();
                  onSelected(
                    TimeOfDay(hour: selectedHour, minute: selectedMinute),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  l10n.save,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showDatePicker(
    BuildContext context, {
    required String title,
    required DateTime initialDate,
    required Function(DateTime) onSelected,
    Function()? onCancel,
    Widget? customBottomWidget,
  }) {}
}
