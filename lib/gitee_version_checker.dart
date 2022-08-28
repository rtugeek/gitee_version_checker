import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gitee_version_checker/version.dart';
import 'package:gitee_version_checker/version_parser.dart';
import 'package:once/once.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'new_version_dialog.dart';

class GiteeVersionChecker {
  ///网络请求配置
  static final Dio _dio = Dio(BaseOptions(
    connectTimeout: 15000,
    receiveTimeout: 15000,
  ));
  static String _defaultDownloadPage = "";
  static String _url = "";
  static String _key_daily_task = "b3gvgeyqH3KcC";
  static String currentVersion = "0.0.0";

  /// currentVersion: 版本格式：x.y.z eg:1.0.12
  static setup(String currentVersion,
      {url = "", defaultDownloadPage = "", dailyTaskKey = ""}) {
    _url = url;
    GiteeVersionChecker.currentVersion = currentVersion;
    _defaultDownloadPage = defaultDownloadPage;
    _key_daily_task = dailyTaskKey;
  }

  /// 为空代表没有新版本
  static Future<Version?> fetchNewVersion() async {
    var result = await _get(_url);
    var platform = "win";
    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isMacOS) {
      platform = "mac";
    }
    var versionsJson = result[platform] as List<dynamic>;
    var versionList = versionsJson.map((e) => Version.fromJson(e)).toList();
    versionList.sort((a, b) {
      var bVersion = b.getVersionParser();
      var aVersion = a.getVersionParser();
      if (aVersion > bVersion) return 0;
      if (aVersion < bVersion) return 1;
      return 0;
    });
    var currentVersionParsed = VersionParser.parse(currentVersion);

    var newestVersion = versionList.first;
    if (newestVersion.getVersionParser() > currentVersionParsed)
      return newestVersion;
    return null;
  }

  static checkUpdate({bool silent = true}) async {
    if (!silent) SmartDialog.showLoading(msg: "检测更新中");
    var newVersion = await GiteeVersionChecker.fetchNewVersion();
    if (!silent) SmartDialog.dismiss(status: SmartStatus.loading);
    if (newVersion == null) {
      if (!silent) SmartDialog.showToast("已经是最新版本");
    } else {
      NewVersionDialog.show("检测到新版本-${newVersion.versionName}", newVersion.desc,
          onOkPressed: () {
            var downloadLink =
            newVersion.downloadLink == "" || newVersion.downloadLink == null
                ? _defaultDownloadPage
                : newVersion.downloadLink;
            launchUrl(Uri.parse(downloadLink!),
                mode: LaunchMode.externalApplication);
          }, okString: "去更新");
    }
  }

  static Future _get(String url, [Map<String, dynamic>? params]) async {
    Response response;
    if (params != null) {
      response = await _dio.get(url, queryParameters: params);
    } else {
      response = await _dio.get(url);
    }
    return response.data;
  }

  static checkDaily() {
    Once.runDaily(_key_daily_task, callback: () async {
      checkUpdate();
    });
  }
}
