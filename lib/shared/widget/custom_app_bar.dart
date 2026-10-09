import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.backgroundColor = AppColors.primaryColor,
    this.foregroundColor = AppColors.buttonTextColor,
    this.titleStyle,
  }) : assert(
         title != null || titleWidget != null,
         'Either title or titleWidget must be provided',
       );

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color foregroundColor;
  final TextStyle? titleStyle;

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.appBarHeight.h);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedTitleStyle =
        titleStyle ??
        theme.appBarTheme.titleTextStyle ??
        theme.textTheme.titleLarge?.copyWith(color: foregroundColor) ??
        TextStyle(
          color: foregroundColor,
          fontSize: AppSizes.appBarTitleFontSize.sp,
          fontWeight: FontWeight.w600,
        );

    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      leading: leading,
      actions: actions,
      title:
          titleWidget ??
          Text(
            title ?? '',
            style: resolvedTitleStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
    );
  }
}
