import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/result_list/widget/result_row.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';

class ResultListBody extends StatelessWidget {
  const ResultListBody({super.key, required this.mockPaths});

  final List<String> mockPaths;

  @override
  Widget build(BuildContext context) {
    if (mockPaths.isEmpty) {
      return Center(
        child: Text(
          context.l10n.emptyResultsMessage,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: AppSizes.bodyFontSize.sp),
        ),
      );
    }
    return ListView.builder(
      itemCount: mockPaths.length,
      itemBuilder: (context, index) {
        return ResultRow(pathStr: mockPaths[index]);
      },
    );
  }
}
