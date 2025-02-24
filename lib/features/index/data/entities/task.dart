class PlanEntity {
  final String id;
  final DateTime date;
  final String title;
  final String description;
  final String tag;
  final TaskStatus status;
  final bool toRemind;

  PlanEntity({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.tag,
    required this.status,
    required this.toRemind,
  });
}

enum TaskStatus { completed, pending, skipped }
