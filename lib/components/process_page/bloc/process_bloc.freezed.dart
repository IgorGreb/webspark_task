// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'process_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProcessEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcessEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProcessEvent()';
}


}

/// @nodoc
class $ProcessEventCopyWith<$Res>  {
$ProcessEventCopyWith(ProcessEvent _, $Res Function(ProcessEvent) __);
}


/// Adds pattern-matching-related methods to [ProcessEvent].
extension ProcessEventPatterns on ProcessEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProcessStarted value)?  started,TResult Function( ProcessSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProcessStarted() when started != null:
return started(_that);case ProcessSubmitted() when submitted != null:
return submitted(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProcessStarted value)  started,required TResult Function( ProcessSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case ProcessStarted():
return started(_that);case ProcessSubmitted():
return submitted(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProcessStarted value)?  started,TResult? Function( ProcessSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case ProcessStarted() when started != null:
return started(_that);case ProcessSubmitted() when submitted != null:
return submitted(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProcessStarted() when started != null:
return started();case ProcessSubmitted() when submitted != null:
return submitted();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  submitted,}) {final _that = this;
switch (_that) {
case ProcessStarted():
return started();case ProcessSubmitted():
return submitted();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  submitted,}) {final _that = this;
switch (_that) {
case ProcessStarted() when started != null:
return started();case ProcessSubmitted() when submitted != null:
return submitted();case _:
  return null;

}
}

}

/// @nodoc


class ProcessStarted implements ProcessEvent {
  const ProcessStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcessStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProcessEvent.started()';
}


}




/// @nodoc


class ProcessSubmitted implements ProcessEvent {
  const ProcessSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcessSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProcessEvent.submitted()';
}


}




/// @nodoc
mixin _$ProcessState {

 int get total; int get solved; bool get isSubmitting; bool get isSubmitted; bool get isFetching; bool get isCalculating; SomeFailure? get failure; List<SolvedModel> get results;
/// Create a copy of ProcessState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProcessStateCopyWith<ProcessState> get copyWith => _$ProcessStateCopyWithImpl<ProcessState>(this as ProcessState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcessState&&(identical(other.total, total) || other.total == total)&&(identical(other.solved, solved) || other.solved == solved)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.isFetching, isFetching) || other.isFetching == isFetching)&&(identical(other.isCalculating, isCalculating) || other.isCalculating == isCalculating)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.results, results));
}


@override
int get hashCode => Object.hash(runtimeType,total,solved,isSubmitting,isSubmitted,isFetching,isCalculating,failure,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'ProcessState(total: $total, solved: $solved, isSubmitting: $isSubmitting, isSubmitted: $isSubmitted, isFetching: $isFetching, isCalculating: $isCalculating, failure: $failure, results: $results)';
}


}

/// @nodoc
abstract mixin class $ProcessStateCopyWith<$Res>  {
  factory $ProcessStateCopyWith(ProcessState value, $Res Function(ProcessState) _then) = _$ProcessStateCopyWithImpl;
@useResult
$Res call({
 int total, int solved, bool isSubmitting, bool isSubmitted, bool isFetching, bool isCalculating, SomeFailure? failure, List<SolvedModel> results
});




}
/// @nodoc
class _$ProcessStateCopyWithImpl<$Res>
    implements $ProcessStateCopyWith<$Res> {
  _$ProcessStateCopyWithImpl(this._self, this._then);

  final ProcessState _self;
  final $Res Function(ProcessState) _then;

/// Create a copy of ProcessState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? solved = null,Object? isSubmitting = null,Object? isSubmitted = null,Object? isFetching = null,Object? isCalculating = null,Object? failure = freezed,Object? results = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,solved: null == solved ? _self.solved : solved // ignore: cast_nullable_to_non_nullable
as int,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,isFetching: null == isFetching ? _self.isFetching : isFetching // ignore: cast_nullable_to_non_nullable
as bool,isCalculating: null == isCalculating ? _self.isCalculating : isCalculating // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as SomeFailure?,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<SolvedModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProcessState].
extension ProcessStatePatterns on ProcessState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProcessState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProcessState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProcessState value)  $default,){
final _that = this;
switch (_that) {
case _ProcessState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProcessState value)?  $default,){
final _that = this;
switch (_that) {
case _ProcessState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  int solved,  bool isSubmitting,  bool isSubmitted,  bool isFetching,  bool isCalculating,  SomeFailure? failure,  List<SolvedModel> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProcessState() when $default != null:
return $default(_that.total,_that.solved,_that.isSubmitting,_that.isSubmitted,_that.isFetching,_that.isCalculating,_that.failure,_that.results);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  int solved,  bool isSubmitting,  bool isSubmitted,  bool isFetching,  bool isCalculating,  SomeFailure? failure,  List<SolvedModel> results)  $default,) {final _that = this;
switch (_that) {
case _ProcessState():
return $default(_that.total,_that.solved,_that.isSubmitting,_that.isSubmitted,_that.isFetching,_that.isCalculating,_that.failure,_that.results);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  int solved,  bool isSubmitting,  bool isSubmitted,  bool isFetching,  bool isCalculating,  SomeFailure? failure,  List<SolvedModel> results)?  $default,) {final _that = this;
switch (_that) {
case _ProcessState() when $default != null:
return $default(_that.total,_that.solved,_that.isSubmitting,_that.isSubmitted,_that.isFetching,_that.isCalculating,_that.failure,_that.results);case _:
  return null;

}
}

}

