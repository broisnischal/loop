import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loop/core/constants/colors.dart';
import 'package:loop/di/injection_config.dart';
import 'package:loop/features/index/presentation/screens/stats.dart';
import 'package:loop/router/router.dart';
import 'package:loop/router/router.gr.dart';

@RoutePage(name: 'AddHabitRoute')
class AddHabit extends StatelessWidget {
  const AddHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
      ),
      body: Column(
        children: [
          Text("Title"),
          IconButton(
              onPressed: () {
                getIt<AppRouter>().push(const StatsRoute());
              },
              icon: const Icon(Icons.add)),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            textAlign: TextAlign.center,
          ),
          Text('Description'),
          Text("category"),
        ],
      ),
    );
  }
}
