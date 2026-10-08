import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_task/components/process_page/bloc/process_bloc.dart';
import 'package:webspark_task/components/process_page/view/process_view.dart';
import 'package:webspark_task/shared/di/injection.dart';

class ProcessBlocProvider extends StatelessWidget {
  const ProcessBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProcessBloc>(
      create: (_) => getIt<ProcessBloc>()..add(const ProcessEvent.started()),
      child: const ProcessView(),
    );
  }
}
