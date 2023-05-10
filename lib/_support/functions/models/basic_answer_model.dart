import 'package:json_annotation/json_annotation.dart';

part 'basic_answer_model.g.dart';

@JsonSerializable()
class BasicAnswerModel {
  final String answer;

  BasicAnswerModel(this.answer);

  factory BasicAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$BasicAnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasicAnswerModelToJson(this);
}
