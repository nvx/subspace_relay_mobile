import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'prefs.g.dart';

const kPrefsBroker = 'broker';
const kPrefsRelayId = 'relay_id';

@riverpod
SharedPreferencesAsync prefs(Ref ref) {
  ref.keepAlive();
  return SharedPreferencesAsync();
}
