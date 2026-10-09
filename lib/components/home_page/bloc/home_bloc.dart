import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:webspark_task/core/validators/url_validator.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/models/task_model.dart';
import 'package:webspark_task/shared/repositories/i_path_repository.dart';
import 'package:webspark_task/shared/repositories/i_url_repository.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._urlRepository, this._pathRepository)
    : super(_initialState(_urlRepository)) {
    on<HomeUrlChanged>(_onUrlChanged);
    on<HomeSubmitted>(_onSubmitted);
  }

  final IUrlRepository _urlRepository;
  final IPathRepository _pathRepository;

  static HomeState _initialState(IUrlRepository repository) {
    final result = repository.getUrl();
    final savedUrl = result.fold((_) => null, (url) => url) ?? '';
    if (savedUrl.isEmpty) {
      return const HomeState();
    }
    return HomeState(url: savedUrl, isValid: UrlValidator.isValid(savedUrl));
  }

  void _onUrlChanged(HomeUrlChanged event, Emitter<HomeState> emit) {
    final url = event.url;
    emit(
      state.copyWith(
        url: url,
        isValid: UrlValidator.isValid(url),
        failure: null,

        tasks: null,
        status: HomeStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    HomeSubmitted event,
    Emitter<HomeState> emit,
  ) async {
    // Guard against double-tap / keyboard+button double submit.
    if (state.status == HomeStatus.submitting) return;
    final url = state.url.trim();

    if (!UrlValidator.isValid(url)) {
      emit(
        state.copyWith(
          isValid: false,
          failure: SomeFailure.invalidUrl,
          status: HomeStatus.failure,
        ),
      );
      return;
    }

    // SSRF guard: well-formed but non-public targets never hit the network.
    if (!UrlValidator.isSafeForRequest(url)) {
      emit(
        state.copyWith(
          isValid: false,
          failure: SomeFailure.invalidUrl,
          status: HomeStatus.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isValid: true,
        failure: null,
        tasks: null,
        status: HomeStatus.submitting,
      ),
    );

    // Validate the URL against the real server BEFORE leaving Home:
    // save it, then preload tasks. On any failure we stay on Home
    // with the error (offline/server) + Try Again, instead of
    // navigating to Process and failing there.
    final saved = await _urlRepository.saveUrl(url);
    final saveFailure = saved.fold((failure) => failure, (_) => null);
    if (saveFailure != null) {
      emit(state.copyWith(failure: saveFailure, status: HomeStatus.failure));
      return;
    }

    final tasksResult = await _pathRepository.fetchTasks(url);

    tasksResult.fold(
      (failure) =>
          emit(state.copyWith(failure: failure, status: HomeStatus.failure)),
      (tasks) => emit(
        state.copyWith(
          url: url,
          failure: null,
          tasks: tasks,
          status: HomeStatus.success,
        ),
      ),
    );
  }

  List<TaskModel>? get preloadedTasks => state.tasks;
}
