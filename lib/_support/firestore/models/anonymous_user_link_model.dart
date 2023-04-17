import 'package:json_annotation/json_annotation.dart';

part 'anonymous_user_link_model.g.dart';

@JsonSerializable()
class AnonymousUserLinkModel {
  final List<String> linksTo;

  AnonymousUserLinkModel(this.linksTo);

  factory AnonymousUserLinkModel.fromJson(Map<String, dynamic> json) =>
      _$AnonymousUserLinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnonymousUserLinkModelToJson(this);
}
