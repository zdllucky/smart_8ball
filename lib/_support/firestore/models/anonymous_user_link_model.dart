import 'package:json_annotation/json_annotation.dart';

part 'anonymous_user_link_model.g.dart';

@JsonSerializable()
class AnonymousUserLinkModel {
  // TODO: Remove obsolete linksTo param
  final Map<String, UserLink> linksTo;

  AnonymousUserLinkModel(this.linksTo);

  AnonymousUserLinkModel.empty() : this({});

  factory AnonymousUserLinkModel.fromJson(Map<String, dynamic> json) =>
      _$AnonymousUserLinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnonymousUserLinkModelToJson(this);
}

@JsonSerializable()
class UserLink {
  @EpochDateTimeConverter()
  final DateTime linkedAt;

  UserLink(this.linkedAt);

  UserLink.empty() : this(DateTime.now());

  factory UserLink.fromJson(Map<String, dynamic> json) =>
      _$UserLinkFromJson(json);

  Map<String, dynamic> toJson() => _$UserLinkToJson(this);
}

class EpochDateTimeConverter implements JsonConverter<DateTime, String> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}
