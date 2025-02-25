import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loop/core/constants/colors.dart';

class SettingChip extends StatelessWidget {
  const SettingChip({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    super.key,
  });
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        HapticFeedback.lightImpact();
      },
      child: AnimatedContainer(
        height: 10.h,
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isActive ? ColorConst.magicBlue : Colors.grey.shade900,
            width: 1.5,
          ),
          color: isActive ? ColorConst.nordicGrey : ColorConst.lightBlack,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12.sp,
              color: isActive ? ColorConst.magicBlue : Colors.grey,
            ),
            5.horizontalSpace,
            Text(
              label,
              style: TextStyle(
                fontSize: 8.sp,
                color: isActive ? ColorConst.magicBlue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
