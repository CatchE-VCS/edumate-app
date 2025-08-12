import 'package:flutter/material.dart';

/// A reusable information card widget with consistent styling
class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    this.subtitle,
    this.child,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.borderRadius = 12.0,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(8),
  });

  final String title;
  final String? subtitle;
  final Widget? child;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                if (child != null) ...[
                  const SizedBox(height: 8),
                  child!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}