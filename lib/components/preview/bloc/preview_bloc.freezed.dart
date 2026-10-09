// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preview_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PreviewEvent {

 SolvedModel get solved;
/// Create a copy of PreviewEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreviewEventCopyWith<PreviewEvent> get copyWith => _$PreviewEventCopyWithImpl<PreviewEvent>(this as PreviewEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreviewEvent&&(identical(other.solved, solved) || other.solved == solved));
}


@override
int get hashCode => Object.hash(runtimeType,solved);

@override
String toString() {
  return 'PreviewEvent(solved: $solved)';
}


}

/// @nodoc
abstract mixin class $PreviewEventCopyWith<$Res>  {
  factory $PreviewEventCopyWith(PreviewEvent value, $Res Function(PreviewEvent) _then) = _$PreviewEventCopyWithImpl;
@useResult
$Res call({
 SolvedModel solved
});


$SolvedModelCopyWith<$Res> get solved;

}
/// @nodoc
class _$PreviewEventCopyWithImpl<$Res>
    implements $PreviewEventCopyWith<$Res> {
  _$PreviewEventCopyWithImpl(this._self, this._then);

  final PreviewEvent _self;
  final $Res Function(PreviewEvent) _then;

/// Create a copy of PreviewEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? solved = null,}) {
  return _then(_self.copyWith(
solved: null == solved ? _self.solved : solved // ignore: cast_nullable_to_non_nullable
as SolvedModel,
  ));
}
/// Create a copy of PreviewEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SolvedModelCopyWith<$Res> get solved {
  
  return $SolvedModelCopyWith<$Res>(_self.solved, (value) {
    return _then(_self.copyWith(solved: value));
  });
}
}


/// Adds pattern-matching-related methods to [PreviewEvent].
extension PreviewEventPatterns on PreviewEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PreviewStarted value)?  started,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PreviewStarted() when started != null:
return started(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PreviewStarted value)  started,}){
final _that = this;
switch (_that) {
case PreviewStarted():
return started(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PreviewStarted value)?  started,}){
final _that = this;
switch (_that) {
case PreviewStarted() when started != null:
return started(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SolvedModel solved)?  started,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PreviewStarted() when started != null:
return started(_that.solved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SolvedModel solved)  started,}) {final _that = this;
switch (_that) {
case PreviewStarted():
return started(_that.solved);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SolvedModel solved)?  started,}) {final _that = this;
switch (_that) {
case PreviewStarted() when started != null:
return started(_that.solved);case _:
  return null;

}
}

}

/// @nodoc


class PreviewStarted implements PreviewEvent {
  const PreviewStarted(this.solved);
  

@override final  SolvedModel solved;

/// Create a copy of PreviewEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreviewStartedCopyWith<PreviewStarted> get copyWith => _$PreviewStartedCopyWithImpl<PreviewStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreviewStarted&&(identical(other.solved, solved) || other.solved == solved));
}


@override
int get hashCode => Object.hash(runtimeType,solved);

@override
String toString() {
  return 'PreviewEvent.started(solved: $solved)';
}


}

/// @nodoc
abstract mixin class $PreviewStartedCopyWith<$Res> implements $PreviewEventCopyWith<$Res> {
  factory $PreviewStartedCopyWith(PreviewStarted value, $Res Function(PreviewStarted) _then) = _$PreviewStartedCopyWithImpl;
@override @useResult
$Res call({
 SolvedModel solved
});


@override $SolvedModelCopyWith<$Res> get solved;

}
/// @nodoc
class _$PreviewStartedCopyWithImpl<$Res>
    implements $PreviewStartedCopyWith<$Res> {
  _$PreviewStartedCopyWithImpl(this._self, this._then);

  final PreviewStarted _self;
  final $Res Function(PreviewStarted) _then;

/// Create a copy of PreviewEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? solved = null,}) {
  return _then(PreviewStarted(
null == solved ? _self.solved : solved // ignore: cast_nullable_to_non_nullable
as SolvedModel,
  ));
}

/// Create a copy of PreviewEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SolvedModelCopyWith<$Res> get solved {
  
  return $SolvedModelCopyWith<$Res>(_self.solved, (value) {
    return _then(_self.copyWith(solved: value));
  });
}
}

