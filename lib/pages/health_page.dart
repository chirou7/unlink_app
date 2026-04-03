import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/device_model.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../widgets/common_app_bar.dart';
import 'package:intl/intl.dart';

class HealthPage extends StatefulWidget {
  final dynamic mode;
  final DeviceModel? device;

  const HealthPage({super.key, this.mode, this.device});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  DeviceModel get _device => widget.device ?? DeviceModel.getMockDevices().first;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CommonAppBar(
        title: _device.name,
        centerTitle: false,
        trailing: IconButton(
          icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary, size: 24),
          onPressed: () {
            HapticFeedback.selectionClick();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCalendarStrip(context, l10n),
            const SizedBox(height: 16),
            _buildActivityOverviewCard(context, l10n),
            _buildChartCard(context, l10n, l10n.activity, '00:00:00'),
            _buildChartCard(context, l10n, l10n.steps, '0'),
            _buildCaloriesCard(context, l10n),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarStrip(BuildContext context, AppLocalizations l10n) {
    final now = DateTime.now();
    // Generate 5 days ending at today
    final days = List.generate(5, (index) => now.subtract(Duration(days: 4 - index)));
    final monthStr = DateFormat('MMM').format(now);

    return Container(
      color: AppColors.backgroundWhite,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...days.map((date) => _buildDayItem(date, date.day == _selectedDate.day, l10n)),
          // Month and Calendar icon
          Column(
            children: [
              Text(
                monthStr,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  // TODO: Open date picker
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerLight),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.calendar_today, size: 18, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayItem(DateTime date, bool isSelected, AppLocalizations l10n) {
    final isToday = date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year;

    String weekdayStr;
    switch (date.weekday) {
      case 1: weekdayStr = l10n.mon; break;
      case 2: weekdayStr = l10n.tue; break;
      case 3: weekdayStr = l10n.wed; break;
      case 4: weekdayStr = l10n.thu; break;
      case 5: weekdayStr = l10n.fri; break;
      case 6: weekdayStr = l10n.sat; break;
      case 7: weekdayStr = l10n.sun; break;
      default: weekdayStr = '';
    }

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() {
          _selectedDate = date;
        });
      },
      child: Column(
        children: [
          if (isToday)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryYellow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                l10n.today,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            )
          else
            Text(
              weekdayStr,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primaryYellow : AppColors.dividerLight,
                width: isSelected ? 2 : 1,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityOverviewCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.activity,
                style: const TextStyle(fontSize: 15, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    '0',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  Text(
                    ' /180 ${l10n.minutes}',
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.check_circle, color: AppColors.successGreen, size: 16),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                l10n.progress,
                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    '0',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const Text(
                    ' %',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
          // Circular Progress Placeholder
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryYellowLight.withValues(alpha: 0.3), width: 12),
            ),
            alignment: Alignment.center,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.textPrimary, width: 1.5),
              ),
              child: const Icon(Icons.add, size: 20, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(BuildContext context, AppLocalizations l10n, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const Text(
                '-',
                style: TextStyle(fontSize: 24, color: AppColors.textHint),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Chart Placeholder
          _buildChartPlaceholder(),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder() {
    return Column(
      children: [
        ...List.generate(5, (index) {
          final val = 125 - (index * 25);
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: Text(
                    val == 0 ? '0' : val.toString(),
                    style: const TextStyle(fontSize: 10, color: AppColors.textHint),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Divider(height: 1, color: AppColors.dividerLight),
                ),
              ],
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('00:00', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
              Text('06:00', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
              Text('12:00', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
              Text('18:00', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
              Text('24:00', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCaloriesCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.calories,
            style: const TextStyle(fontSize: 15, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.errorRed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.local_fire_department, color: AppColors.backgroundWhite, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                '0',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 4),
              Text(
                l10n.kcal,
                style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.caloriesDesc,
            style: const TextStyle(fontSize: 13, color: AppColors.textTertiary, height: 1.5),
          ),
        ],
      ),
    );
  }
}
