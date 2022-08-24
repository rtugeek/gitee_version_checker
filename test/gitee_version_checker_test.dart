import 'package:flutter_test/flutter_test.dart';

import 'package:gitee_version_checker/gitee_version_checker.dart';

void main() {
  test('fetchNewVersion', () async{
    var newVersion = await GiteeVersionChecker.fetchNewVersion();
    if(newVersion == null) {
      print("没有新版本");
    }else{
      print("有新版本");
    }
  });
}
