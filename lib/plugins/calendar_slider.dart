import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';

class LinearCalendarSlider extends StatefulWidget {
  const LinearCalendarSlider({super.key});

  @override
  _LinearCalendarSliderState createState() => _LinearCalendarSliderState();
}

class _LinearCalendarSliderState extends State<LinearCalendarSlider> {
  final ScrollController _scrollController = ScrollController();
  DateTime _selectedDate = DateTime.now();
  final double _dateItemWidth = 76;
  final List<DateTime> _dates = [];
  double _lastOffset = 0;
  DateTime? _lastHapticTime;

  @override
  void initState() {
    super.initState();
    _generateDates();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToInitialPosition());
  }

  void _generateDates() {
    final today = DateTime.now();
    _dates.addAll(
      List.generate(
        61,
        (i) => today.subtract(Duration(days: 60 - i)),
      ),
    ); // Past 60 days + today
    _dates.addAll(
      List.generate(
        60,
        (i) => today.add(Duration(days: i + 1)),
      ),
    ); // Next 60 days
  }

  void _scrollToInitialPosition() {
    final initialOffset = (_dates.length ~/ 2 - 2) * _dateItemWidth;
    _scrollController.jumpTo(initialOffset);
  }

  void _handleScroll() {
    final currentOffset = _scrollController.offset;
    if ((currentOffset - _lastOffset).abs() > _dateItemWidth / 2) {
      final now = DateTime.now();
      if (_lastHapticTime == null ||
          now.difference(_lastHapticTime!).inMilliseconds > 50) {
        HapticFeedback.lightImpact();
        _lastHapticTime = now;
      }
    }
    _lastOffset = currentOffset;
  }

  void _onScrollEnd() {
    // final index = (_scrollController.offset / _dateItemWidth).round();
    // setState(() => _selectedDate = _dates[index]);
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
      //   borderRadius: BorderRadius.circular(16),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.05),
      //       blurRadius: 8,
      //       offset: Offset(0, 4),
      //     ),
      //   ],
      // ),
      // margin: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                10.horizontalSpace,
                Text(
                  DateFormat('MMMM yyyy').format(_selectedDate),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                  ),
                ),
                const Spacer(),
                // SlideCountdown(
                //   decoration: BoxDecoration(
                //     color: Colors.transparent,
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   duration: const Duration(minutes: 60),
                //   style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     color: Colors.grey[400],
                //   ),
                // ),
                IconButton(
                  onPressed: () {
                    setState(_scrollToInitialPosition);
                  },
                  icon: const Icon(Icons.refresh),
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
          Container(
            height: 70.h,
            decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  _handleScroll();
                } else if (notification is ScrollEndNotification) {
                  _onScrollEnd();
                }
                return true;
              },
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: _dates.length,
                itemBuilder: (context, index) {
                  final date = _dates[index];

                  // final isFuture = date.difference(DateTime.now()).inDays > 0;
                  // final isPast = date.difference(DateTime.now()).inDays < 0;

                  final isToday = date.day == DateTime.now().day &&
                      date.month == DateTime.now().month &&
                      date.year == DateTime.now().year;
                  final isSelected = date.day == _selectedDate.day &&
                      date.month == _selectedDate.month &&
                      date.year == _selectedDate.year;

                  return _DateItem(
                    date: date,
                    isSelected: isSelected,
                    isToday: isToday,
                    width: _dateItemWidth,
                    onTap: () {
                      setState(() => _selectedDate = date);
                      HapticFeedback.mediumImpact();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _DateItem extends StatelessWidget {
  const _DateItem({
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.width,
    required this.onTap,
  });
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(color: Colors.blueAccent, width: 1.5),
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('E').format(date).toUpperCase(),
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.blueAccent : Colors.grey[600],
                letterSpacing: -0.2,
              ),
            ),
            4.verticalSpace,
            Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: isToday && !isSelected
                    ? Colors.blueAccent.withOpacity(0.1)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: isToday
                    ? Border.all(color: Colors.blueAccent.withOpacity(0.4))
                    : null,
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.blueAccent
                        : isToday
                            ? Colors.blueAccent
                            : Colors.grey[800],
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
