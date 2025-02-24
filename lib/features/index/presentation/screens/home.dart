import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:loop/app/plugins/calendar_slider.dart';
import 'package:loop/app/plugins/snackbar.dart';
import 'dart:math' as math;

// Import the SwipeableItem class we created earlier
// (Assuming it's in a file called swipeable_item.dart)
import 'package:loop/app/plugins/swipable.dart';
import 'package:loop/di/injection_config.dart';
import 'package:loop/router/router.dart';
import 'package:loop/router/router.gr.dart';

// Plan Entity class
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

  // Create a copy of this plan with some fields replaced
  PlanEntity copyWith({
    String? id,
    DateTime? date,
    String? title,
    String? description,
    String? tag,
    TaskStatus? status,
    bool? toRemind,
  }) {
    return PlanEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      tag: tag ?? this.tag,
      status: status ?? this.status,
      toRemind: toRemind ?? this.toRemind,
    );
  }
}

enum TaskStatus { completed, pending, skipped }

@RoutePage(name: 'HomePageRoute')
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<PlanEntity> _plans;
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    _plans = _generateSamplePlans();
  }

  List<PlanEntity> _generateSamplePlans() {
    final List<String> tags = [
      'Work',
      'Personal',
      'Health',
      'Finance',
      'Learning'
    ];
    final List<String> titles = [
      'Complete Project Proposal',
      'Gym Session',
      'Read Flutter Documentation',
      'Meet with Team',
      'Doctor Appointment',
      'Pay Bills',
      'Learn Dart',
      'Family Dinner'
    ];

    final List<String> descriptions = [
      'Finish the project proposal for the client meeting',
      'Focus on cardio and upper body',
      'Go through the latest Flutter updates',
      'Weekly sync-up with the development team',
      'Annual health checkup',
      'Pay electricity and internet bills',
      'Complete chapter 5 of Dart programming',
      'Dinner with family at favorite restaurant'
    ];

    final List<PlanEntity> plans = [];
    final random = math.Random();

    // Generate random plans for the next 10 days
    for (int i = 0; i < 10; i++) {
      final tagIndex = random.nextInt(tags.length);
      final titleIndex = random.nextInt(titles.length);

      plans.add(
        PlanEntity(
          id: 'plan_${i + 1}',
          date: DateTime.now().add(Duration(days: i)),
          title: titles[titleIndex],
          description: descriptions[titleIndex],
          tag: tags[tagIndex],
          status: TaskStatus.pending,
          toRemind: random.nextBool(),
        ),
      );
    }

    return plans;
  }

  void _handlePlanSwipe(int index, SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.right) {
        // Mark as completed when swiped right
        _plans[index] = _plans[index].copyWith(status: TaskStatus.completed);
      } else if (direction == SwipeDirection.left) {
        // Mark as skipped when swiped left
        _plans[index] = _plans[index].copyWith(status: TaskStatus.skipped);
      }
    });
    CustomSnackBar.show(
      context: context,
      title: 'Item deleted',
      icon: Icons.delete_outline,
      actions: [
        TextButton(
          onPressed: () {
            final router = getIt<AppRouter>();

            // Undo logic
            router.push(const HomePageRoute());

            HapticFeedback.lightImpact();
          },
          child: const Text(
            'Undo',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _removePlan(int index) {
    setState(() {
      _plans.removeAt(index);
    });
  }

  Color _getTagColor(String tag) {
    switch (tag) {
      case 'Work':
        return Colors.blue;
      case 'Personal':
        return Colors.purple;
      case 'Health':
        return Colors.green;
      case 'Finance':
        return Colors.amber;
      case 'Learning':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter to show only pending plans
    final pendingPlans =
        _plans.where((plan) => plan.status == TaskStatus.pending).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        notificationPredicate: (_) => false,
        title: const Text(
          '  Loop',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options (in a real app)
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Show completed/skipped plans history (in a real app)
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     'Swipe right to complete, left to skip',
          //     style: TextStyle(
          //       color: Colors.grey[400],
          //       fontSize: 14,
          //     ),
          //   ),
          // ),
          LinearCalendarSlider(),

          Expanded(
            child: pendingPlans.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: pendingPlans.length,
                    // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) {
                      final plan = pendingPlans[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: SwipeableItem(
                          key: ValueKey(plan.id),
                          leftSwipeColor: Colors.red.shade100,
                          rightSwipeColor: Colors.green.shade700,
                          onSwipe: (direction) =>
                              _handlePlanSwipe(index, direction),
                          onRemoved: () => _removePlan(index),
                          removeOnSwipe: true,
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 10, top: 10, left: 16, right: 16),
                            // padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              // color: Colors.white12,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: _buildPlanCard(plan),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add new plan (in a real app, this would open a form)
      //   },
      //   backgroundColor: Theme.of(context).primaryColor,
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _buildPlanCard(PlanEntity plan) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 19, 19, 19),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                      color: _getTagColor(plan.tag).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getTagColor(plan.tag).withAlpha(30),
                        width: 1,
                      )),
                  child: Text(
                    plan.tag,
                    style: TextStyle(
                      color: _getTagColor(plan.tag),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _dateFormat.format(plan.date),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                if (plan.toRemind)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.notifications_active,
                      size: 16,
                      color: Colors.amber[400],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              plan.title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              plan.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 80,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 16),
          Text(
            'All caught up!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You have completed all your plans',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Create a new plan (in a real app)
            },
            icon: const Icon(Icons.add),
            label: const Text('Add New Plan'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
