import 'package:flutter/material.dart';


class AppBackground extends StatelessWidget {
  const AppBackground({
    Key? key,
    this.child,
    required this.padding,
  }) : super(key: key);

  final EdgeInsets padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
        minWidth: MediaQuery.of(context).size.width,
      ),
      // decoration: const BoxDecoration(
      //   gradient: RadialGradient(
      //     center: AppStyles.gradientAlignment,
      //     radius: AppStyles.gradientRadius,
      //     colors: [
      //       AppColors.greyBg,
      //       Colors.black,
      //     ],
      //   ),
      // ),
      child: child,
    );
  }
}
