import 'package:flutter/material.dart';
import 'package:webspark_task/components/result_list/widget/body/result_list_body.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/models/solved_model.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';

class ResultListView extends StatelessWidget {
  const ResultListView({super.key, required this.results});

  final List<SolvedModel> results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.resultScreenTitle),
      body: ResultListBody(results: results),
    );
  }
}
