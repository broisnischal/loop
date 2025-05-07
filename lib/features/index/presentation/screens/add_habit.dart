import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loop/core/constants/colors.dart';

@RoutePage(name: 'AddHabitRoute')
class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your Habit'),
      ),
      body: const Column(
        children: [
          Text("Title"),
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
