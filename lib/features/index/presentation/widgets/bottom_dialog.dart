import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loop/core/constants/colors.dart';
import 'package:loop/features/index/presentation/widgets/dialog.dart';
import 'package:loop/features/index/presentation/widgets/time_wheel.dart';
import 'package:loop/features/index/presentation/widgets/top_setting_chip.dart';

Future<bool> _showDiscardConfirmation(BuildContext context) async {
  final discard = await MyDialog(
    child: Container(),
    context: context,
    message: 'Are you sure you want to delete this item?',
    buttonText: 'Delete',
    onConfirm: () {
      Navigator.pop(context, true); // Return true if confirmed
    },
    isDanger: true,
  );
  return discard ?? false;
}

Future<void> AddTaskBottomSheet(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) => PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          // final shouldDiscard = await _showDiscardConfirmation(context);
          if (true) {
            Navigator.pop(context); // Close bottom sheet
          }
        }
      },
      child: openTaskBottomSheet(context),
    ),
    sheetAnimationStyle: AnimationStyle(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 200),
    ),
    isScrollControlled: true,
    routeSettings: const RouteSettings(name: 'AddTaskBottomSheet'),
    scrollControlDisabledMaxHeightRatio: 0.8,
    clipBehavior: Clip.hardEdge,
    barrierColor: ColorConst.blackSmoke.withAlpha(200),
    showDragHandle: false,
    elevation: 0,
    enableDrag: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    backgroundColor: ColorConst.blackSmoke,
  );
}

Widget openTaskBottomSheet(
  BuildContext context,
) {
  return LayoutBuilder(
    // use LayoutBuilder to get the size of the screen
    // builder: (context, constraints) {
    //   return Container(
    //     height: constraints.maxHeight,
    //     decoration: BoxDecoration(
    //       color: ColorConst.blackSmoke,
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(24.r),
    //         topRight: Radius.circular(24.r),
    //       ),
    //     ),
    //   );
    // }
    builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight - 150.h,
        decoration: BoxDecoration(
          color: ColorConst.blackSmoke,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          border: Border.all(
            color: Colors.white12,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            // left: 24.h,
            // right: 24.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SymmetricHPadding(
                horizontalPadding: 16.w,
                child: const Row(
                  children: [
                    Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white12,
                      ),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              SymmetricHPadding(
                horizontalPadding: 16.w,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    // border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                    border: InputBorder.none, // no border
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SymmetricHPadding(
                horizontalPadding: 16.w,
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Description',
                    // border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                      color: Colors.white38,
                    ),
                    border: InputBorder.none, // no border
                  ),
                ),
              ),
              10.verticalSpace,
              const SettingsChipsRow(),
              10.verticalSpace,
              GestureDetector(
                onTap: () async {
                  final selectedTime = await CustomTimePicker.show(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: const Text('Start Time'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

List<String> tasks = [];

void addTask(String task) {
  tasks.add(task);
  print(
    'Task added: $task',
  ); // Replace with state update logic if using Provider/State Management
}

void removeTask(String task) {
  tasks.remove(task);
  print(
    'Task removed: $task',
  ); // Replace with state update logic if using Provider/State Management
}

Widget SymmetricHPadding({
  required Widget child,
  required double horizontalPadding,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: child,
  );
}

Widget SymmetricVPadding({
  required Widget child,
  required double verticalPadding,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: verticalPadding),
    child: child,
  );
}
