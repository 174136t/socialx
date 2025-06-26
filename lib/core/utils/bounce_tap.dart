import 'package:flutter/material.dart';

class BounceTap extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Duration duration;
  final double scale;

  const BounceTap({
    super.key,
    required this.child,
    required this.onTap,
    this.duration = const Duration(milliseconds: 200),
    this.scale = 0.95,
  });

  @override
  State<BounceTap> createState() => _BounceTapState();
}

class _BounceTapState extends State<BounceTap> {
  double _scale = 1.0;
  bool _isAnimating = false;

  Future<void> _handleTap() async {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
      _scale = widget.scale;
    });

    await Future.delayed(widget.duration);

    setState(() {
      _scale = 1.0;
    });

    await Future.delayed(widget.duration);

    widget.onTap();

    _isAnimating = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _scale,
        duration: widget.duration,
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
