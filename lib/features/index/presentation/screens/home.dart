import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/constants/colors.dart';
import 'package:loop/core/sys/theme_notifier.dart';
import 'package:loop/core/themes/theme.dart';
import 'package:loop/di/injection_config.dart';
import 'package:loop/features/index/presentation/widgets/bottom_dialog.dart';
import 'package:loop/plugins/calendar_slider.dart';
import 'package:loop/plugins/snackbar.dart';
import 'package:loop/plugins/swipable.dart';
import 'package:loop/router/router.dart';
import 'package:loop/router/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Plan Entity class
class PlanEntity {
  PlanEntity({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.tag,
    required this.status,
    required this.toRemind,
  });
  final String id;
  final DateTime date;
  final String title;
  final String description;
  final String tag;
  final TaskStatus status;
  final bool toRemind;

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
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<PlanEntity> _plans;
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

  final ScrollController _scrollController = ScrollController();
  bool _showHeader = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    _scrollController.addListener(_handleScroll);

    _plans = _generateSamplePlans();
  }

  void _handleScroll() {
    final currentOffset = _scrollController.offset;
    const double scrollThreshold = 100; // Adjust this value as needed

    if (currentOffset > _lastScrollOffset && _showHeader) {
      // Scrolling down
      if (currentOffset > scrollThreshold) {
        setState(() => _showHeader = false);
      }
    } else if (currentOffset < _lastScrollOffset && !_showHeader) {
      // Scrolling up
      setState(() => _showHeader = true);
    }

    _lastScrollOffset = currentOffset;
  }

  List<PlanEntity> _generateSamplePlans() {
    final tags = <String>[
      'Work',
      'Personal',
      'Health',
      'Finance',
      'Learning',
    ];
    final titles = <String>[
      'Complete Project Proposal',
      'Gym Session',
      'Read Flutter Documentation',
      'Meet with Team',
      'Doctor Appointment',
      'Pay Bills',
      'Learn Dart',
      'Family Dinner',
    ];

    final descriptions = <String>[
      'Finish the project proposal for the client meeting',
      'Focus on cardio and upper body',
      'Go through the latest Flutter updates',
      'Weekly sync-up with the development team',
      'Annual health checkup',
      'Pay electricity and internet bills',
      'Complete chapter 5 of Dart programming',
      'Dinner with family at favorite restaurant',
    ];

    final plans = <PlanEntity>[];
    final random = math.Random();

    // Generate random plans for the next 10 days
    for (var i = 0; i < 20; i++) {
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
      if (direction == SwipeDirection.right && _plans[index].status == TaskStatus.pending) {
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshPlans() async {
    setState(() {
      _plans = _generateSamplePlans();
    });

    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    // Filter to show only pending plans
    final pendingPlans = _plans.where((plan) => plan.status == TaskStatus.pending).toList();

    final router = getIt<AppRouter>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        notificationPredicate: (_) => false,
        title: const Text(
          '  Loop',
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options (in a real app)
            },
          ),
          // PopupMenuButton<AppThemeType>(
          //   icon: const Icon(Icons.color_lens_outlined),
          //   onSelected: (type) {
          //     context.read<ThemeCubit>().changeTheme(type);
          //   },
          //   itemBuilder: (_) => AppThemeType.values
          //       .map(
          //         (type) => PopupMenuItem(
          //           value: type,
          //           child: Text(type.name),
          //         ),
          //       )
          //       .toList(),
          // ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                router.push(const AddHabitRoute());
                // Scaffold.of(context).showBottomSheet(
                //   (context) => openTaskBottomSheet(context),
                // );
                // AddTaskBottomSheet(context);
              },
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            toolbarHeight: 0,
            bottom: TabBar(
              enableFeedback: true,
              automaticIndicatorColorAdjustment: false,
              indicatorColor: Theme.of(context).colorScheme.secondary,
              dividerHeight: 0,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 3,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              tabs: const [
                Tab(
                  text: 'Active',
                ),
                Tab(
                  text: 'Completed',
                ),
                Tab(
                  text: 'All Task',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
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
                  // const LinearCalendarSlider(),

                  Builder(
                    builder: (context) {
                      return Expanded(
                        child: pendingPlans.isEmpty
                            ? _buildEmptyState()
                            : RefreshIndicator(
                                onRefresh: _refreshPlans,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: pendingPlans.length,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  itemBuilder: (context, index) {
                                    final plan = pendingPlans[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(),
                                      child: SwipeableItem(
                                        key: ValueKey(plan.id),
                                        leftSwipeColor: Colors.red.shade900,
                                        rightSwipeColor: Colors.green.shade700,
                                        onSwipe: (direction) => _handlePlanSwipe(index, direction),
                                        onRemoved: () => _removePlan(index),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 10,
                                            top: 10,
                                            left: 16,
                                            right: 16,
                                          ),
                                          // padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          child: _buildPlanCard(plan),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
              ListView.builder(
                itemCount: _plans.length - pendingPlans.length,
                itemBuilder: (context, index) => _buildPlanCard(
                  _plans[index + pendingPlans.length],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('all tasks'),
                ],
              ),
            ],
          ),
        ),
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
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    ),
                  ),
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
                    padding: const EdgeInsets.only(left: 8),
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
              ),
            ),
            const SizedBox(height: 8),
            Text(
              plan.description,
              style: const TextStyle(
                fontSize: 14,
                // color: Colors.grey[400],
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
              backgroundColor: ColorConst.lightBlack,
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
