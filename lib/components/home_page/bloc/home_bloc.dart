import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:webspark_task/core/validators/url_validator.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/repositories/i_url_repository.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._urlRepository) : super(_initialState(_urlRepository)) {
    on<HomeUrlChanged>(_onUrlChanged);
    on<HomeSubmitted>(_onSubmitted);
  }

  final IUrlRepository _urlRepository;

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
        status: HomeStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    HomeSubmitted event,
    Emitter<HomeState> emit,
  ) async {
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

    emit(
      state.copyWith(
        isValid: true,
        failure: null,
        status: HomeStatus.submitting,
      ),
    );

    final result = await _urlRepository.saveUrl(url);

    result.fold(
      (failure) =>
          emit(state.copyWith(failure: failure, status: HomeStatus.failure)),
      (_) => emit(
        state.copyWith(url: url, failure: null, status: HomeStatus.success),
      ),
    );
  }
}
