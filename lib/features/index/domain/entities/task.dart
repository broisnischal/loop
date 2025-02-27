import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.userId,
    required this.emoji,
    required this.title,
    required this.description,
    required this.status,
    required this.taskType,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.repeatType,
    required this.remind,
    required this.alarm,
    required this.muted,
    required this.snoozeDuration,
    required this.color,
    required this.previousVersionId,
    required this.versionNumber,
    required this.currentVersionId,
    required this.currentVersion,
  });

  final String id;
  final String userId;
  final String? emoji;
  final String? title;
  final String? description;
  final String status;
  final String? taskType;
  final String? startTime;
  final String? endTime;
  final String? date;
  final String repeatType;
  final bool remind;
  final bool alarm;
  final bool muted;
  final int? snoozeDuration;
  final String? color;
  final String? previousVersionId;
  final int? versionNumber;
  final String? currentVersionId;
  final CurrentVersion? currentVersion;

  @override
  List<Object?> get props => [
        id,
        userId,
        emoji,
        title,
        description,
        status,
        taskType,
        startTime,
        endTime,
        date,
        repeatType,
        remind,
        alarm,
        muted,
        snoozeDuration,
        color,
        previousVersionId,
        versionNumber,
        currentVersionId,
        currentVersion,
      ];
}

class CurrentVersion extends Equatable {
  const CurrentVersion({
    required this.id,
    required this.taskId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.isCurrent,
    required this.validFrom,
    required this.validTo,
  });

  final String id;
  final String? taskId;
  final String? title;
  final String? startTime;
  final dynamic? endTime;
  final String color;
  final bool isCurrent;
  final DateTime? validFrom;
  final dynamic validTo;

  @override
  List<Object?> get props => [
        id,
        taskId,
        title,
        startTime,
        endTime,
        color,
        isCurrent,
        validFrom,
        validTo,
      ];
}
