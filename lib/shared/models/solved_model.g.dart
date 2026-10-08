// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solved_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SolvedModel _$SolvedModelFromJson(Map<String, dynamic> json) => _SolvedModel(
  id: json['id'] as String,
  field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
  start: PointModel.fromJson(json['start'] as Map<String, dynamic>),
  end: PointModel.fromJson(json['end'] as Map<String, dynamic>),
  steps: (json['steps'] as List<dynamic>)
      .map((e) => PointModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SolvedModelToJson(_SolvedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field': instance.field,
      'start': instance.start,
      'end': instance.end,
      'steps': instance.steps,
    };
