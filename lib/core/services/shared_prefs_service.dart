import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> isOnboardingComplete() async {
    return _prefs.getBool('onboarding_complete') ?? false;
  }

  Future<void> setOnboardingComplete() async {
    await _prefs.setBool('onboarding_complete', true);
  }
}