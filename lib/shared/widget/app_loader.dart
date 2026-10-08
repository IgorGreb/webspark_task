import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.size = 64,
    this.strokeWidth = 3,
    this.value,
  });

  final double size;
  final double strokeWidth;
  final double? value;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return SizedBox(
      width: size.w,
      height: size.w,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth.w,
        color: color,
      ),
    );
  }
}
