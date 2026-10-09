import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:webspark_task/components/preview/widget/grid_cell.dart';
import 'package:webspark_task/shared/models/solved_model.dart';

part 'preview_event.dart';
part 'preview_state.dart';
part 'preview_bloc.freezed.dart';

/// Drives the Preview screen: receives the [SolvedModel] picked on the
/// Result list and exposes everything the grid needs to paint itself.
///
/// The colour mapping (`field + start/end + steps` -> cell role) lives in the
/// state so the widget layer stays a pure renderer.
@injectable
class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  PreviewBloc() : super(const PreviewState()) {
    on<PreviewStarted>(_onStarted);
  }

  void _onStarted(PreviewStarted event, Emitter<PreviewState> emit) {
    emit(PreviewState(solved: event.solved));
  }
}