/// @nodoc


class _ProcessState extends ProcessState {
  const _ProcessState({this.total = 0, this.solved = 0, this.isSubmitting = false, this.isSubmitted = false, this.isFetching = false, this.isCalculating = false, this.failure, final  List<SolvedModel> results = const []}): _results = results,super._();
  

@override@JsonKey() final  int total;
@override@JsonKey() final  int solved;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isSubmitted;
@override@JsonKey() final  bool isFetching;
@override@JsonKey() final  bool isCalculating;
@override final  SomeFailure? failure;
 final  List<SolvedModel> _results;
@override@JsonKey() List<SolvedModel> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of ProcessState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProcessStateCopyWith<_ProcessState> get copyWith => __$ProcessStateCopyWithImpl<_ProcessState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProcessState&&(identical(other.total, total) || other.total == total)&&(identical(other.solved, solved) || other.solved == solved)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.isFetching, isFetching) || other.isFetching == isFetching)&&(identical(other.isCalculating, isCalculating) || other.isCalculating == isCalculating)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._results, _results));
}


@override
int get hashCode => Object.hash(runtimeType,total,solved,isSubmitting,isSubmitted,isFetching,isCalculating,failure,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'ProcessState(total: $total, solved: $solved, isSubmitting: $isSubmitting, isSubmitted: $isSubmitted, isFetching: $isFetching, isCalculating: $isCalculating, failure: $failure, results: $results)';
}


}

/// @nodoc
abstract mixin class _$ProcessStateCopyWith<$Res> implements $ProcessStateCopyWith<$Res> {
  factory _$ProcessStateCopyWith(_ProcessState value, $Res Function(_ProcessState) _then) = __$ProcessStateCopyWithImpl;
@override @useResult
$Res call({
 int total, int solved, bool isSubmitting, bool isSubmitted, bool isFetching, bool isCalculating, SomeFailure? failure, List<SolvedModel> results
});




}
/// @nodoc
class __$ProcessStateCopyWithImpl<$Res>
    implements _$ProcessStateCopyWith<$Res> {
  __$ProcessStateCopyWithImpl(this._self, this._then);

  final _ProcessState _self;
  final $Res Function(_ProcessState) _then;

/// Create a copy of ProcessState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? solved = null,Object? isSubmitting = null,Object? isSubmitted = null,Object? isFetching = null,Object? isCalculating = null,Object? failure = freezed,Object? results = null,}) {
  return _then(_ProcessState(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,solved: null == solved ? _self.solved : solved // ignore: cast_nullable_to_non_nullable
as int,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,isFetching: null == isFetching ? _self.isFetching : isFetching // ignore: cast_nullable_to_non_nullable
as bool,isCalculating: null == isCalculating ? _self.isCalculating : isCalculating // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as SomeFailure?,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<SolvedModel>,
  ));
}


}

// dart format on
