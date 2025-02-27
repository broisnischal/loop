import 'package:loop/features/index/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.userId,
    required super.emoji,
    required super.title,
    required super.description,
    required super.status,
    required super.taskType,
    required super.startTime,
    required super.endTime,
    required super.date,
    required super.repeatType,
    required super.remind,
    required super.alarm,
    required super.muted,
    required super.snoozeDuration,
    required super.color,
    required super.previousVersionId,
    required super.versionNumber,
    required super.currentVersionId,
    required super.currentVersion,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? '',
      taskType: json['task_type'] as String? ?? '',
      startTime: json['start_time'] as String? ?? '',
      endTime: json['end_time'] as String? ?? '',
      date: json['date'] as String? ?? '',
      repeatType: json['repeat_type'] as String? ?? '',
      remind: json['remind'] as bool? ?? false,
      alarm: json['alarm'] as bool? ?? false,
      muted: json['muted'] as bool? ?? false,
      snoozeDuration: json['snooze_duration'] as int? ?? 0,
      color: json['color'] as String? ?? '',
      previousVersionId: json['previous_version_id'] as String? ?? '',
      versionNumber: json['version_number'] as int? ?? 0,
      currentVersionId: json['current_version_id'] as String? ?? '',
      currentVersion: json['current_version'] == null
          ? null
          : CurrentVersionModel.fromJson(
              json['current_version'] as Map<String, dynamic>,
            ),
    );
  }
}

class CurrentVersionModel extends CurrentVersion {
  const CurrentVersionModel({
    required super.id,
    required super.taskId,
    required super.title,
    required super.startTime,
    required super.endTime,
    required super.color,
    required super.isCurrent,
    required super.validFrom,
    required super.validTo,
  });

  factory CurrentVersionModel.fromJson(Map<String, dynamic> json) {
    return CurrentVersionModel(
      id: json['id'] as String? ?? '',
      taskId: json['task_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      startTime: json['start_time'] as String? ?? '',
      endTime: json['end_time'] as String? ?? '',
      color: json['color'] as String? ?? '',
      isCurrent: json['is_current'] as bool? ?? false,
      validFrom: json['valid_from'] as DateTime?,
      validTo: json['valid_to'] as String? ?? '',
    );
  }
}
