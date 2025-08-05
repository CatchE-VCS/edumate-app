import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Performance monitoring utility for tracking app performance
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  final Map<String, DateTime> _startTimes = {};
  final Map<String, List<Duration>> _measurements = {};

  /// Start timing an operation
  void startTimer(String operationName) {
    _startTimes[operationName] = DateTime.now();
  }

  /// End timing an operation and record the duration
  void endTimer(String operationName) {
    final startTime = _startTimes[operationName];
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      _measurements.putIfAbsent(operationName, () => []).add(duration);
      _startTimes.remove(operationName);
      
      // Log in debug mode
      if (kDebugMode) {
        developer.log(
          'Performance: $operationName took ${duration.inMilliseconds}ms',
          name: 'PerformanceMonitor',
        );
      }
    }
  }

  /// Get average duration for an operation
  Duration? getAverageDuration(String operationName) {
    final measurements = _measurements[operationName];
    if (measurements == null || measurements.isEmpty) return null;
    
    final totalMs = measurements
        .map((d) => d.inMilliseconds)
        .reduce((a, b) => a + b);
    
    return Duration(milliseconds: totalMs ~/ measurements.length);
  }

  /// Get all measurements for an operation
  List<Duration>? getMeasurements(String operationName) {
    return _measurements[operationName];
  }

  /// Clear measurements for an operation
  void clearMeasurements(String operationName) {
    _measurements.remove(operationName);
  }

  /// Clear all measurements
  void clearAllMeasurements() {
    _measurements.clear();
    _startTimes.clear();
  }

  /// Get performance report
  Map<String, dynamic> getPerformanceReport() {
    final report = <String, dynamic>{};
    
    for (final entry in _measurements.entries) {
      final operationName = entry.key;
      final measurements = entry.value;
      
      if (measurements.isNotEmpty) {
        final durations = measurements.map((d) => d.inMilliseconds).toList();
        durations.sort();
        
        report[operationName] = {
          'count': measurements.length,
          'average': durations.reduce((a, b) => a + b) / durations.length,
          'min': durations.first,
          'max': durations.last,
          'median': durations[durations.length ~/ 2],
        };
      }
    }
    
    return report;
  }

  /// Log performance report
  void logPerformanceReport() {
    if (kDebugMode) {
      final report = getPerformanceReport();
      developer.log(
        'Performance Report: $report',
        name: 'PerformanceMonitor',
      );
    }
  }
}

/// Extension to easily measure widget build times
mixin PerformanceAware {
  void measurePerformance(String operationName, VoidCallback operation) {
    PerformanceMonitor().startTimer(operationName);
    operation();
    PerformanceMonitor().endTimer(operationName);
  }

  Future<T> measureAsyncPerformance<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    PerformanceMonitor().startTimer(operationName);
    try {
      final result = await operation();
      return result;
    } finally {
      PerformanceMonitor().endTimer(operationName);
    }
  }
}

/// Widget wrapper for measuring build performance
class PerformanceMeasuredWidget extends StatelessWidget {
  const PerformanceMeasuredWidget({
    super.key,
    required this.child,
    required this.operationName,
  });

  final Widget child;
  final String operationName;

  @override
  Widget build(BuildContext context) {
    PerformanceMonitor().startTimer(operationName);
    
    return _PerformanceWrapper(
      operationName: operationName,
      child: child,
    );
  }
}

class _PerformanceWrapper extends StatefulWidget {
  const _PerformanceWrapper({
    required this.operationName,
    required this.child,
  });

  final String operationName;
  final Widget child;

  @override
  State<_PerformanceWrapper> createState() => _PerformanceWrapperState();
}

class _PerformanceWrapperState extends State<_PerformanceWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PerformanceMonitor().endTimer(widget.operationName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}