import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loop/core/constants/colors.dart';

class CustomTimePicker {
  static Future<TimeOfDay?> show({
    required BuildContext context,
    required TimeOfDay initialTime,
    bool is24HourMode = true,
  }) async {
    TimeOfDay? selectedTime;
    final fixedInitialTime = initialTime.replacing(
      hour: is24HourMode ? initialTime.hour : initialTime.hourOfPeriod,
    );

    await showModalBottomSheet(
      context: context,
      // backgroundColor: Colors.black12,
      isScrollControlled: true,
      builder: (context) => _TimePickerContent(
        initialTime: fixedInitialTime,
        is24HourMode: is24HourMode,
        onTimeChanged: (time) => selectedTime = time,
      ),
    );

    return selectedTime;
  }
}

class _TimePickerContent extends StatefulWidget {
  const _TimePickerContent({
    required this.initialTime,
    required this.is24HourMode,
    required this.onTimeChanged,
  });
  final TimeOfDay initialTime;
  final bool is24HourMode;
  final ValueChanged<TimeOfDay> onTimeChanged;

  @override
  State<_TimePickerContent> createState() => __TimePickerContentState();
}

class __TimePickerContentState extends State<_TimePickerContent> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _periodController;
  late TimeOfDay _currentTime;

  DateTime? _lastHapticTime;
  int? _lastHourIndex;
  int? _lastMinuteIndex;

  static const List<String> _periodNames = <String>['AM', 'PM'];

  // static const List<String> _hourNames = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];

  @override
  void initState() {
    super.initState();
    _currentTime = widget.initialTime;
    _hourController = FixedExtentScrollController(
      initialItem: widget.initialTime.hour,
    );
    _minuteController = FixedExtentScrollController(
      initialItem: widget.initialTime.minute,
    );
    _periodController = FixedExtentScrollController(
      initialItem: widget.initialTime.period == DayPeriod.am ? 0 : 1,
    );
  }

  void _handleScroll(FixedExtentScrollController controller) {
    final now = DateTime.now();
    final isHourScroll = controller == _hourController;
    final currentIndex =
        controller.selectedItem; // Now using FixedExtentScrollController

    // Haptic feedback logic
    if ((isHourScroll && _lastHourIndex != currentIndex) ||
        (!isHourScroll && _lastMinuteIndex != currentIndex)) {
      if (_lastHapticTime == null ||
          now.difference(_lastHapticTime!).inMilliseconds > 50) {
        HapticFeedback.lightImpact();
        _lastHapticTime = now;
        if (isHourScroll) {
          _lastHourIndex = currentIndex;
        } else {
          _lastMinuteIndex = currentIndex;
        }
      }
    }

    // Time update logic
    final hour = _hourController.selectedItem;
    final minute = _minuteController.selectedItem;
    final period = widget.is24HourMode
        ? DayPeriod.am
        : (_periodController.selectedItem == 0 ? DayPeriod.am : DayPeriod.pm);

    final newTime = TimeOfDay(
      hour: widget.is24HourMode
          ? hour
          : (period == DayPeriod.am ? hour : hour + 12),
      minute: minute,
    );

    if (newTime != _currentTime) {
      setState(() => _currentTime = newTime);
      widget.onTimeChanged(newTime);
    }
  }

  void _onScrollEnd() {
    HapticFeedback.vibrate();
    final hour = _hourController.selectedItem;
    final minute = _minuteController.selectedItem;
    final period = widget.is24HourMode
        ? DayPeriod.am
        : (_periodController.selectedItem == 0 ? DayPeriod.am : DayPeriod.pm);

    final newTime = TimeOfDay(
      hour: widget.is24HourMode
          ? hour
          : (period == DayPeriod.am ? hour : hour + 12),
      minute: minute,
    );

    setState(() => _currentTime = newTime);
    widget.onTimeChanged(newTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 10) Navigator.pop(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: ColorConst.blackSmoke,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(),
            20.verticalSpace,
            _buildTimeWheels(),
            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 48,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTimeWheels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberWheel(
          controller: _hourController,
          itemCount: widget.is24HourMode ? 24 : 12,
          formatter: (value) => '${value + (widget.is24HourMode ? 0 : 1)}',
        ),
        5.horizontalSpace,
        const Text(
          ':',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        5.horizontalSpace,
        _buildNumberWheel(
          controller: _minuteController,
          itemCount: 60,
          formatter: (value) => value.toString().padLeft(2, '0'),
        ),
        if (!widget.is24HourMode) ...[
          const SizedBox(width: 16),
          _buildPeriodWheel(),
        ],
      ],
    );
  }

  Widget _buildNumberWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int) formatter,
  }) {
    return Container(
      height: 150.h,
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.grey.shade900,
          width: 1.5,
        ),
        color: ColorConst.lightBlack,
      ),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            _handleScroll(controller);
          } else if (notification is ScrollEndNotification) {
            _onScrollEnd();
          }
          return true;
        },
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: 50,
          physics: const FixedExtentScrollPhysics(),
          overAndUnderCenterOpacity: 0.5,
          perspective: 0.01,
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: itemCount,
            builder: (context, index) => Center(
              child: Text(
                formatter(index),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: index == controller.selectedItem
                      ? ColorConst.coolAmber
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodWheel() {
    return Container(
      height: 150,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.withAlpha(30),
      ),
      child: ListWheelScrollView(
        controller: _periodController,
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        children: const [
          Center(child: Text('AM', style: TextStyle(fontSize: 18))),
          Center(child: Text('PM', style: TextStyle(fontSize: 18))),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context, _currentTime);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }
}
