import 'package:gitee_version_checker/version_parser.dart';
// import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

// @JsonSerializable()
class Version {
  String appName;
  String desc;
  DateTime releaseAt;
  String versionName;
  String versionCode;
  String platform;
  String? downloadLink;

  Version({
    required this.appName,
    required this.desc,
    required this.releaseAt,
    required this.versionName,
    required this.versionCode,
    required this.platform,
    this.downloadLink,
  });

  VersionParser getVersionParser() {
    return VersionParser.parse(versionName);
  }

  factory Version.fromJson(Map<String, dynamic> json) =>
      _$VersionFromJson(json);

  Map<String, dynamic> toJson() => _$VersionToJson(this);
}
