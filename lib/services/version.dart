import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'version.g.dart';

const appName = 'subspace_relay_mobile';

@riverpod
Future<String> appVersion(Ref ref) async {
  final packageInfo = await PackageInfo.fromPlatform();

  ref.keepAlive();

  return '${packageInfo.version}+${packageInfo.buildNumber}';
}
