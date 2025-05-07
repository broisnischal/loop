import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loop/core/constants/colors.dart';
import 'package:loop/features/index/presentation/widgets/dialog.dart';
import 'package:loop/features/index/presentation/widgets/single_emoji_picker.dart';
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
  final tags = <String>[
    "Work",
    "Drining",
    "Eating",
    "Sleeping",
    "Learning",
    "Fitness",
    "Reading",
    "Writing",
    "Coding",
    "Gaming",
    "Music",
    "Movies",
    "Travel",
  ];

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Widget buildColorPalette() {
    const selectedColor = ColorConst.nordicGrey;
    final colors = <Color>[
      ColorConst.nordicGrey,
      ColorConst.coolAmber,
      ColorConst.magicBlue,
      ColorConst.mercuryWhite,
      ColorConst.lightBlack,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.lime,
      Colors.cyan,
    ];

    return SizedBox(
      height: 30.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return Container(
            width: 30.r,
            margin: EdgeInsets.only(left: index == 0 ? 12.w : 0, right: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: index == 0
                    ? selectedColor
                    : ColorConst.whiteColor.withAlpha(40),
                strokeAlign: BorderSide.strokeAlignCenter,
                width: 1.5,
              ),
              color: colors[index].withAlpha(150),
            ),
          );
        },
      ),
    );
  }

  Widget repeatSelector() {
    final repeat = <String>['daily', 'weekly', 'once'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SymmetricHPadding(
          child: const Text(
            'Repeat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        5.verticalSpace,
        SizedBox(
          height: 28.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: repeat.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 12.w, right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: ColorConst.lightBlack,
                  border: Border.all(
                    color: ColorConst.whiteColor.withAlpha(20),
                    strokeAlign: BorderSide.strokeAlignCenter,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  repeat[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildTags() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SymmetricHPadding(
          child: const Text(
            'Select Tags',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        5.verticalSpace,
        SizedBox(
          height: 30.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tags.length + 1,
            itemBuilder: (context, index) {
              return index == 0
                  ? Container(
                      margin: EdgeInsets.only(left: 12.w, right: 8.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: ColorConst.lightBlack,
                        border: Border.all(
                          color: ColorConst.whiteColor.withAlpha(20),
                          strokeAlign: BorderSide.strokeAlignCenter,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 12.sp,
                          ),
                          5.horizontalSpace,
                          const Text(
                            'Add Tag',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 12.w : 0,
                        right: 8.w,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: ColorConst.lightBlack,
                        border: Border.all(
                          color: ColorConst.whiteColor.withAlpha(20),
                          strokeAlign: BorderSide.strokeAlignCenter,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        tags[index - 1],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }

  void toggleSetting(int index) {
    log(index.toString());
  }

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
        height: constraints.maxHeight - 100.h,
        // constraints: BoxConstraints(maxHeight: 600.h),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              top: 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,

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
                20.verticalSpace,
                SymmetricHPadding(
                  child: EmojiPickerButton(
                    onEmojiSelected: (emoji) {
                      print('Selected emoji: $emoji');
                    },
                    initialEmoji: '🚀', // Optional initial emoji
                    backgroundColor: ColorConst.lightBlack,
                    size: 48.sp, // Optional custom size
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
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SymmetricHPadding(
                  horizontalPadding: 16.w,
                  child: TextFormField(
                    maxLines: 8,
                    style: const TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      // fontSize: 18.sp,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      // border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                        color: Colors.white38,
                        // fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none, // no border
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // decoration: InputDecoration(
                //   hintText: 'Description',
                //   // border: OutlineInputBorder(),
                //   hintStyle: TextStyle(
                //     color: Colors.white38,
                //   ),
                //   border: InputBorder.none, // no border
                // ),
                10.verticalSpace,
                const SettingsChipsRow(),
                20.verticalSpace,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        startTime = await CustomTimePicker.show(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (startTime != null) {
                          // Do something with startTime and endTime
                        }

                        log('startTime: $startTime, endTime: $endTime');
                      },
                      child: Column(
                        children: [
                          SymmetricHPadding(
                            horizontalPadding: 16.w,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.white60,
                                ),
                                5.horizontalSpace,
                                const Text(
                                  'Start Time',
                                  style: TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        endTime = await CustomTimePicker.show(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (endTime != null) {
                          // Do something with startTime and endTime
                        }

                        log('startTime: $startTime, endTime: $endTime');
                      },
                      child: Column(
                        children: [
                          SymmetricHPadding(
                            horizontalPadding: 16.w,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.white60,
                                ),
                                5.horizontalSpace,
                                const Text(
                                  'End Time',
                                  style: TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.horizontalSpace,
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.white60,
                        ),
                        5.horizontalSpace,
                        const Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                20.verticalSpace,
                buildColorPalette(),
                20.verticalSpace, buildTags(),
                20.verticalSpace,
                repeatSelector(),

                // SymmetricHPadding(
                //   horizontalPadding: 16.w,
                //   child: SizedBox(
                //     height: 20.h, // Ensure a fixed height
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       shrinkWrap: true,
                //       itemBuilder: (context, index) => Text(
                //         tags[index],
                //       ),
                //       itemCount: tasks.length,
                //     ),
                //   ),
                // ),
              ],
            ),
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
  double horizontalPadding = 16,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
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
