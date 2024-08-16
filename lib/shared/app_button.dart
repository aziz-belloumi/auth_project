import 'package:convergeimmob/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  const AppButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.gradient = const LinearGradient(
      colors: [Color(0xFFFFFFFF), Color(0xFFC7A048)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.width,
    this.height,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          // gradient: gradient,
          color: AppColors.bluebgNavItem),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Colors.transparent,
          minimumSize: Size.fromHeight(height ?? 46),
          // Make the button transparent
          shadowColor: Colors.transparent,
          // No shadow
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          padding: padding,
        ).copyWith(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
