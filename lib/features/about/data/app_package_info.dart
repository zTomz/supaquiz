import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/utils/resources/supabase.dart';

class AppPackageInfo {
  late final PackageInfo packageInfo;
  late final String changelog;
  late final String newestVersion;

  static final AppPackageInfo _instance = AppPackageInfo._internal();

  factory AppPackageInfo() {
    return _instance;
  }

  AppPackageInfo._internal();

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();

    final appData = await supabase.from('app').select().limit(1).single();

    changelog = appData['changelog'] as String;
    newestVersion = appData['version'] as String;
  }

  bool get appIsUpToDate {
    return packageInfo.version == newestVersion;
  }
}
