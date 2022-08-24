// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
      appName: json['appName'] as String,
      desc: json['desc'] as String,
      releaseAt: DateTime.parse(json['releaseAt'] as String),
      versionName: json['versionName'] as String,
      versionCode: json['versionCode'] as String,
      platform: json['platform'] as String,
      downloadLink: json['downloadLink'] as String?,
    );

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'appName': instance.appName,
      'desc': instance.desc,
      'releaseAt': instance.releaseAt.toIso8601String(),
      'versionName': instance.versionName,
      'versionCode': instance.versionCode,
      'platform': instance.platform,
      'downloadLink': instance.downloadLink,
    };
