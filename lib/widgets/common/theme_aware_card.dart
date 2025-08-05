import 'package:flutter/material.dart';
import 'package:edumate/utils/responsive_utils.dart';

/// A theme-aware card component that adapts to light/dark mode
class ThemeAwareCard extends StatelessWidget {
  const ThemeAwareCard({
    super.key,
    required this.child,
    this.onTap,
    this.elevation,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.isResponsive = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double? elevation;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final bool isResponsive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Responsive adjustments
    final responsivePadding = isResponsive ? context.responsivePadding : null;
    final responsiveMargin = isResponsive ? context.responsiveMargin : null;
    final responsiveBorderRadius = isResponsive 
        ? (context.isMobile ? 8.0 : 12.0)
        : (borderRadius ?? 8.0);

    final cardElevation = elevation ?? (isDark ? 8.0 : 4.0);
    final cardBackgroundColor = backgroundColor ?? 
        (isDark ? theme.cardColor : Colors.white);
    
    final cardBorderColor = borderColor ?? 
        (isDark ? Colors.grey[700] : Colors.grey[300]);

    return Container(
      margin: margin ?? responsiveMargin,
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(responsiveBorderRadius),
        border: borderWidth > 0 
            ? Border.all(color: cardBorderColor!, width: borderWidth)
            : null,
        boxShadow: cardElevation > 0
            ? [
                BoxShadow(
                  color: (isDark ? Colors.black : Colors.grey)
                      .withValues(alpha: isDark ? 0.3 : 0.2),
                  blurRadius: cardElevation,
                  offset: Offset(0, cardElevation / 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(responsiveBorderRadius),
          child: Container(
            padding: padding ?? responsivePadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A theme-aware text component with responsive font sizes
class ThemeAwareText extends StatelessWidget {
  const ThemeAwareText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticLabel,
    this.isHeading = false,
    this.isSubtitle = false,
    this.isCaption = false,
    this.isResponsive = true,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? semanticLabel;
  final bool isHeading;
  final bool isSubtitle;
  final bool isCaption;
  final bool isResponsive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle baseStyle;

    if (isHeading) {
      baseStyle = theme.textTheme.headlineSmall ?? const TextStyle();
    } else if (isSubtitle) {
      baseStyle = theme.textTheme.titleMedium ?? const TextStyle();
    } else if (isCaption) {
      baseStyle = theme.textTheme.bodySmall ?? const TextStyle();
    } else {
      baseStyle = theme.textTheme.bodyMedium ?? const TextStyle();
    }

    // Apply responsive font size
    if (isResponsive) {
      final responsiveFontSize = context.responsiveFontSize(
        baseStyle.fontSize ?? 14.0,
      );
      baseStyle = baseStyle.copyWith(fontSize: responsiveFontSize);
    }

    // Merge with custom style
    final finalStyle = baseStyle.merge(style);

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticLabel,
    );
  }
}

/// A theme-aware icon button with consistent sizing
class ThemeAwareIconButton extends StatelessWidget {
  const ThemeAwareIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize,
    this.color,
    this.backgroundColor,
    this.tooltip,
    this.isResponsive = true,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double? iconSize;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;
  final bool isResponsive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final responsiveIconSize = isResponsive
        ? (context.isMobile ? 20.0 : 24.0)
        : (iconSize ?? 24.0);

    final iconColor = color ?? 
        (isDark ? Colors.white70 : Colors.black87);
    
    final buttonBackgroundColor = backgroundColor ?? 
        (isDark ? Colors.grey[800] : Colors.grey[100]);

    Widget button = IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: responsiveIconSize,
        color: iconColor,
      ),
      style: IconButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        padding: EdgeInsets.all(isResponsive && context.isMobile ? 8 : 12),
      ),
      tooltip: tooltip,
    );

    return button;
  }
}