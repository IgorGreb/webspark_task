// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubmitStepModel _$SubmitStepModelFromJson(Map<String, dynamic> json) =>
    _SubmitStepModel(x: json['x'] as String, y: json['y'] as String);

Map<String, dynamic> _$SubmitStepModelToJson(_SubmitStepModel instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};

_SubmitResultModel _$SubmitResultModelFromJson(Map<String, dynamic> json) =>
    _SubmitResultModel(
      steps: (json['steps'] as List<dynamic>)
          .map((e) => SubmitStepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String,
    );

Map<String, dynamic> _$SubmitResultModelToJson(_SubmitResultModel instance) =>
    <String, dynamic>{'steps': instance.steps, 'path': instance.path};

_SubmitRequestModel _$SubmitRequestModelFromJson(Map<String, dynamic> json) =>
    _SubmitRequestModel(
      id: json['id'] as String,
      result: SubmitResultModel.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SubmitRequestModelToJson(_SubmitRequestModel instance) =>
    <String, dynamic>{'id': instance.id, 'result': instance.result};

_SubmitResponseModel _$SubmitResponseModelFromJson(Map<String, dynamic> json) =>
    _SubmitResponseModel(
      id: json['id'] as String,
      correct: json['correct'] as bool,
    );

Map<String, dynamic> _$SubmitResponseModelToJson(
  _SubmitResponseModel instance,
) => <String, dynamic>{'id': instance.id, 'correct': instance.correct};
