import 'package:json_annotation/json_annotation.dart';

part 'platform_options.g.dart';

abstract class PlatformSecurityOptions {}

@JsonSerializable()
class IosSecurityOptions extends PlatformSecurityOptions {
  final String? bundleId;
  final String? mobileProvision;

  IosSecurityOptions({this.bundleId, this.mobileProvision});

  factory IosSecurityOptions.fromJson(Map<String, dynamic> json) =>
      _$IosSecurityOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$IosSecurityOptionsToJson(this);
}

@JsonSerializable()
class AndroidSecurityOptions extends PlatformSecurityOptions {
  AndroidSecurityOptions();
  factory AndroidSecurityOptions.fromJson(Map<String, dynamic> json) =>
      _$AndroidSecurityOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidSecurityOptionsToJson(this);
}
