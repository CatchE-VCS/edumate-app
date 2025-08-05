import 'package:flutter/material.dart';

/// Animated card with entrance animations
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool autoPlay;
  final VoidCallback? onAnimationComplete;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;

  const AnimatedCard({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.autoPlay = true,
    this.onAnimationComplete,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.6, curve: widget.curve),
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.8, curve: widget.curve),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.2, 1.0, curve: widget.curve),
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });

    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void playAnimation() {
    _controller.forward();
  }

  void reverseAnimation() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Card(
                margin: widget.margin,
                color: widget.backgroundColor,
                elevation: widget.elevation,
                shape: widget.borderRadius != null
                    ? RoundedRectangleBorder(
                        borderRadius: widget.borderRadius!,
                      )
                    : null,
                child: widget.padding != null
                    ? Padding(
                        padding: widget.padding!,
                        child: widget.child,
                      )
                    : widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Animated button with press animations
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? splashColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? elevation;
  final Duration animationDuration;

  const AnimatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.splashColor,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.animationDuration = const Duration(milliseconds: 150),
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _controller.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null ? _handleTapDown : null,
      onTapUp: widget.onPressed != null ? _handleTapUp : null,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: widget.animationDuration,
              padding: widget.padding ?? const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Theme.of(context).primaryColor,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: _isPressed ? 2 : (widget.elevation ?? 4),
                    offset: Offset(0, _isPressed ? 1 : (widget.elevation ?? 4) / 2),
                  ),
                ],
              ),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

/// Staggered list animation
class StaggeredListView extends StatefulWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final Duration itemAnimationDuration;
  final Curve curve;
  final bool autoPlay;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const StaggeredListView({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.itemAnimationDuration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.autoPlay = true,
    this.physics,
    this.padding,
  });

  @override
  State<StaggeredListView> createState() => _StaggeredListViewState();
}

class _StaggeredListViewState extends State<StaggeredListView>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    
    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startStaggeredAnimation();
      });
    }
  }

  void _initializeAnimations() {
    _controllers = [];
    _fadeAnimations = [];
    _slideAnimations = [];

    for (int i = 0; i < widget.children.length; i++) {
      final controller = AnimationController(
        duration: widget.itemAnimationDuration,
        vsync: this,
      );

      final fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      ));

      final slideAnimation = Tween<Offset>(
        begin: const Offset(0.0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      ));

      _controllers.add(controller);
      _fadeAnimations.add(fadeAnimation);
      _slideAnimations.add(slideAnimation);
    }
  }

  void _startStaggeredAnimation() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.staggerDelay * i, () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void playAnimation() {
    _startStaggeredAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.physics,
      padding: widget.padding,
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _controllers[index],
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimations[index],
              child: SlideTransition(
                position: _slideAnimations[index],
                child: widget.children[index],
              ),
            );
          },
        );
      },
    );
  }
}

/// Animated counter widget
class AnimatedCounter extends StatefulWidget {
  final int value;
  final Duration duration;
  final TextStyle? textStyle;
  final String? prefix;
  final String? suffix;
  final Curve curve;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 1000),
    this.textStyle,
    this.prefix,
    this.suffix,
    this.curve = Curves.easeOut,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.value.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      _animation = Tween<double>(
        begin: _previousValue.toDouble(),
        end: widget.value.toDouble(),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ));
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${widget.prefix ?? ''}${_animation.value.round()}${widget.suffix ?? ''}',
          style: widget.textStyle,
        );
      },
    );
  }
}

/// Animated progress indicator
class AnimatedProgressIndicator extends StatefulWidget {
  final double value;
  final Duration duration;
  final Color? backgroundColor;
  final Color? valueColor;
  final double height;
  final BorderRadius? borderRadius;
  final Curve curve;

  const AnimatedProgressIndicator({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 800),
    this.backgroundColor,
    this.valueColor,
    this.height = 4.0,
    this.borderRadius,
    this.curve = Curves.easeInOut,
  });

  @override
  State<AnimatedProgressIndicator> createState() => _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.value,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.value,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ));
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.grey[300],
            borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.height / 2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _animation.value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.valueColor ?? Theme.of(context).primaryColor,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.height / 2),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Pulse animation widget
class PulseAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;
  final bool infinite;

  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.minScale = 0.95,
    this.maxScale = 1.05,
    this.infinite = true,
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.infinite) {
      _controller.repeat(reverse: true);
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}