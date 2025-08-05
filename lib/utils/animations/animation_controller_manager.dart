import 'package:flutter/material.dart';

/// Advanced animation controller manager for coordinating multiple animations
class AnimationControllerManager {
  final Map<String, AnimationController> _controllers = {};
  final Map<String, Animation> _animations = {};
  final TickerProvider _vsync;

  AnimationControllerManager(this._vsync);

  /// Create and register an animation controller
  AnimationController createController({
    required String name,
    required Duration duration,
    Duration? reverseDuration,
    String? debugLabel,
    double lowerBound = 0.0,
    double upperBound = 1.0,
    AnimationBehavior animationBehavior = AnimationBehavior.normal,
  }) {
    final controller = AnimationController(
      duration: duration,
      reverseDuration: reverseDuration,
      debugLabel: debugLabel ?? name,
      lowerBound: lowerBound,
      upperBound: upperBound,
      animationBehavior: animationBehavior,
      vsync: _vsync,
    );

    _controllers[name] = controller;
    return controller;
  }

  /// Get an existing controller by name
  AnimationController? getController(String name) {
    return _controllers[name];
  }

  /// Create and register a tween animation
  Animation<T> createTween<T>({
    required String name,
    required String controllerName,
    required Tween<T> tween,
    Curve curve = Curves.linear,
  }) {
    final controller = _controllers[controllerName];
    if (controller == null) {
      throw ArgumentError('Controller $controllerName not found');
    }

    final animation = tween.animate(
      CurvedAnimation(parent: controller, curve: curve),
    );

    _animations[name] = animation;
    return animation;
  }

  /// Get an existing animation by name
  Animation<T>? getAnimation<T>(String name) {
    return _animations[name] as Animation<T>?;
  }

  /// Start an animation
  Future<void> startAnimation(String controllerName) async {
    final controller = _controllers[controllerName];
    if (controller != null) {
      await controller.forward();
    }
  }

  /// Reverse an animation
  Future<void> reverseAnimation(String controllerName) async {
    final controller = _controllers[controllerName];
    if (controller != null) {
      await controller.reverse();
    }
  }

  /// Reset an animation
  void resetAnimation(String controllerName) {
    final controller = _controllers[controllerName];
    controller?.reset();
  }

  /// Stop an animation
  void stopAnimation(String controllerName) {
    final controller = _controllers[controllerName];
    controller?.stop();
  }

  /// Start multiple animations simultaneously
  Future<void> startAnimations(List<String> controllerNames) async {
    final futures = controllerNames
        .map((name) => _controllers[name]?.forward())
        .where((future) => future != null)
        .cast<Future<void>>();
    
    await Future.wait(futures);
  }

  /// Start animations in sequence
  Future<void> startAnimationsSequentially(List<String> controllerNames) async {
    for (final name in controllerNames) {
      await startAnimation(name);
    }
  }

  /// Create a staggered animation sequence
  void createStaggeredSequence({
    required List<String> controllerNames,
    required Duration totalDuration,
    required Duration itemDuration,
  }) {
    final interval = totalDuration.inMilliseconds / controllerNames.length;
    
    for (int i = 0; i < controllerNames.length; i++) {
      final controller = _controllers[controllerNames[i]];
      if (controller != null) {
        Future.delayed(Duration(milliseconds: (interval * i).round()), () {
          controller.forward();
        });
      }
    }
  }

  /// Dispose all controllers
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    _animations.clear();
  }

  /// Get all controller names
  Set<String> get controllerNames => _controllers.keys.toSet();

  /// Get all animation names
  Set<String> get animationNames => _animations.keys.toSet();

  /// Check if controller exists
  bool hasController(String name) => _controllers.containsKey(name);

  /// Check if animation exists
  bool hasAnimation(String name) => _animations.containsKey(name);
}

/// Mixin for widgets that need animation controller management
mixin AnimationControllerMixin<T extends StatefulWidget> on State<T>, TickerProviderStateMixin<T> {
  late final AnimationControllerManager _animationManager;

  @override
  void initState() {
    super.initState();
    _animationManager = AnimationControllerManager(this);
    setupAnimations();
  }

  @override
  void dispose() {
    _animationManager.dispose();
    super.dispose();
  }

  /// Override this method to setup your animations
  void setupAnimations() {}

  /// Get the animation manager
  AnimationControllerManager get animationManager => _animationManager;
}

/// Predefined animation configurations
class AnimationPresets {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  /// Fade in animation configuration
  static AnimationConfig fadeIn({
    Duration duration = normal,
    Curve curve = Curves.easeIn,
  }) {
    return AnimationConfig(
      duration: duration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: curve,
    );
  }

  /// Slide in from left animation configuration
  static AnimationConfig slideInFromLeft({
    Duration duration = normal,
    Curve curve = Curves.easeOut,
    double distance = 300.0,
  }) {
    return AnimationConfig(
      duration: duration,
      tween: Tween<Offset>(begin: Offset(-distance, 0.0), end: Offset.zero),
      curve: curve,
    );
  }

