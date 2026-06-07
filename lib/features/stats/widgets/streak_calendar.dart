import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:razor_mind/core/constants/app_colors.dart';

class StreakCalendar extends StatelessWidget {
  const StreakCalendar({
    super.key,
    required this.activityDates,
  });

  final List<DateTime> activityDates;

  static const int _totalDays = 30;
  static const int _columns = 6;

  bool _isActive(DateTime day) {
    return activityDates.any(
      (d) => d.year == day.year && d.month == day.month && d.day == day.day,
    );
  }

  bool _isToday(DateTime day) {
    final now = DateTime.now();
    return now.year == day.year && now.month == day.month && now.day == day.day;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = List.generate(
      _totalDays,
      (i) => DateTime(
        today.year,
        today.month,
        today.day - (_totalDays - 1 - i),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _columns,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1,
          ),
          itemCount: _totalDays,
          itemBuilder: (context, index) {
            final day = days[index];
            final active = _isActive(day);
            final isToday = _isToday(day);
            return _DayDot(active: active, isToday: isToday, index: index);
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _LegendDot(filled: true),
            const SizedBox(width: 6),
            const Text('Activo', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            const SizedBox(width: 16),
            _LegendDot(filled: false),
            const SizedBox(width: 6),
            const Text('Sin actividad', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          ],
        ),
      ],
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.active, required this.isToday, required this.index});

  final bool active;
  final bool isToday;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: isToday
              ? AppColors.primary
              : active
                  ? AppColors.primary
                  : AppColors.textTertiary.withOpacity(0.4),
          width: isToday ? 2 : 1,
        ),
        boxShadow: isToday
            ? [BoxShadow(color: AppColors.primary.withOpacity(0.5), blurRadius: 8, spreadRadius: 1)]
            : active
                ? [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 4)]
                : null,
      ),
      child: isToday
          ? Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scaleXY(begin: 0.7, end: 1.0, duration: 800.ms, curve: Curves.easeInOut),
            )
          : null,
    )
        .animate(delay: Duration(milliseconds: 8 * index))
        .fadeIn(duration: 200.ms)
        .scaleXY(begin: 0.6, duration: 200.ms, curve: Curves.easeOut);
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.filled});
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: filled ? AppColors.primary : AppColors.textTertiary,
          width: 1.5,
        ),
      ),
    );
  }
}
