// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
_$_IosSecurityOptions _$_$_IosSecurityOptionsFromJson(
    Map<String, dynamic> json) {
  return _$_IosSecurityOptions(
    bundleId: json['bundleId'] as String,
    mobileProvision: json['mobileProvision'] as String?,
    jsonFileName: json['jsonFileName'] as String?,
    cryptographicKey: json['cryptographicKey'] as String?,
    listOfPaths: (json['listOfPaths'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$_$_IosSecurityOptionsToJson(
        _$_IosSecurityOptions instance) =>
    <String, dynamic>{
      'bundleId': instance.bundleId,
      'mobileProvision': instance.mobileProvision,
      'jsonFileName': instance.jsonFileName,
      'cryptographicKey': instance.cryptographicKey,
      'listOfPaths': instance.listOfPaths,
    };

_$_AndroidSecurityOptions _$_$_AndroidSecurityOptionsFromJson(
    Map<String, dynamic> json) {
  return _$_AndroidSecurityOptions(
    sha1: json['sha1'] as String?,
  );
}

Map<String, dynamic> _$_$_AndroidSecurityOptionsToJson(
        _$_AndroidSecurityOptions instance) =>
    <String, dynamic>{
      'sha1': instance.sha1,
    };
