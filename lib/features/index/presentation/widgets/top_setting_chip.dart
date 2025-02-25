import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loop/features/index/presentation/widgets/settings_chip.dart';

class SettingsChipsRow extends StatefulWidget {
  const SettingsChipsRow({Key? key}) : super(key: key);

  @override
  _SettingsChipsRowState createState() => _SettingsChipsRowState();
}

class _SettingsChipsRowState extends State<SettingsChipsRow> {
  final List<Map<String, dynamic>> settings = [
    {"label": "Remind", "icon": Icons.notifications, "active": false},
    {"label": "Alarm", "icon": Icons.alarm, "active": false},
    {"label": "Snooze", "icon": Icons.snooze, "active": false},
    {"label": "Mute", "icon": Icons.volume_off, "active": false},
    {"label": "Priority", "icon": Icons.priority_high, "active": false},
  ];

  void toggleSetting(int index) {
    setState(() {
      settings[index]["active"] = !settings[index]["active"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: settings.length,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          return SettingChip(
            icon: settings[index]["icon"],
            label: settings[index]["label"],
            isActive: settings[index]["active"],
            onTap: () => toggleSetting(index),
          );
        },
      ),
    );
  }
}
