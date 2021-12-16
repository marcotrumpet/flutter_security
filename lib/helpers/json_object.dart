import 'package:json_annotation/json_annotation.dart';

part 'json_object.g.dart';

@JsonSerializable()

/// [JsonObject] rapresents the map saved and encrypted.
///
/// It's based on what the [encryption script](https://github.com/ziomarco/mobile-security-hashgenerator) gives you back.
///
/// [path] is the path relative to main bundle of the analyzed file.
///
/// [hash] is the MD5 of the file corresponding to [path].
class JsonObject {
  final String path;
  final String hash;

  JsonObject({required this.path, required this.hash});

  factory JsonObject.fromJson(Map<String, dynamic> json) =>
      _$JsonObjectFromJson(json);
  Map<String, dynamic> toJson() => _$JsonObjectToJson(this);
}
