import 'package:flutter/material.dart';
import 'package:webspark_task/components/result_list/widget/body/result_list_body.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';

class ResultListView extends StatelessWidget {
  const ResultListView({super.key});

  @override
  Widget build(BuildContext context) {
    final mockPaths = [
      "(0,3)->(0,2)->(0,1)",
      "(1,1)->(2,2)->(3,3)",
      "(0,0)->(1,0)->(2,0)->(3,0)->(4,0)->(5,0)->(6,0)->(7,0)", // mock for ellipsis
    ];
    
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.resultScreenTitle),
      body: ResultListBody(mockPaths: mockPaths),
    );
  }
}
