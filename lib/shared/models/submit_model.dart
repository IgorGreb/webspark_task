import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark_task/shared/models/point_model.dart';

part 'submit_model.freezed.dart';
part 'submit_model.g.dart';

@freezed
sealed class SubmitStepModel with _$SubmitStepModel {
  const factory SubmitStepModel({required String x, required String y}) =
      _SubmitStepModel;

  factory SubmitStepModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitStepModelFromJson(json);

  factory SubmitStepModel.fromPoint(PointModel point) =>
      SubmitStepModel(x: '${point.x}', y: '${point.y}');
}

@freezed
sealed class SubmitResultModel with _$SubmitResultModel {
  const factory SubmitResultModel({
    required List<SubmitStepModel> steps,
    required String path,
  }) = _SubmitResultModel;

  factory SubmitResultModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitResultModelFromJson(json);

  factory SubmitResultModel.fromPoints(List<PointModel> points) {
    return SubmitResultModel(
      steps: points.map(SubmitStepModel.fromPoint).toList(),
      path: points.toPathString(),
    );
  }
}

@freezed
sealed class SubmitRequestModel with _$SubmitRequestModel {
  const factory SubmitRequestModel({
    required String id,
    required SubmitResultModel result,
  }) = _SubmitRequestModel;

  factory SubmitRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitRequestModelFromJson(json);
}

@freezed
sealed class SubmitResponseModel with _$SubmitResponseModel {
  const factory SubmitResponseModel({
    required String id,
    required bool correct,
  }) = _SubmitResponseModel;

  factory SubmitResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitResponseModelFromJson(json);
}
