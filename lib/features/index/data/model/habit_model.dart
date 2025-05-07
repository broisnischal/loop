// import 'package:flutter/material.dart';
// import 'package:loop/core/themes/theme.dart';
// import 'package:uuid/uuid.dart';

// /// Enhanced recurrence pattern types for habits
// enum RecurrencePattern {
//   daily, // Every day
//   weekdays, // Monday through Friday
//   weekends, // Saturday and Sunday
//   weekly, // Same day every week
//   monthly, // Same date every month
//   custom // Custom selection of days
// }

// /// Model representing a habit to track
// class HabitModel {
//   HabitModel({
//     required this.title,
//     String? id,
//     this.description = '',
//     this.category = 'other',
//     Color? categoryColor,
//     this.time,
//     this.recurrence = RecurrencePattern.custom,
//     List<bool>? daysOfWeek,
//     this.hasTimer = false,
//     this.timerDuration = 0,
//     Map<String, bool>? completionStatus,
//     this.currentStreak = 0,
//     this.longestStreak = 0,
//     this.lastCompletedDate,
//   })  : id = id ?? const Uuid().v4(),
//         categoryColor = categoryColor ??
//             AppTheme.categoryColors[category] ??
//             AppTheme.categoryColors['other']!,
//         daysOfWeek = daysOfWeek ?? _getDefaultDaysOfWeek(recurrence),
//         completionStatus = completionStatus ?? {};

//   // Create from JSON
//   factory HabitModel.fromJson(Map<String, dynamic> json) {
//     // Handle timeOfDay which needs special conversion
//     TimeOfDay? timeOfDay;
//     if (json['timeHour'] != null && json['timeMinute'] != null) {
//       timeOfDay = TimeOfDay(hour: json['timeHour'], minute: json['timeMinute']);
//     }

//     // Convert completion status from dynamic to the right type
//     final Map<String, dynamic> rawCompletionStatus =
//         json['completionStatus'] ?? {};
//     final completionStatus = <String, bool>{};

//     rawCompletionStatus.forEach((key, value) {
//       completionStatus[key] = value as bool;
//     });

//     // Convert lastCompletedDate
//     DateTime? lastCompletedDate;
//     if (json['lastCompletedDate'] != null) {
//       try {
//         lastCompletedDate = DateTime.parse(json['lastCompletedDate']);
//       } catch (e) {
//         // If date parsing fails, leave as null
//       }
//     }

//     return HabitModel(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'] ?? '',
//       category: json['category'] ?? 'other',
//       categoryColor: Color(
//         json['categoryColorValue'] ?? AppTheme.categoryColors['other']!.value,
//       ),
//       time: timeOfDay,
//       recurrence: RecurrencePattern
//           .values[json['recurrence'] ?? RecurrencePattern.custom.index],
//       daysOfWeek: (json['daysOfWeek'] as List<dynamic>).cast<bool>(),
//       hasTimer: json['hasTimer'] ?? false,
//       timerDuration: json['timerDuration'] ?? 0,
//       completionStatus: completionStatus,
//       currentStreak: json['currentStreak'] ?? 0,
//       longestStreak: json['longestStreak'] ?? 0,
//       lastCompletedDate: lastCompletedDate,
//     );
//   }
//   final String id;
//   String title;
//   String description;
//   String category;
//   Color categoryColor;
//   TimeOfDay? time;
//   RecurrencePattern recurrence;
//   List<bool> daysOfWeek; // [Mon, Tue, Wed, Thu, Fri, Sat, Sun]
//   bool hasTimer;
//   int timerDuration; // in minutes
//   Map<String, bool> completionStatus; // Map of dates to completion status

//   // Streak tracking
//   int currentStreak;
//   int longestStreak;
//   DateTime? lastCompletedDate;

