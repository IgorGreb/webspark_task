import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_model.freezed.dart';
part 'point_model.g.dart';

@freezed
sealed class PointModel with _$PointModel {
  const factory PointModel({required int x, required int y}) = _PointModel;

  factory PointModel.fromJson(Map<String, dynamic> json) =>
      _$PointModelFromJson(json);
}

extension PointListPathX on List<PointModel> {
  /// Compact path used by the API, e.g. `(0,0)->(0,1)`.
  String toPathString() => map((p) => '(${p.x},${p.y})').join('->');
}
