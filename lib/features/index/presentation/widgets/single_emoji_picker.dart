import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loop/core/constants/colors.dart';

class EmojiPickerButton extends StatefulWidget {
  const EmojiPickerButton({
    required this.onEmojiSelected,
    super.key,
    this.initialEmoji,
    this.size = 56,
    this.backgroundColor = Colors.blue,
  });
  final ValueChanged<String> onEmojiSelected;
  final String? initialEmoji;
  final double size;
  final Color backgroundColor;

  @override
  State<EmojiPickerButton> createState() => _EmojiPickerButtonState();
}

class _EmojiPickerButtonState extends State<EmojiPickerButton> {
  String? _selectedEmoji;

  final List<String> _emojis = [
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
  ];

  @override
  void initState() {
    super.initState();
    _selectedEmoji = widget.initialEmoji;
  }

  void _showEmojiPicker(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: ColorConst.lightBlack,
      context: context,
      builder: (context) => _EmojiPickerGrid(
        emojis: _emojis,
        onEmojiSelected: (emoji) {
          HapticFeedback.lightImpact();
          setState(() => _selectedEmoji = emoji);
          widget.onEmojiSelected(emoji);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEmojiPicker(context),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            _selectedEmoji ?? '😊',
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}

class _EmojiPickerGrid extends StatelessWidget {
  const _EmojiPickerGrid({
    required this.emojis,
    required this.onEmojiSelected,
  });
  final List<String> emojis;
  final ValueChanged<String> onEmojiSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConst.lightBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: emojis.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => onEmojiSelected(emojis[index]),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child:
                      Text(emojis[index], style: const TextStyle(fontSize: 28)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
