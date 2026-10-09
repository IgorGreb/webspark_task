import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark_task/shared/models/point_model.dart';

part 'solved_model.freezed.dart';
part 'solved_model.g.dart';

@freezed
sealed class SolvedModel with _$SolvedModel {
  const factory SolvedModel({
    required String id,
    required List<String> field,
    required PointModel start,
    required PointModel end,
    required List<PointModel> steps,
  }) = _SolvedModel;

  factory SolvedModel.fromJson(Map<String, dynamic> json) =>
      _$SolvedModelFromJson(json);
}
