// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'platform_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IosSecurityOptions _$IosSecurityOptionsFromJson(Map<String, dynamic> json) {
  return _IosSecurityOptions.fromJson(json);
}

/// @nodoc
class _$IosSecurityOptionsTearOff {
  const _$IosSecurityOptionsTearOff();

  _IosSecurityOptions call(
      {required String bundleId,
      String? mobileProvision,
      String? jsonFileName,
      String? cryptographicKey,
      List<String>? listOfPaths}) {
    return _IosSecurityOptions(
      bundleId: bundleId,
      mobileProvision: mobileProvision,
      jsonFileName: jsonFileName,
      cryptographicKey: cryptographicKey,
      listOfPaths: listOfPaths,
    );
  }

  IosSecurityOptions fromJson(Map<String, Object> json) {
    return IosSecurityOptions.fromJson(json);
  }
}

/// @nodoc
const $IosSecurityOptions = _$IosSecurityOptionsTearOff();

/// @nodoc
mixin _$IosSecurityOptions {
  String get bundleId => throw _privateConstructorUsedError;
  String? get mobileProvision => throw _privateConstructorUsedError;
  String? get jsonFileName => throw _privateConstructorUsedError;
  String? get cryptographicKey => throw _privateConstructorUsedError;
  List<String>? get listOfPaths => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IosSecurityOptionsCopyWith<IosSecurityOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IosSecurityOptionsCopyWith<$Res> {
  factory $IosSecurityOptionsCopyWith(
          IosSecurityOptions value, $Res Function(IosSecurityOptions) then) =
      _$IosSecurityOptionsCopyWithImpl<$Res>;
  $Res call(
      {String bundleId,
      String? mobileProvision,
      String? jsonFileName,
      String? cryptographicKey,
      List<String>? listOfPaths});
}

/// @nodoc
class _$IosSecurityOptionsCopyWithImpl<$Res>
    implements $IosSecurityOptionsCopyWith<$Res> {
  _$IosSecurityOptionsCopyWithImpl(this._value, this._then);

  final IosSecurityOptions _value;
  // ignore: unused_field
  final $Res Function(IosSecurityOptions) _then;

  @override
  $Res call({
    Object? bundleId = freezed,
    Object? mobileProvision = freezed,
    Object? jsonFileName = freezed,
    Object? cryptographicKey = freezed,
    Object? listOfPaths = freezed,
  }) {
    return _then(_value.copyWith(
      bundleId: bundleId == freezed
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String,
      mobileProvision: mobileProvision == freezed
          ? _value.mobileProvision
          : mobileProvision // ignore: cast_nullable_to_non_nullable
              as String?,
      jsonFileName: jsonFileName == freezed
          ? _value.jsonFileName
          : jsonFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      cryptographicKey: cryptographicKey == freezed
          ? _value.cryptographicKey
          : cryptographicKey // ignore: cast_nullable_to_non_nullable
              as String?,
      listOfPaths: listOfPaths == freezed
          ? _value.listOfPaths
          : listOfPaths // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$IosSecurityOptionsCopyWith<$Res>
    implements $IosSecurityOptionsCopyWith<$Res> {
  factory _$IosSecurityOptionsCopyWith(
          _IosSecurityOptions value, $Res Function(_IosSecurityOptions) then) =
      __$IosSecurityOptionsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String bundleId,
      String? mobileProvision,
      String? jsonFileName,
      String? cryptographicKey,
      List<String>? listOfPaths});
}

/// @nodoc
class __$IosSecurityOptionsCopyWithImpl<$Res>
    extends _$IosSecurityOptionsCopyWithImpl<$Res>
    implements _$IosSecurityOptionsCopyWith<$Res> {
  __$IosSecurityOptionsCopyWithImpl(
      _IosSecurityOptions _value, $Res Function(_IosSecurityOptions) _then)
      : super(_value, (v) => _then(v as _IosSecurityOptions));

  @override
  _IosSecurityOptions get _value => super._value as _IosSecurityOptions;

  @override
  $Res call({
    Object? bundleId = freezed,
    Object? mobileProvision = freezed,
    Object? jsonFileName = freezed,
    Object? cryptographicKey = freezed,
    Object? listOfPaths = freezed,
  }) {
    return _then(_IosSecurityOptions(
      bundleId: bundleId == freezed
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String,
      mobileProvision: mobileProvision == freezed
          ? _value.mobileProvision
          : mobileProvision // ignore: cast_nullable_to_non_nullable
              as String?,
      jsonFileName: jsonFileName == freezed
          ? _value.jsonFileName
          : jsonFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      cryptographicKey: cryptographicKey == freezed
          ? _value.cryptographicKey
          : cryptographicKey // ignore: cast_nullable_to_non_nullable
              as String?,
      listOfPaths: listOfPaths == freezed
          ? _value.listOfPaths
          : listOfPaths // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_IosSecurityOptions implements _IosSecurityOptions {
  _$_IosSecurityOptions(
      {required this.bundleId,
      this.mobileProvision,
      this.jsonFileName,
      this.cryptographicKey,
      this.listOfPaths});

  factory _$_IosSecurityOptions.fromJson(Map<String, dynamic> json) =>
      _$_$_IosSecurityOptionsFromJson(json);

  @override
  final String bundleId;
  @override
  final String? mobileProvision;
  @override
  final String? jsonFileName;
  @override
  final String? cryptographicKey;
  @override
  final List<String>? listOfPaths;

  @override
  String toString() {
    return 'IosSecurityOptions(bundleId: $bundleId, mobileProvision: $mobileProvision, jsonFileName: $jsonFileName, cryptographicKey: $cryptographicKey, listOfPaths: $listOfPaths)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _IosSecurityOptions &&
            (identical(other.bundleId, bundleId) ||
                const DeepCollectionEquality()
                    .equals(other.bundleId, bundleId)) &&
            (identical(other.mobileProvision, mobileProvision) ||
                const DeepCollectionEquality()
                    .equals(other.mobileProvision, mobileProvision)) &&
            (identical(other.jsonFileName, jsonFileName) ||
                const DeepCollectionEquality()
                    .equals(other.jsonFileName, jsonFileName)) &&
            (identical(other.cryptographicKey, cryptographicKey) ||
                const DeepCollectionEquality()
                    .equals(other.cryptographicKey, cryptographicKey)) &&
            (identical(other.listOfPaths, listOfPaths) ||
                const DeepCollectionEquality()
                    .equals(other.listOfPaths, listOfPaths)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bundleId) ^
      const DeepCollectionEquality().hash(mobileProvision) ^
      const DeepCollectionEquality().hash(jsonFileName) ^
      const DeepCollectionEquality().hash(cryptographicKey) ^
      const DeepCollectionEquality().hash(listOfPaths);

  @JsonKey(ignore: true)
  @override
  _$IosSecurityOptionsCopyWith<_IosSecurityOptions> get copyWith =>
      __$IosSecurityOptionsCopyWithImpl<_IosSecurityOptions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_IosSecurityOptionsToJson(this);
  }
}

abstract class _IosSecurityOptions implements IosSecurityOptions {
  factory _IosSecurityOptions(
      {required String bundleId,
      String? mobileProvision,
      String? jsonFileName,
      String? cryptographicKey,
      List<String>? listOfPaths}) = _$_IosSecurityOptions;

  factory _IosSecurityOptions.fromJson(Map<String, dynamic> json) =
      _$_IosSecurityOptions.fromJson;

  @override
  String get bundleId => throw _privateConstructorUsedError;
  @override
  String? get mobileProvision => throw _privateConstructorUsedError;
  @override
  String? get jsonFileName => throw _privateConstructorUsedError;
  @override
  String? get cryptographicKey => throw _privateConstructorUsedError;
  @override
  List<String>? get listOfPaths => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$IosSecurityOptionsCopyWith<_IosSecurityOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

AndroidSecurityOptions _$AndroidSecurityOptionsFromJson(
    Map<String, dynamic> json) {
  return _AndroidSecurityOptions.fromJson(json);
}

/// @nodoc
class _$AndroidSecurityOptionsTearOff {
  const _$AndroidSecurityOptionsTearOff();

  _AndroidSecurityOptions call({String? sha1}) {
    return _AndroidSecurityOptions(
      sha1: sha1,
    );
  }

  AndroidSecurityOptions fromJson(Map<String, Object> json) {
    return AndroidSecurityOptions.fromJson(json);
  }
}

/// @nodoc
const $AndroidSecurityOptions = _$AndroidSecurityOptionsTearOff();

/// @nodoc
mixin _$AndroidSecurityOptions {
  String? get sha1 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AndroidSecurityOptionsCopyWith<AndroidSecurityOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidSecurityOptionsCopyWith<$Res> {
  factory $AndroidSecurityOptionsCopyWith(AndroidSecurityOptions value,
          $Res Function(AndroidSecurityOptions) then) =
      _$AndroidSecurityOptionsCopyWithImpl<$Res>;
  $Res call({String? sha1});
}

/// @nodoc
class _$AndroidSecurityOptionsCopyWithImpl<$Res>
    implements $AndroidSecurityOptionsCopyWith<$Res> {
  _$AndroidSecurityOptionsCopyWithImpl(this._value, this._then);

  final AndroidSecurityOptions _value;
  // ignore: unused_field
  final $Res Function(AndroidSecurityOptions) _then;

  @override
  $Res call({
    Object? sha1 = freezed,
  }) {
    return _then(_value.copyWith(
      sha1: sha1 == freezed
          ? _value.sha1
          : sha1 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$AndroidSecurityOptionsCopyWith<$Res>
    implements $AndroidSecurityOptionsCopyWith<$Res> {
  factory _$AndroidSecurityOptionsCopyWith(_AndroidSecurityOptions value,
          $Res Function(_AndroidSecurityOptions) then) =
      __$AndroidSecurityOptionsCopyWithImpl<$Res>;
  @override
  $Res call({String? sha1});
}

/// @nodoc
class __$AndroidSecurityOptionsCopyWithImpl<$Res>
    extends _$AndroidSecurityOptionsCopyWithImpl<$Res>
    implements _$AndroidSecurityOptionsCopyWith<$Res> {
  __$AndroidSecurityOptionsCopyWithImpl(_AndroidSecurityOptions _value,
      $Res Function(_AndroidSecurityOptions) _then)
      : super(_value, (v) => _then(v as _AndroidSecurityOptions));

  @override
  _AndroidSecurityOptions get _value => super._value as _AndroidSecurityOptions;

  @override
  $Res call({
    Object? sha1 = freezed,
  }) {
    return _then(_AndroidSecurityOptions(
      sha1: sha1 == freezed
          ? _value.sha1
          : sha1 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_AndroidSecurityOptions implements _AndroidSecurityOptions {
  _$_AndroidSecurityOptions({this.sha1});

  factory _$_AndroidSecurityOptions.fromJson(Map<String, dynamic> json) =>
      _$_$_AndroidSecurityOptionsFromJson(json);

  @override
  final String? sha1;

  @override
  String toString() {
    return 'AndroidSecurityOptions(sha1: $sha1)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AndroidSecurityOptions &&
            (identical(other.sha1, sha1) ||
                const DeepCollectionEquality().equals(other.sha1, sha1)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(sha1);

  @JsonKey(ignore: true)
  @override
  _$AndroidSecurityOptionsCopyWith<_AndroidSecurityOptions> get copyWith =>
      __$AndroidSecurityOptionsCopyWithImpl<_AndroidSecurityOptions>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AndroidSecurityOptionsToJson(this);
  }
}

abstract class _AndroidSecurityOptions implements AndroidSecurityOptions {
  factory _AndroidSecurityOptions({String? sha1}) = _$_AndroidSecurityOptions;

  factory _AndroidSecurityOptions.fromJson(Map<String, dynamic> json) =
      _$_AndroidSecurityOptions.fromJson;

  @override
  String? get sha1 => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AndroidSecurityOptionsCopyWith<_AndroidSecurityOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
