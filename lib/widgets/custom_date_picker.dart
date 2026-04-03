import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateChanged;

  const CustomDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;

  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;

  final int minYear = 1990;
  final int maxYear = DateTime.now().year + 10;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
    selectedDay = widget.initialDate.day;

    _yearController = FixedExtentScrollController(
      initialItem: selectedYear - minYear,
    );
    _monthController = FixedExtentScrollController(
      initialItem: selectedMonth - 1,
    );
    _dayController = FixedExtentScrollController(
      initialItem: selectedDay - 1,
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  int _getDaysInMonth(int year, int month) {
    if (month == 2) {
      bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }

  void _notifyDateChanged() {
    // Ensure day is valid for the new month/year
    final maxDays = _getDaysInMonth(selectedYear, selectedMonth);
    if (selectedDay > maxDays) {
      setState(() {
        selectedDay = maxDays;
        _dayController.jumpToItem(selectedDay - 1);
      });
    }
    widget.onDateChanged(DateTime(selectedYear, selectedMonth, selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final int currentMaxDays = _getDaysInMonth(selectedYear, selectedMonth);

    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background selection indicator
          Container(
            height: 44,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          // Scroll wheels
          Row(
            children: [
              // Year
              Expanded(
                child: _buildWheel(
                  controller: _yearController,
                  itemCount: maxYear - minYear + 1,
                  onSelectedItemChanged: (index) {
                    HapticFeedback.selectionClick();
                    setState(() {
                      selectedYear = minYear + index;
                    });
                    _notifyDateChanged();
                  },
                  itemBuilder: (context, index) {
                    final year = minYear + index;
                    final isSelected = year == selectedYear;
                    return _buildWheelItem(
                      text: '$year${l10n.yearSuffix}',
                      isSelected: isSelected,
                    );
                  },
                ),
              ),
              // Month
              Expanded(
                child: _buildWheel(
                  controller: _monthController,
                  itemCount: 12,
                  onSelectedItemChanged: (index) {
                    HapticFeedback.selectionClick();
                    setState(() {
                      selectedMonth = index + 1;
                    });
                    _notifyDateChanged();
                  },
                  itemBuilder: (context, index) {
                    final month = index + 1;
                    final isSelected = month == selectedMonth;
                    return _buildWheelItem(
                      text: '$month${l10n.monthSuffix}',
                      isSelected: isSelected,
                    );
                  },
                ),
              ),
              // Day
              Expanded(
                child: _buildWheel(
                  controller: _dayController,
                  itemCount: currentMaxDays,
                  onSelectedItemChanged: (index) {
                    HapticFeedback.selectionClick();
                    setState(() {
                      selectedDay = index + 1;
                    });
                    _notifyDateChanged();
                  },
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final isSelected = day == selectedDay;
                    return _buildWheelItem(
                      text: '$day${l10n.daySuffix}',
                      isSelected: isSelected,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required ValueChanged<int> onSelectedItemChanged,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 44,
      perspective: 0.005,
      diameterRatio: 1.5,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: itemBuilder,
        childCount: itemCount,
      ),
    );
  }

  Widget _buildWheelItem({required String text, required bool isSelected}) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: isSelected ? AppColors.textPrimary : const Color(0xFFBDBDBD),
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }
}
