import 'package:flutter/material.dart';

/// A reusable custom button widget with consistent styling
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.isLoading = false,
    this.isEnabled = true,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(text),
    );
  }
}