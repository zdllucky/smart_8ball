import 'package:json_annotation/json_annotation.dart';

part 'tries_available_model.g.dart';

@JsonSerializable()
class TriesAvailableModel {
  final TriesAvailableResourcesModel resources;

  factory TriesAvailableModel.fromJson(Map<String, dynamic> json) =>
      _$TriesAvailableModelFromJson(json);

  TriesAvailableModel(this.resources);

  Map<String, dynamic> toJson() => _$TriesAvailableModelToJson(this);
}

@JsonSerializable()
class TriesAvailableResourcesModel {
  final int basicTries;

  factory TriesAvailableResourcesModel.fromJson(Map<String, dynamic> json) =>
      _$TriesAvailableResourcesModelFromJson(json);

  TriesAvailableResourcesModel(this.basicTries);

  Map<String, dynamic> toJson() => _$TriesAvailableResourcesModelToJson(this);
}
