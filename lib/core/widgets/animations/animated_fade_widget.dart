import 'package:flutter/material.dart';

class AnimatedFadeWidget extends StatefulWidget {
  final Widget child;
  final int delay;

  const AnimatedFadeWidget({
    super.key,
    required this.child,
    this.delay = 200,
  });

  @override
  _AnimatedFadeWidgetState createState() => _AnimatedFadeWidgetState();
}

class _AnimatedFadeWidgetState extends State<AnimatedFadeWidget> {
  double _opacity = 0.75;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: _opacity,
      child: widget.child,
    );
  }
}