//   // Set days of week based on recurrence pattern
//   static List<bool> _getDefaultDaysOfWeek(RecurrencePattern recurrence) {
//     switch (recurrence) {
//       case RecurrencePattern.daily:
//         return List.filled(7, true);
//       case RecurrencePattern.weekdays:
//         return [true, true, true, true, true, false, false]; // Mon-Fri
//       case RecurrencePattern.weekends:
//         return [false, false, false, false, false, true, true]; // Sat-Sun
//       case RecurrencePattern.weekly:
//         final today = DateTime.now().weekday - 1;
//         final result = List.filled(7, false);
//         result[today] = true;
//         return result;
//       case RecurrencePattern.monthly:
//         return List.filled(7, false); // Not day-based, handled separately
//       case RecurrencePattern.custom:
//         return List.filled(7, false);
//     }
//   }

//   // Check if habit is scheduled for a specific day (0 = Monday, 6 = Sunday)
//   bool isScheduledForDay(int day) {
//     if (recurrence == RecurrencePattern.monthly) {
//       // For monthly habits, check if today's date matches the creation date
//       final today = DateTime.now();
//       final creationDate = lastCompletedDate ?? DateTime.now();
//       return today.day == creationDate.day;
//     }
//     return daysOfWeek[day];
//   }

//   // Check if the habit is scheduled for a specific date
//   bool isScheduledForDate(DateTime date) {
//     if (recurrence == RecurrencePattern.monthly) {
//       // For monthly recurrence, check if the day of month matches
//       final creationDate = lastCompletedDate ?? DateTime.now();
//       return date.day == creationDate.day;
//     } else {
//       // For other recurrences, check the day of week
//       final dayIndex = (date.weekday - 1) % 7; // 0 = Monday, 6 = Sunday
//       return daysOfWeek[dayIndex];
//     }
//   }

//   // Check if habit is completed for a specific date
//   bool isCompletedForDate(DateTime date) {
//     final dateKey = _formatDateKey(date);
//     return completionStatus[dateKey] ?? false;
//   }

//   // Mark habit as complete for a specific date and update streaks
//   void markCompleted(DateTime date, bool completed) {
//     final dateKey = _formatDateKey(date);
//     final wasCompletedBefore = completionStatus[dateKey] ?? false;

//     // Update completion status
//     completionStatus[dateKey] = completed;

//     // Only update streaks when changing status
//     if (completed != wasCompletedBefore) {
//       if (completed) {
//         // Mark as completed
//         _updateStreakForCompletion(date);
//         lastCompletedDate = date;
//       } else {
//         // Mark as not completed, recalculate current streak
//         _recalculateCurrentStreak();
//       }
//     }
//   }

//   // Update streak when marking a habit as completed
//   void _updateStreakForCompletion(DateTime completedDate) {
//     // Don't update streaks for future dates
//     if (completedDate.isAfter(DateTime.now())) {
//       return;
//     }

//     // If this is today or yesterday, we can possibly extend the streak
//     final today =
//         DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
//     final yesterday = today.subtract(const Duration(days: 1));
//     final completedDay =
//         DateTime(completedDate.year, completedDate.month, completedDate.day);

//     // Check if the habit was due yesterday (or earlier days) and is now completed
//     if (completedDay.isAtSameMomentAs(today) ||
//         completedDay.isAtSameMomentAs(yesterday)) {
//       // Check if the streak was continuous
//       if (lastCompletedDate != null) {
//         final lastCompleted = DateTime(
//           lastCompletedDate!.year,
//           lastCompletedDate!.month,
//           lastCompletedDate!.day,
//         );

//         // If the last completed date was yesterday or today, increment streak
//         if (lastCompleted.isAtSameMomentAs(yesterday) ||
//             lastCompleted.isAtSameMomentAs(today)) {
//           currentStreak++;
//         } else {
//           // Streak broken, restart
//           currentStreak = 1;
//         }
//       } else {
//         // First completion
//         currentStreak = 1;
//       }
//     } else {
//       // Completed an older date, keep streak as is
//     }

//     // Update longest streak if current streak is longer
//     if (currentStreak > longestStreak) {
//       longestStreak = currentStreak;
//     }
//   }

//   // Recalculate current streak after unmarking a completion
//   void _recalculateCurrentStreak() {
//     // Reset to 0 and scan recent dates to find continuous completions
//     currentStreak = 0;

