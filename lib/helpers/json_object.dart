import 'package:json_annotation/json_annotation.dart';

part 'json_object.g.dart';

@JsonSerializable()
class JsonObject {
  final String path;
  final String hash;

  JsonObject({required this.path, required this.hash});

  factory JsonObject.fromJson(Map<String, dynamic> json) =>
      _$JsonObjectFromJson(json);
  Map<String, dynamic> toJson() => _$JsonObjectToJson(this);
}
