// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubmitStepModel {

 String get x; String get y;
/// Create a copy of SubmitStepModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitStepModelCopyWith<SubmitStepModel> get copyWith => _$SubmitStepModelCopyWithImpl<SubmitStepModel>(this as SubmitStepModel, _$identity);

  /// Serializes this SubmitStepModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitStepModel&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'SubmitStepModel(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $SubmitStepModelCopyWith<$Res>  {
  factory $SubmitStepModelCopyWith(SubmitStepModel value, $Res Function(SubmitStepModel) _then) = _$SubmitStepModelCopyWithImpl;
@useResult
$Res call({
 String x, String y
});




}
/// @nodoc
class _$SubmitStepModelCopyWithImpl<$Res>
    implements $SubmitStepModelCopyWith<$Res> {
  _$SubmitStepModelCopyWithImpl(this._self, this._then);

  final SubmitStepModel _self;
  final $Res Function(SubmitStepModel) _then;

/// Create a copy of SubmitStepModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as String,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubmitStepModel].
extension SubmitStepModelPatterns on SubmitStepModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubmitStepModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmitStepModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubmitStepModel value)  $default,){
final _that = this;
switch (_that) {
case _SubmitStepModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubmitStepModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubmitStepModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String x,  String y)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmitStepModel() when $default != null:
return $default(_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String x,  String y)  $default,) {final _that = this;
switch (_that) {
case _SubmitStepModel():
return $default(_that.x,_that.y);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String x,  String y)?  $default,) {final _that = this;
switch (_that) {
case _SubmitStepModel() when $default != null:
return $default(_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubmitStepModel implements SubmitStepModel {
  const _SubmitStepModel({required this.x, required this.y});
  factory _SubmitStepModel.fromJson(Map<String, dynamic> json) => _$SubmitStepModelFromJson(json);

@override final  String x;
@override final  String y;

/// Create a copy of SubmitStepModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitStepModelCopyWith<_SubmitStepModel> get copyWith => __$SubmitStepModelCopyWithImpl<_SubmitStepModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubmitStepModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitStepModel&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'SubmitStepModel(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$SubmitStepModelCopyWith<$Res> implements $SubmitStepModelCopyWith<$Res> {
  factory _$SubmitStepModelCopyWith(_SubmitStepModel value, $Res Function(_SubmitStepModel) _then) = __$SubmitStepModelCopyWithImpl;
@override @useResult
$Res call({
 String x, String y
});




}
/// @nodoc
class __$SubmitStepModelCopyWithImpl<$Res>
    implements _$SubmitStepModelCopyWith<$Res> {
  __$SubmitStepModelCopyWithImpl(this._self, this._then);

  final _SubmitStepModel _self;
  final $Res Function(_SubmitStepModel) _then;

/// Create a copy of SubmitStepModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,}) {
  return _then(_SubmitStepModel(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as String,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SubmitResultModel {

 List<SubmitStepModel> get steps; String get path;
/// Create a copy of SubmitResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitResultModelCopyWith<SubmitResultModel> get copyWith => _$SubmitResultModelCopyWithImpl<SubmitResultModel>(this as SubmitResultModel, _$identity);

  /// Serializes this SubmitResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitResultModel&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(steps),path);

@override
String toString() {
  return 'SubmitResultModel(steps: $steps, path: $path)';
}


}

/// @nodoc
abstract mixin class $SubmitResultModelCopyWith<$Res>  {
  factory $SubmitResultModelCopyWith(SubmitResultModel value, $Res Function(SubmitResultModel) _then) = _$SubmitResultModelCopyWithImpl;
@useResult
$Res call({
 List<SubmitStepModel> steps, String path
});




}
/// @nodoc
class _$SubmitResultModelCopyWithImpl<$Res>
    implements $SubmitResultModelCopyWith<$Res> {
  _$SubmitResultModelCopyWithImpl(this._self, this._then);

  final SubmitResultModel _self;
  final $Res Function(SubmitResultModel) _then;

/// Create a copy of SubmitResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? steps = null,Object? path = null,}) {
  return _then(_self.copyWith(
steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<SubmitStepModel>,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubmitResultModel].
extension SubmitResultModelPatterns on SubmitResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubmitResultModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmitResultModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubmitResultModel value)  $default,){
final _that = this;
switch (_that) {
case _SubmitResultModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubmitResultModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubmitResultModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SubmitStepModel> steps,  String path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmitResultModel() when $default != null:
return $default(_that.steps,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SubmitStepModel> steps,  String path)  $default,) {final _that = this;
switch (_that) {
case _SubmitResultModel():
return $default(_that.steps,_that.path);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SubmitStepModel> steps,  String path)?  $default,) {final _that = this;
switch (_that) {
case _SubmitResultModel() when $default != null:
return $default(_that.steps,_that.path);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubmitResultModel implements SubmitResultModel {
  const _SubmitResultModel({required final  List<SubmitStepModel> steps, required this.path}): _steps = steps;
  factory _SubmitResultModel.fromJson(Map<String, dynamic> json) => _$SubmitResultModelFromJson(json);

 final  List<SubmitStepModel> _steps;
@override List<SubmitStepModel> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  String path;

/// Create a copy of SubmitResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitResultModelCopyWith<_SubmitResultModel> get copyWith => __$SubmitResultModelCopyWithImpl<_SubmitResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubmitResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitResultModel&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_steps),path);

@override
String toString() {
  return 'SubmitResultModel(steps: $steps, path: $path)';
}


}

/// @nodoc
abstract mixin class _$SubmitResultModelCopyWith<$Res> implements $SubmitResultModelCopyWith<$Res> {
  factory _$SubmitResultModelCopyWith(_SubmitResultModel value, $Res Function(_SubmitResultModel) _then) = __$SubmitResultModelCopyWithImpl;
@override @useResult
$Res call({
 List<SubmitStepModel> steps, String path
});




}
/// @nodoc
class __$SubmitResultModelCopyWithImpl<$Res>
    implements _$SubmitResultModelCopyWith<$Res> {
  __$SubmitResultModelCopyWithImpl(this._self, this._then);

  final _SubmitResultModel _self;
  final $Res Function(_SubmitResultModel) _then;

/// Create a copy of SubmitResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? steps = null,Object? path = null,}) {
  return _then(_SubmitResultModel(
steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<SubmitStepModel>,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SubmitRequestModel {

 String get id; SubmitResultModel get result;
/// Create a copy of SubmitRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitRequestModelCopyWith<SubmitRequestModel> get copyWith => _$SubmitRequestModelCopyWithImpl<SubmitRequestModel>(this as SubmitRequestModel, _$identity);

  /// Serializes this SubmitRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,result);

@override
String toString() {
  return 'SubmitRequestModel(id: $id, result: $result)';
}


}

/// @nodoc
abstract mixin class $SubmitRequestModelCopyWith<$Res>  {
  factory $SubmitRequestModelCopyWith(SubmitRequestModel value, $Res Function(SubmitRequestModel) _then) = _$SubmitRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, SubmitResultModel result
});


$SubmitResultModelCopyWith<$Res> get result;

}
/// @nodoc
class _$SubmitRequestModelCopyWithImpl<$Res>
    implements $SubmitRequestModelCopyWith<$Res> {
  _$SubmitRequestModelCopyWithImpl(this._self, this._then);

  final SubmitRequestModel _self;
  final $Res Function(SubmitRequestModel) _then;

/// Create a copy of SubmitRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? result = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SubmitResultModel,
  ));
}
/// Create a copy of SubmitRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubmitResultModelCopyWith<$Res> get result {
  
  return $SubmitResultModelCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubmitRequestModel].
extension SubmitRequestModelPatterns on SubmitRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubmitRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmitRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubmitRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _SubmitRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubmitRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubmitRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SubmitResultModel result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmitRequestModel() when $default != null:
return $default(_that.id,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SubmitResultModel result)  $default,) {final _that = this;
switch (_that) {
case _SubmitRequestModel():
return $default(_that.id,_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SubmitResultModel result)?  $default,) {final _that = this;
switch (_that) {
case _SubmitRequestModel() when $default != null:
return $default(_that.id,_that.result);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubmitRequestModel implements SubmitRequestModel {
  const _SubmitRequestModel({required this.id, required this.result});
  factory _SubmitRequestModel.fromJson(Map<String, dynamic> json) => _$SubmitRequestModelFromJson(json);

@override final  String id;
@override final  SubmitResultModel result;

/// Create a copy of SubmitRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitRequestModelCopyWith<_SubmitRequestModel> get copyWith => __$SubmitRequestModelCopyWithImpl<_SubmitRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubmitRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,result);

@override
String toString() {
  return 'SubmitRequestModel(id: $id, result: $result)';
}


}

/// @nodoc
abstract mixin class _$SubmitRequestModelCopyWith<$Res> implements $SubmitRequestModelCopyWith<$Res> {
  factory _$SubmitRequestModelCopyWith(_SubmitRequestModel value, $Res Function(_SubmitRequestModel) _then) = __$SubmitRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, SubmitResultModel result
});


@override $SubmitResultModelCopyWith<$Res> get result;

}
/// @nodoc
class __$SubmitRequestModelCopyWithImpl<$Res>
    implements _$SubmitRequestModelCopyWith<$Res> {
  __$SubmitRequestModelCopyWithImpl(this._self, this._then);

  final _SubmitRequestModel _self;
  final $Res Function(_SubmitRequestModel) _then;

/// Create a copy of SubmitRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? result = null,}) {
  return _then(_SubmitRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SubmitResultModel,
  ));
}

/// Create a copy of SubmitRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubmitResultModelCopyWith<$Res> get result {
  
  return $SubmitResultModelCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
