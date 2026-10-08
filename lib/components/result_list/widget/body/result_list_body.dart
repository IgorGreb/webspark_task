import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/result_list/widget/result_row.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
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
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        final pathStr = result.steps.map((p) => '(${p.x},${p.y})').join('->');
        return ResultRow(pathStr: pathStr);
      },
    );
  }
}
