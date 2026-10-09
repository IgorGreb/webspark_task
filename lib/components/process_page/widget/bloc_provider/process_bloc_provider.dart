import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_task/components/process_page/bloc/process_bloc.dart';
import 'package:webspark_task/components/process_page/view/process_view.dart';
import 'package:webspark_task/shared/di/injection.dart';
import 'package:webspark_task/shared/models/task_model.dart';

class ProcessBlocProvider extends StatelessWidget {
  const ProcessBlocProvider({super.key, this.tasks});

  /// Tasks preloaded by Home; when null the bloc fetches them itself.
  final List<TaskModel>? tasks;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProcessBloc>(
      create: (_) =>
          getIt<ProcessBloc>()..add(ProcessEvent.started(tasks: tasks)),
      child: const ProcessView(),
    );
  }
}
