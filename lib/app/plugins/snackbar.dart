import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> actions;
  final Duration duration;

  const CustomSnackBar({
    super.key,
    required this.title,
    required this.icon,
    this.actions = const [],
    this.duration = const Duration(seconds: 3),
  });

  static void show({
    required BuildContext context,
    required String title,
    required IconData icon,
    List<Widget> actions = const [],
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _CustomSnackBarContent(
        title: title,
        icon: icon,
        actions: actions,
        duration: duration,
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(duration, () => overlayEntry.remove());
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _CustomSnackBarContent extends StatefulWidget {
  final String title; 
  final IconData icon;
  final List<Widget> actions;
  final Duration duration;

  const _CustomSnackBarContent({
    required this.title,
    required this.icon,
    required this.actions,
    required this.duration,
  });

  @override
  State<_CustomSnackBarContent> createState() => __CustomSnackBarContentState();
}

class __CustomSnackBarContentState extends State<_CustomSnackBarContent> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 100, end: 0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, value),
            child: child,
          );
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ...widget.actions,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CustomSnackBar.show(
//   context: context,
//   title: 'File uploaded successfully',
//   icon: Icons.cloud_done,
//   actions: [
//     IconButton(
//       onPressed: () {},
//       icon: const Icon(Icons.share, color: Colors.white),
//     IconButton(
//       onPressed: () {},
//       icon: const Icon(Icons.open_in_new, color: Colors.white),
//     ),
//   ],
// );

// Show the snackbar with undo button
// CustomSnackBar.show(
//   context: context,
//   title: 'Item deleted',
//   icon: Icons.delete_outline,
//   actions: [
//     TextButton(
//       onPressed: () {
//         // Undo logic
//         HapticFeedback.lightImpact();
//       },
//       child: const Text(
//         'Undo',
//         style: TextStyle(
//           color: Colors.blueAccent,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//   ],
// );
