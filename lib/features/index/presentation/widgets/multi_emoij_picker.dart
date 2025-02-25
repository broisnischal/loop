import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// EmojiPicker(
//   onEmojiSelected: (emoji) {
//     print('Selected emoji: $emoji');
//   },
//   emojis: const ['😀', '😂', '❤️', '🔥'], // Optional custom list
// ),

class EmojiPicker extends StatefulWidget {
  const EmojiPicker({
    required this.onEmojiSelected,
    super.key,
    this.emojis = const [
      '😀',
      '😂',
      '🥰',
      '😎',
      '🤩',
      '😜',
      '🤔',
      '🙌',
      '🎉',
      '💯',
      '🔥',
      '✨',
      '❤️',
      '🌟',
      '💎',
      '🦄',
      '🌈',
      '🍕',
      '⚡',
      '🚀',
      '🎮',
      '🎨',
      '📚',
      '🎵',
      '🏆',
      '🍩',
      '🐶',
      '🐱',
    ],
  });
  final ValueChanged<String> onEmojiSelected;
  final List<String> emojis;

  @override
  State<EmojiPicker> createState() => _EmojiPickerState();
}

class _EmojiPickerState extends State<EmojiPicker> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: widget.emojis.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() => selectedIndex = index);
                  widget.onEmojiSelected(widget.emojis[index]);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedIndex == index
                          ? Colors.blueAccent
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.emojis[index],
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
