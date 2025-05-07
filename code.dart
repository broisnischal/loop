import 'package:flutter/material.dart';
import 'package:dreamflow/models/habit_model.dart';
import 'package:dreamflow/services/habit_service.dart';
import 'package:dreamflow/theme.dart';
import 'package:dreamflow/widgets/timer_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:dreamflow/screens/stats_screen.dart';

class HabitTile extends StatelessWidget {
  final HabitModel habit;
  final DateTime date;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showTime;
  final bool showTimer;

  const HabitTile({
    Key? key,
    required this.habit,
    required this.date,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.showTime = true,
    this.showTimer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCompleted = habit.isCompletedForDate(date);
    final theme = Theme.of(context);

    return PlayAnimationBuilder<double>(
      tween: (0.0).tweenTo(1.0),
      duration: 600.milliseconds,
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.3,
                children: [
                  if (onEdit != null)
                    SlidableAction(
                      onPressed: (_) => onEdit?.call(),
                      backgroundColor: theme.colorScheme.surfaceVariant,
                      foregroundColor: theme.colorScheme.primary,
                      icon: Icons.edit_outlined,
                      label: 'Edit',
                    ),
                  if (onDelete != null)
                    SlidableAction(
                      onPressed: (_) => onDelete?.call(),
                      backgroundColor: theme.colorScheme.error.withOpacity(0.1),
                      foregroundColor: theme.colorScheme.error,
                      icon: Icons.delete_outline_rounded,
                      label: 'Delete',
                    ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? theme.colorScheme.primary.withOpacity(0.08)
                      : theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isCompleted
                        ? theme.colorScheme.primary.withOpacity(0.5)
                        : theme.colorScheme.outline.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                      child: Column(
                        children: [
                          // Main habit content
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // Category indicator
                                Container(
                                  width: 4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: habit.categoryColor,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // Checkbox
                                _buildCheckbox(context, isCompleted),

                                const SizedBox(width: 16),

                                // Habit Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          // Category chip for small screens
                                          if (MediaQuery.of(context).size.width < 400) ...[
                                            _buildCategoryChip(theme),
                                            const SizedBox(width: 8),
                                          ],

                                          Expanded(
                                            child: Text(
                                              habit.title,
                                              style: theme.textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    isCompleted ? TextDecoration.lineThrough : null,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),

                                      if (habit.description.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          habit.description,
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],

                                      if (showTime && habit.time != null) ...[
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.access_time_rounded,
                                              size: 16,
                                              color: theme.colorScheme.primary,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${habit.time!.hour.toString().padLeft(2, '0')}:${habit.time!.minute.toString().padLeft(2, '0')}',
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),

                                            // Recurrence pattern
                                            const SizedBox(width: 12),
                                            Icon(
                                              Icons.repeat_rounded,
                                              size: 16,
                                              color: theme.colorScheme.tertiary,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              habit.getRecurrenceName(),
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: theme.colorScheme.tertiary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],

                                      // Streak indicator if impressive
                                      if (habit.currentStreak >= 3) ...[
                                        const SizedBox(height: 8),
                                        _buildStreakBadge(theme),
                                      ],
                                    ],
                                  ),
                                ),

                                // Category indicator for larger screens
                                if (MediaQuery.of(context).size.width >= 400) ...[
                                  _buildCategoryChip(theme),
                                  const SizedBox(width: 8),
                                ],

                                // Stats button
                                IconButton(
                                  iconSize: 18,
                                  onPressed: () => _showStats(context),
                                  icon: Icon(
                                    Icons.bar_chart_rounded,
                                    color: theme.colorScheme.primary,
                                  ),
                                  tooltip: 'View Stats',
                                ),
                              ],
                            ),
                          ),

                          // Timer widget if enabled
                          if (showTimer && habit.hasTimer) ...[
                            const Divider(height: 1, thickness: 1),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: TimerWidget(
                                duration: habit.timerDuration,
                                minimal: true,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckbox(BuildContext context, bool isCompleted) {
    final theme = Theme.of(context);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: isCompleted ? 1 : 0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final checkValue = Curves.easeOutCubic.transform(value);

        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Color.lerp(
                theme.colorScheme.background,
                theme.colorScheme.primary,
                value,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary,
                width: 2 - value,
              ),
            ),
            child: Center(
              child: Transform.scale(
                scale: checkValue,
                child: Icon(
                  Icons.check_rounded,
                  size: 18,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryChip(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: habit.categoryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _formatCategoryName(),
        style: theme.textTheme.bodySmall?.copyWith(
          color: habit.categoryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStreakBadge(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            size: 14,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 4),
          Text(
            '${habit.currentStreak} day streak',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCategoryName() {
    if (habit.category.isEmpty) return 'Other';
    return habit.category.substring(0, 1).toUpperCase() +
        (habit.category.length > 4 ? habit.category.substring(1, 4) : habit.category.substring(1));
  }

  void _showStats(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatsScreen(habitId: habit.id),
      ),
    );
  }

  static Future<void> toggleCompletion(
      BuildContext context, HabitModel habit, DateTime date) async {
    final isCurrentlyCompleted = habit.isCompletedForDate(date);
    await HabitService.toggleHabitCompletion(habit.id, date, !isCurrentlyCompleted);

    if (context.mounted) {
      final theme = Theme.of(context);
      final snackText = !isCurrentlyCompleted
          ? 'Marked "${habit.title}" as completed! 🎉'
          : 'Marked "${habit.title}" as incomplete';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackText),
          behavior: SnackBarBehavior.floating,
          backgroundColor: !isCurrentlyCompleted ? theme.colorScheme.primary : null,
          duration: const Duration(seconds: 2),
          action: !isCurrentlyCompleted && habit.currentStreak >= 3
              ? SnackBarAction(
                  label: 'View Streak',
                  textColor: theme.colorScheme.onPrimary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatsScreen(habitId: habit.id),
                      ),
                    );
                  },
                )
              : null,
        ),
      );
    }
  }
}
