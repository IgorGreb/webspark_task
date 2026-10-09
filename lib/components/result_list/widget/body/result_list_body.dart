import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/result_list/widget/result_row.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';
import 'package:webspark_task/shared/models/solved_model.dart';

class ResultListBody extends StatelessWidget {
  const ResultListBody({super.key, required this.results});

  final List<SolvedModel> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Text(
          context.l10n.emptyResultsMessage,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: AppSizes.bodyFontSize.sp),
        ),
      );
    }
    return ListView.separated(
      itemCount: results.length,
      // Rows do not need to be kept alive off-screen; paths are memoized in
      // the model so rebuilds stay cheap.
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 1, color: AppColors.dividerColor),
      itemBuilder: (context, index) => ResultRow(solved: results[index]),
    );
  }
}
