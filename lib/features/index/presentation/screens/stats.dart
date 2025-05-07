import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loop/core/themes/theme.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

@RoutePage(name: 'StatsRoute')
class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  List<Widget> generateItems() {
    return List.generate(10, box); // List of 10 items
  }

  @override
  Widget build(BuildContext context) {
    final items = generateItems(); // Generate the list here

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stastistics'),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return PlayAnimationBuilder(
                tween: 0.0.tweenTo(1),
                duration: 300.milliseconds,
                delay: Duration(milliseconds: index * 100), // Stagger the animation for each item
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(100 * (1 - value), 0), // Slide in from right
                      child: child,
                    ),
                  );
                },
                child: items[index], // The box widget
              );
            },
          ),
        ],
      ),
    );
  }

  Widget box(int index) {
    return PlayAnimationBuilder(
      tween: 0.0.tweenTo(1),
      duration: 600.milliseconds,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(200 * (1 - value), 0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.3,
                children: [
                  SlidableAction(
                    onPressed: (_) => {},
                    icon: Icons.edit_outlined,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (_) => {},
                    icon: Icons.delete_outline_rounded,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "This is the super awesome",
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