/// @nodoc
mixin _$PreviewState {

 SolvedModel? get solved;
/// Create a copy of PreviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreviewStateCopyWith<PreviewState> get copyWith => _$PreviewStateCopyWithImpl<PreviewState>(this as PreviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreviewState&&(identical(other.solved, solved) || other.solved == solved));
}


@override
int get hashCode => Object.hash(runtimeType,solved);

@override
String toString() {
  return 'PreviewState(solved: $solved)';
}


}

/// @nodoc
abstract mixin class $PreviewStateCopyWith<$Res>  {
  factory $PreviewStateCopyWith(PreviewState value, $Res Function(PreviewState) _then) = _$PreviewStateCopyWithImpl;
@useResult
$Res call({
 SolvedModel? solved
});


$SolvedModelCopyWith<$Res>? get solved;

}
/// @nodoc
class _$PreviewStateCopyWithImpl<$Res>
    implements $PreviewStateCopyWith<$Res> {
  _$PreviewStateCopyWithImpl(this._self, this._then);

  final PreviewState _self;
  final $Res Function(PreviewState) _then;

/// Create a copy of PreviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? solved = freezed,}) {
  return _then(_self.copyWith(
solved: freezed == solved ? _self.solved : solved // ignore: cast_nullable_to_non_nullable
as SolvedModel?,
  ));
}
/// Create a copy of PreviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SolvedModelCopyWith<$Res>? get solved {
    if (_self.solved == null) {
    return null;
  }

  return $SolvedModelCopyWith<$Res>(_self.solved!, (value) {
    return _then(_self.copyWith(solved: value));
  });
}
}


/// Adds pattern-matching-related methods to [PreviewState].
extension PreviewStatePatterns on PreviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreviewState value)  $default,){
final _that = this;
switch (_that) {
case _PreviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreviewState value)?  $default,){
final _that = this;
switch (_that) {
case _PreviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SolvedModel? solved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreviewState() when $default != null:
return $default(_that.solved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SolvedModel? solved)  $default,) {final _that = this;
switch (_that) {
case _PreviewState():
return $default(_that.solved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SolvedModel? solved)?  $default,) {final _that = this;
switch (_that) {
case _PreviewState() when $default != null:
return $default(_that.solved);case _:
  return null;

}
}

}

/// @nodoc


class _PreviewState extends PreviewState {
  const _PreviewState({this.solved}): super._();
  

@override final  SolvedModel? solved;

/// Create a copy of PreviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreviewStateCopyWith<_PreviewState> get copyWith => __$PreviewStateCopyWithImpl<_PreviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreviewState&&(identical(other.solved, solved) || other.solved == solved));
}


@override
int get hashCode => Object.hash(runtimeType,solved);

@override
String toString() {
  return 'PreviewState(solved: $solved)';
}


}

/// @nodoc
abstract mixin class _$PreviewStateCopyWith<$Res> implements $PreviewStateCopyWith<$Res> {
  factory _$PreviewStateCopyWith(_PreviewState value, $Res Function(_PreviewState) _then) = __$PreviewStateCopyWithImpl;
@override @useResult
$Res call({
 SolvedModel? solved
});


@override $SolvedModelCopyWith<$Res>? get solved;

}
/// @nodoc
class __$PreviewStateCopyWithImpl<$Res>
    implements _$PreviewStateCopyWith<$Res> {
  __$PreviewStateCopyWithImpl(this._self, this._then);

  final _PreviewState _self;
  final $Res Function(_PreviewState) _then;

/// Create a copy of PreviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? solved = freezed,}) {
  return _then(_PreviewState(
solved: freezed == solved ? _self.solved : solved // ignore: cast_nullable_to_non_nullable
as SolvedModel?,
  ));
}

/// Create a copy of PreviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SolvedModelCopyWith<$Res>? get solved {
    if (_self.solved == null) {
    return null;
  }

  return $SolvedModelCopyWith<$Res>(_self.solved!, (value) {
    return _then(_self.copyWith(solved: value));
  });
}
}

// dart format on
