import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'utils/app_version.dart';
import 'widgets/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const _site = String.fromEnvironment('BASE_URL');
  const _title = String.fromEnvironment('APP_TITLE');
  const _disableDebugBanner = bool.fromEnvironment('DISABLE_DEBUG_BANNER');
  final _info = await PackageInfo.fromPlatform();
  final _version = AppVersion(_info.version);

  runApp(
    App(
      disableDebugBanner: _disableDebugBanner,
      site: _site,
      title: _title,
      version: _version,
    ),
  );
}
