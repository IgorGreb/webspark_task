import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark_task/shared/models/point_model.dart';

part 'submit_model.freezed.dart';
part 'submit_model.g.dart';

/// Single step of the POST body.
///
/// The API expects string coordinates here: `{"x": "0", "y": "0"}`.
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

  /// Builds the result from solved points, formatting `path` as
  /// `(x,y)->...` without spaces.
  factory SubmitResultModel.fromPoints(List<PointModel> points) {
    return SubmitResultModel(
      steps: points.map(SubmitStepModel.fromPoint).toList(),
      path: points.toPathString(),
    );
  }
}

/// POST body item: `{"id": ..., "result": {"steps": [...], "path": ...}}`.
@freezed
sealed class SubmitRequestModel with _$SubmitRequestModel {
  const factory SubmitRequestModel({
    required String id,
    required SubmitResultModel result,
  }) = _SubmitRequestModel;

  factory SubmitRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitRequestModelFromJson(json);
}
