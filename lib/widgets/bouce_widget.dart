import 'dart:async';

import 'package:flutter/material.dart';

class BounceWidget extends StatefulWidget {
  final Widget child;

  final Duration? duration;

  final Duration? delay;

  const BounceWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = const Duration(milliseconds: 0),
  }) : super(key: key);

  @override
  State<BounceWidget> createState() => _BounceWidgetState();
}

class _BounceWidgetState extends State<BounceWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);

    Timer(widget.delay!, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
