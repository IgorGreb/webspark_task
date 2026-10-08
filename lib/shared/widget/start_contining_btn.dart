import 'package:flutter/material.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';

class MainBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  final Color backgroundColor;
  final Color textColor;
  final Color disabledBackgroundColor;
  final Color disabledTextColor;

  final double fontSize;
  final FontWeight fontWeight;
  final TextStyle? textStyle;

  final double height;
  final double? width;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  MainBtn({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.buttonBackgroundColor,
    this.textColor = AppColors.lockedCell,
    this.disabledBackgroundColor = AppColors.disabledButtonBackgroundColor,
    this.disabledTextColor = AppColors.lockedCell,
    this.fontSize = AppSizes.btnFontSize,
    this.fontWeight = FontWeight.w600,
    this.textStyle,
    this.height = AppSizes.btnHeight,
    this.width = double.infinity,
    this.borderRadius = AppSizes.btnBorderRadius,
    this.elevation = AppSizes.btnElevation,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) : padding = padding ?? AppInsets.btnPadding,
       margin = margin ?? AppInsets.btnMargin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            disabledBackgroundColor: disabledBackgroundColor,
            disabledForegroundColor: disabledTextColor,
            elevation: elevation,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Text(
            label,
            style:
                textStyle ??
                TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
