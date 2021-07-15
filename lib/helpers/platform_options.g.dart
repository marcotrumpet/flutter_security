// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IosSecurityOptions _$IosSecurityOptionsFromJson(Map<String, dynamic> json) {
  return IosSecurityOptions(
    bundleId: json['bundleId'] as String?,
    mobileProvision: json['mobileProvision'] as String?,
  );
}

Map<String, dynamic> _$IosSecurityOptionsToJson(IosSecurityOptions instance) =>
    <String, dynamic>{
      'bundleId': instance.bundleId,
      'mobileProvision': instance.mobileProvision,
    };

AndroidSecurityOptions _$AndroidSecurityOptionsFromJson(
    Map<String, dynamic> json) {
  return AndroidSecurityOptions(
    sha1: json['sha1'] as String?,
  );
}

Map<String, dynamic> _$AndroidSecurityOptionsToJson(
        AndroidSecurityOptions instance) =>
    <String, dynamic>{
      'sha1': instance.sha1,
    };
