// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solved_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SolvedModel {

 String get id; List<String> get field; PointModel get start; PointModel get end; List<PointModel> get steps;
/// Create a copy of SolvedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SolvedModelCopyWith<SolvedModel> get copyWith => _$SolvedModelCopyWithImpl<SolvedModel>(this as SolvedModel, _$identity);

  /// Serializes this SolvedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SolvedModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.field, field)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&const DeepCollectionEquality().equals(other.steps, steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(field),start,end,const DeepCollectionEquality().hash(steps));

@override
String toString() {
  return 'SolvedModel(id: $id, field: $field, start: $start, end: $end, steps: $steps)';
}


}

/// @nodoc
abstract mixin class $SolvedModelCopyWith<$Res>  {
  factory $SolvedModelCopyWith(SolvedModel value, $Res Function(SolvedModel) _then) = _$SolvedModelCopyWithImpl;
@useResult
$Res call({
 String id, List<String> field, PointModel start, PointModel end, List<PointModel> steps
});


$PointModelCopyWith<$Res> get start;$PointModelCopyWith<$Res> get end;

}
/// @nodoc
class _$SolvedModelCopyWithImpl<$Res>
    implements $SolvedModelCopyWith<$Res> {
  _$SolvedModelCopyWithImpl(this._self, this._then);

  final SolvedModel _self;
  final $Res Function(SolvedModel) _then;

/// Create a copy of SolvedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? field = null,Object? start = null,Object? end = null,Object? steps = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as List<String>,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as PointModel,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as PointModel,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<PointModel>,
  ));
}
/// Create a copy of SolvedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointModelCopyWith<$Res> get start {
  
  return $PointModelCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of SolvedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointModelCopyWith<$Res> get end {
  
  return $PointModelCopyWith<$Res>(_self.end, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}


/// Adds pattern-matching-related methods to [SolvedModel].
extension SolvedModelPatterns on SolvedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SolvedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SolvedModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SolvedModel value)  $default,){
final _that = this;
switch (_that) {
case _SolvedModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SolvedModel value)?  $default,){
final _that = this;
switch (_that) {
case _SolvedModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<String> field,  PointModel start,  PointModel end,  List<PointModel> steps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SolvedModel() when $default != null:
return $default(_that.id,_that.field,_that.start,_that.end,_that.steps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<String> field,  PointModel start,  PointModel end,  List<PointModel> steps)  $default,) {final _that = this;
switch (_that) {
case _SolvedModel():
return $default(_that.id,_that.field,_that.start,_that.end,_that.steps);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<String> field,  PointModel start,  PointModel end,  List<PointModel> steps)?  $default,) {final _that = this;
switch (_that) {
case _SolvedModel() when $default != null:
return $default(_that.id,_that.field,_that.start,_that.end,_that.steps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SolvedModel implements SolvedModel {
  const _SolvedModel({required this.id, required final  List<String> field, required this.start, required this.end, required final  List<PointModel> steps}): _field = field,_steps = steps;
  factory _SolvedModel.fromJson(Map<String, dynamic> json) => _$SolvedModelFromJson(json);

@override final  String id;
 final  List<String> _field;
@override List<String> get field {
  if (_field is EqualUnmodifiableListView) return _field;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_field);
}

@override final  PointModel start;
@override final  PointModel end;
 final  List<PointModel> _steps;
@override List<PointModel> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}


/// Create a copy of SolvedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SolvedModelCopyWith<_SolvedModel> get copyWith => __$SolvedModelCopyWithImpl<_SolvedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SolvedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SolvedModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._field, _field)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&const DeepCollectionEquality().equals(other._steps, _steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_field),start,end,const DeepCollectionEquality().hash(_steps));

@override
String toString() {
  return 'SolvedModel(id: $id, field: $field, start: $start, end: $end, steps: $steps)';
}


}

/// @nodoc
abstract mixin class _$SolvedModelCopyWith<$Res> implements $SolvedModelCopyWith<$Res> {
  factory _$SolvedModelCopyWith(_SolvedModel value, $Res Function(_SolvedModel) _then) = __$SolvedModelCopyWithImpl;
@override @useResult
$Res call({
 String id, List<String> field, PointModel start, PointModel end, List<PointModel> steps
});


@override $PointModelCopyWith<$Res> get start;@override $PointModelCopyWith<$Res> get end;

}
/// @nodoc
class __$SolvedModelCopyWithImpl<$Res>
    implements _$SolvedModelCopyWith<$Res> {
  __$SolvedModelCopyWithImpl(this._self, this._then);

  final _SolvedModel _self;
  final $Res Function(_SolvedModel) _then;

/// Create a copy of SolvedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? field = null,Object? start = null,Object? end = null,Object? steps = null,}) {
  return _then(_SolvedModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self._field : field // ignore: cast_nullable_to_non_nullable
as List<String>,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as PointModel,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as PointModel,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<PointModel>,
  ));
}

/// Create a copy of SolvedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointModelCopyWith<$Res> get start {
  
  return $PointModelCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of SolvedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointModelCopyWith<$Res> get end {
  
  return $PointModelCopyWith<$Res>(_self.end, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}

// dart format on
