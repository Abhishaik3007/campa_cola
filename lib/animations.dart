import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Interactive button wrapper providing tactile springy scale feedback on tap.
class BouncyButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;
  final double scaleDown;
  final HitTestBehavior behavior;

  const BouncyButton({
    super.key,
    required this.onTap,
    required this.child,
    this.scaleDown = 0.93,
    this.behavior = HitTestBehavior.deferToChild,
  });

  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleDown).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null) _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      _controller.reverse();
      widget.onTap?.call();
    }
  }

  void _onTapCancel() {
    if (widget.onTap != null) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}

/// Organic floating tilt and gentle vertical sway for polaroids.
class FloatingPolaroid extends StatefulWidget {
  final Widget child;
  final double maxDy;
  final double maxAngle;
  final Duration duration;
  final double phaseShift;

  const FloatingPolaroid({
    super.key,
    required this.child,
    this.maxDy = 4.0,
    this.maxAngle = 0.02,
    this.duration = const Duration(milliseconds: 3400),
    this.phaseShift = 0.0,
  });

  @override
  State<FloatingPolaroid> createState() => _FloatingPolaroidState();
}

class _FloatingPolaroidState extends State<FloatingPolaroid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..value = widget.phaseShift
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Smooth sine wave easing
        final t = math.sin((_controller.value + widget.phaseShift) * math.pi);
        final dy = t * widget.maxDy;
        final dAngle = t * widget.maxAngle;

        return Transform.translate(
          offset: Offset(0, dy),
          child: Transform.rotate(
            angle: dAngle,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Heartbeat rhythmic pulse animation for doodle hearts.
class PulsingHeart extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const PulsingHeart({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2000),
  });

  @override
  State<PulsingHeart> createState() => _PulsingHeartState();
}

class _PulsingHeartState extends State<PulsingHeart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    // Rhythmic heartbeat: thump-thump then rest
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.15)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 14,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 14,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.09)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 12,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.09, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 14,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 46,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        alignment: Alignment.center,
        child: child,
      ),
      child: widget.child,
    );
  }
}

/// Twinkling pulse with subtle opacity and scale for hand-drawn sparkles & bursts.
class TwinklingSparkle extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minOpacity;
  final double minScale;
  final double maxScale;

  const TwinklingSparkle({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1700),
    this.minOpacity = 0.45,
    this.minScale = 0.88,
    this.maxScale = 1.14,
  });

  @override
  State<TwinklingSparkle> createState() => _TwinklingSparkleState();
}

class _TwinklingSparkleState extends State<TwinklingSparkle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(curved);

    _opacityAnimation = Tween<double>(
      begin: widget.minOpacity,
      end: 1.0,
    ).animate(curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _opacityAnimation.value,
        child: Transform.scale(
          scale: _scaleAnimation.value,
          alignment: Alignment.center,
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
