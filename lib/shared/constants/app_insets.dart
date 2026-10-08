import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppInsets {
  static EdgeInsets get btnPadding => EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsets get btnMargin =>
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);
  static EdgeInsets get bottomBarSafeArea => EdgeInsets.only(bottom: 8.h);
  static EdgeInsets get homeBody =>
      EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h);
  static EdgeInsets get inputContent => EdgeInsets.symmetric(vertical: 12.h);
}