//     // Start from today and go backward
//     final today = DateTime.now();
//     var checkDate = today;

//     while (true) {
//       // Check if the habit was scheduled and completed for this date
//       final dateKey = _formatDateKey(checkDate);
//       final isCompleted = completionStatus[dateKey] ?? false;
//       final dayIndex = (checkDate.weekday - 1) % 7;
//       final wasScheduled = isScheduledForDate(checkDate);

//       if (wasScheduled) {
//         if (isCompleted) {
//           // Increment streak and continue checking earlier dates
//           currentStreak++;
//           lastCompletedDate = checkDate;
//         } else {
//           // Streak broken
//           break;
//         }
//       }

//       // Move to previous day
//       checkDate = checkDate.subtract(const Duration(days: 1));

//       // Stop if we've gone too far back (30 days max)
//       if (today.difference(checkDate).inDays > 30) {
//         break;
//       }
//     }
//   }

//   // Format date as a string key for the completion map
//   String _formatDateKey(DateTime date) {
//     return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
//   }

//   // Get recurrence name for display
//   String getRecurrenceName() {
//     switch (recurrence) {
//       case RecurrencePattern.daily:
//         return 'Every day';
//       case RecurrencePattern.weekdays:
//         return 'Weekdays';
//       case RecurrencePattern.weekends:
//         return 'Weekends';
//       case RecurrencePattern.weekly:
//         return 'Weekly';
//       case RecurrencePattern.monthly:
//         return 'Monthly';
//       case RecurrencePattern.custom:
//         return 'Custom';
//     }
//   }

//   // Calculate completion rate for a given time range
//   double getCompletionRate({DateTime? startDate, DateTime? endDate}) {
//     startDate ??= DateTime.now().subtract(const Duration(days: 30));
//     endDate ??= DateTime.now();

//     var totalDays = 0;
//     var completedDays = 0;

//     // Iterate through each date in the range
//     for (var date = startDate;
//         date.isBefore(endDate.add(const Duration(days: 1)));
//         date = date.add(const Duration(days: 1))) {
//       // Only count days where the habit was scheduled
//       if (isScheduledForDate(date)) {
//         totalDays++;
//         if (isCompletedForDate(date)) {
//           completedDays++;
//         }
//       }
//     }

//     return totalDays > 0 ? completedDays / totalDays : 0.0;
//   }

//   // Convert to JSON for storage
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'category': category,
//       'categoryColorValue': categoryColor.value,
//       'timeHour': time?.hour,
//       'timeMinute': time?.minute,
//       'recurrence': recurrence.index,
//       'daysOfWeek': daysOfWeek,
//       'hasTimer': hasTimer,
//       'timerDuration': timerDuration,
//       'completionStatus': completionStatus,
//       'currentStreak': currentStreak,
//       'longestStreak': longestStreak,
//       'lastCompletedDate': lastCompletedDate?.toIso8601String(),
//     };
//   }

//   // Create a copy of the habit with optional updated values
//   HabitModel copyWith({
//     String? title,
//     String? description,
//     String? category,
//     Color? categoryColor,
//     TimeOfDay? time,
//     RecurrencePattern? recurrence,
//     List<bool>? daysOfWeek,
//     bool? hasTimer,
//     int? timerDuration,
//     Map<String, bool>? completionStatus,
//     int? currentStreak,
//     int? longestStreak,
//     DateTime? lastCompletedDate,
//   }) {
//     return HabitModel(
//       id: id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       category: category ?? this.category,
//       categoryColor: categoryColor ?? this.categoryColor,
//       time: time ?? this.time,
//       recurrence: recurrence ?? this.recurrence,
//       daysOfWeek: daysOfWeek ?? List.from(this.daysOfWeek),
//       hasTimer: hasTimer ?? this.hasTimer,
//       timerDuration: timerDuration ?? this.timerDuration,
//       completionStatus: completionStatus ?? Map.from(this.completionStatus),
//       currentStreak: currentStreak ?? this.currentStreak,
//       longestStreak: longestStreak ?? this.longestStreak,
//       lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
//     );
//   }
// }
