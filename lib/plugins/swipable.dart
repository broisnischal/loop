import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SwipeDirection {
  left,
  right,
  none,
}

class SwipeableItem extends StatefulWidget {
  const SwipeableItem({
    required this.child,
    super.key,
    this.onSwipe,
    this.threshold = 0.3,
    this.animationDuration = const Duration(milliseconds: 300),
    this.leftSwipeColor = Colors.red,
    this.rightSwipeColor = Colors.green,
    this.removeOnSwipe = true,
    this.onRemoved,
    this.leftSwipeEnabled = true,
    this.rightSwipeEnabled = true,
  });
  final Widget child;
  final Function(SwipeDirection direction)? onSwipe;
  final double threshold;
  final Duration animationDuration;
  final Color leftSwipeColor;
  final Color rightSwipeColor;
  final bool removeOnSwipe;
  final VoidCallback? onRemoved;
  final bool leftSwipeEnabled;
  final bool rightSwipeEnabled;

  @override
  State<SwipeableItem> createState() => _SwipeableItemState();
}

class _SwipeableItemState extends State<SwipeableItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _heightAnimation;

  double _dragExtent = 1;
  bool _isVisible = true;
  final double _itemHeight = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );

    _heightAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if ((!widget.leftSwipeEnabled && details.delta.dx < 0) ||
        (!widget.rightSwipeEnabled && details.delta.dx > 0)) {
      return;
    }

    setState(() {
      _dragExtent += details.delta.dx;
    });

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(_dragExtent, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  void _handleDragEnd(DragEndDetails details) {
    HapticFeedback.lightImpact();

    // Get the width from the constraints instead of context.size
    final width = MediaQuery.of(context).size.width;
    final threshold = widget.threshold * width;
    var direction = SwipeDirection.none;

    if (_dragExtent > threshold && widget.rightSwipeEnabled) {
      // Swiped right beyond threshold
      _slideAnimation = Tween<Offset>(
        begin: Offset(_dragExtent / width, 0),
        end: const Offset(1.5, 0),
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ),
      );
      direction = SwipeDirection.right;
    } else if (_dragExtent < -threshold && widget.leftSwipeEnabled) {
      // Swiped left beyond threshold
      _slideAnimation = Tween<Offset>(
        begin: Offset(_dragExtent / width, 0),
        end: const Offset(-1.5, 0),
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ),
      );
      direction = SwipeDirection.left;
    } else if (_dragExtent.abs() < threshold) {
      // Not swiped enough, bounce back
      _slideAnimation = Tween<Offset>(
        begin: Offset(_dragExtent / width, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.elasticOut,
        ),
      );
      _animationController.forward().then((_) {
        setState(() {
          _dragExtent = 0;
        });
      });
      return;
    } else {
      _slideAnimation = Tween<Offset>(
        begin: Offset(_dragExtent / width, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.elasticOut,
        ),
      );
      _animationController.forward().then((_) {
        setState(() {
          _dragExtent = 0;
        });
      });
    }

    // Handle successful swipe
    if (direction != SwipeDirection.none) {
      widget.onSwipe?.call(direction);

      if (widget.removeOnSwipe) {
        _animationController.forward().then((_) {
          setState(() {
            _isVisible = false;
          });
          widget.onRemoved?.call();
        });
      } else {
        _animationController.forward().then((_) {
          setState(() {
            _dragExtent = 0;
          });
          _slideAnimation = Tween<Offset>(
            begin: Offset.zero,
            end: Offset.zero,
          ).animate(_animationController);
          _animationController.reset();
        });
      }
    }
  }

  Color _getBackgroundColor() {
    // Calculate opacity based on drag extent relative to screen width
    final width = MediaQuery.of(context).size.width;

    if (_dragExtent > 0) {
      // Right swipe (green background)
      return widget.rightSwipeColor
          .withOpacity((_dragExtent / width).clamp(0.0, 0.3));
    } else if (_dragExtent < 0) {
      // Left swipe (red background)
      return widget.leftSwipeColor
          .withOpacity((-_dragExtent / width).clamp(0.0, 0.3));
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return AnimatedContainer(
        duration: widget.animationDuration,
        height: 0,
        child: const SizedBox(),
      );
    }

    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            color: _getBackgroundColor(),
            alignment: Alignment.centerRight,
            child: FadeTransition(
              opacity: widget.removeOnSwipe
                  ? _opacityAnimation
                  : const AlwaysStoppedAnimation(1),
              child: SizeTransition(
                sizeFactor: widget.removeOnSwipe
                    ? _heightAnimation
                    : const AlwaysStoppedAnimation(1),
                // axisAlignment: 1,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Transform.translate(
                    offset: Offset(_dragExtent, -5),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
