import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_task/components/preview/bloc/preview_bloc.dart';
import 'package:webspark_task/components/preview/view/preview_view.dart';
import 'package:webspark_task/shared/di/injection.dart';
import 'package:webspark_task/shared/models/solved_model.dart';

/// Wires [PreviewBloc] into the tree and feeds it the [solved] model handed
/// over by the Result list through the router `extra`.
///
/// When [solved] is `null` (deep link without data) the bloc stays empty and
/// the body renders the "no task selected" state instead of a fake grid.
class PreviewBlocProvider extends StatelessWidget {
  const PreviewBlocProvider({super.key, this.solved});

  final SolvedModel? solved;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreviewBloc>(
      create: (_) {
        final bloc = getIt<PreviewBloc>();
        final model = solved;
        if (model != null) bloc.add(PreviewEvent.started(model));
        return bloc;
      },
      child: const PreviewView(),
    );
  }
}
