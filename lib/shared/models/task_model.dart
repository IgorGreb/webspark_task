import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark_task/shared/models/point_model.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
sealed class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required List<String> field,
    required PointModel start,
    required PointModel end,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