  /// Slide in from right animation configuration
  static AnimationConfig slideInFromRight({
    Duration duration = normal,
    Curve curve = Curves.easeOut,
    double distance = 300.0,
  }) {
    return AnimationConfig(
      duration: duration,
      tween: Tween<Offset>(begin: Offset(distance, 0.0), end: Offset.zero),
      curve: curve,
    );
  }

  /// Scale up animation configuration
  static AnimationConfig scaleUp({
    Duration duration = normal,
    Curve curve = Curves.elasticOut,
    double fromScale = 0.0,
    double toScale = 1.0,
  }) {
    return AnimationConfig(
      duration: duration,
      tween: Tween<double>(begin: fromScale, end: toScale),
      curve: curve,
    );
  }

  /// Bounce animation configuration
  static AnimationConfig bounce({
    Duration duration = slow,
    Curve curve = Curves.bounceOut,
  }) {
    return AnimationConfig(
      duration: duration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: curve,
    );
  }

  /// Rotation animation configuration
  static AnimationConfig rotation({
    Duration duration = slow,
    Curve curve = Curves.linear,
    double turns = 1.0,
  }) {
    return AnimationConfig(
      duration: duration,
      tween: Tween<double>(begin: 0.0, end: turns),
      curve: curve,
    );
  }
}

/// Configuration class for animations
class AnimationConfig<T> {
  final Duration duration;
  final Tween<T> tween;
  final Curve curve;
  final Duration? reverseDuration;

  const AnimationConfig({
    required this.duration,
    required this.tween,
    this.curve = Curves.linear,
    this.reverseDuration,
  });
}

/// Utility class for creating common animations
class AnimationUtils {
  /// Create a slide transition
  static Widget slideTransition({
    required Animation<Offset> animation,
    required Widget child,
    TextDirection textDirection = TextDirection.ltr,
  }) {
    return SlideTransition(
      position: animation,
      textDirection: textDirection,
      child: child,
    );
  }

  /// Create a fade transition
  static Widget fadeTransition({
    required Animation<double> animation,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// Create a scale transition
  static Widget scaleTransition({
    required Animation<double> animation,
    required Widget child,
    Alignment alignment = Alignment.center,
  }) {
    return ScaleTransition(
      scale: animation,
      alignment: alignment,
      child: child,
    );
  }

  /// Create a rotation transition
  static Widget rotationTransition({
    required Animation<double> animation,
    required Widget child,
    Alignment alignment = Alignment.center,
  }) {
    return RotationTransition(
      turns: animation,
      alignment: alignment,
      child: child,
    );
  }

  /// Create a size transition
  static Widget sizeTransition({
    required Animation<double> animation,
    required Widget child,
    Axis axis = Axis.vertical,
    double axisAlignment = 0.0,
  }) {
    return SizeTransition(
      sizeFactor: animation,
      axis: axis,
      axisAlignment: axisAlignment,
      child: child,
    );
  }

  /// Create a combined fade and slide transition
  static Widget fadeSlideTransition({
    required Animation<double> fadeAnimation,
    required Animation<Offset> slideAnimation,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: child,
      ),
    );
  }

  /// Create a staggered animation for a list
  static List<Widget> createStaggeredList({
    required List<Widget> children,
    required AnimationController controller,
    Duration staggerDelay = const Duration(milliseconds: 100),
    Curve curve = Curves.easeOut,
  }) {
    return children.asMap().entries.map((entry) {
      final index = entry.key;
      final child = entry.value;
      
      final animationStart = (index * staggerDelay.inMilliseconds) / 
                           controller.duration!.inMilliseconds;
      final animationEnd = ((index * staggerDelay.inMilliseconds) + 
                          staggerDelay.inMilliseconds) / 
                         controller.duration!.inMilliseconds;
      
      final animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            animationStart.clamp(0.0, 1.0),
            animationEnd.clamp(0.0, 1.0),
            curve: curve,
          ),
        ),
      );
      
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.5),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    }).toList();
  }
}

/// Advanced animation sequences
class AnimationSequence {
  final List<AnimationStep> steps;
  final Duration totalDuration;
  
  const AnimationSequence({
    required this.steps,
    required this.totalDuration,
  });
  
  /// Execute the animation sequence
  Future<void> execute(AnimationControllerManager manager) async {
    for (final step in steps) {
      await step.execute(manager);
      if (step.delay != null) {
        await Future.delayed(step.delay!);
      }
    }
  }
}

/// Single step in an animation sequence
class AnimationStep {
  final String controllerName;
  final AnimationAction action;
  final Duration? delay;
  final VoidCallback? callback;
  
  const AnimationStep({
    required this.controllerName,
    required this.action,
    this.delay,
    this.callback,
  });
  
  /// Execute this animation step
  Future<void> execute(AnimationControllerManager manager) async {
    switch (action) {
      case AnimationAction.forward:
        await manager.startAnimation(controllerName);
        break;
      case AnimationAction.reverse:
        await manager.reverseAnimation(controllerName);
        break;
      case AnimationAction.reset:
        manager.resetAnimation(controllerName);
        break;
      case AnimationAction.stop:
        manager.stopAnimation(controllerName);
        break;
    }
    
    callback?.call();
  }
}

/// Actions that can be performed on an animation
enum AnimationAction {
  forward,
  reverse,
  reset,
  stop,
}