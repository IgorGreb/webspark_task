import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_task/components/preview/bloc/preview_bloc.dart';
import 'package:webspark_task/components/preview/view/preview_view.dart';
import 'package:webspark_task/shared/di/injection.dart';
import 'package:webspark_task/shared/models/solved_model.dart';

/// Wires [PreviewBloc] into the tree and feeds it the [solved] model handed
/// over by the Result list through the router `extra`.
class PreviewBlocProvider extends StatelessWidget {
  const PreviewBlocProvider({super.key, required this.solved});

  final SolvedModel solved;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreviewBloc>(
      create: (_) => getIt<PreviewBloc>()..add(PreviewEvent.started(solved)),
      child: const PreviewView(),
    );
  }
}
