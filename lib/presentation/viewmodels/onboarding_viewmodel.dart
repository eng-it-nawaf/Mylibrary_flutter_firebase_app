import 'package:flutter/foundation.dart';
import 'package:onboarding_app/core/services/shared_prefs_service.dart';

class OnboardingViewModel extends ChangeNotifier {
  final SharedPrefsService _sharedPrefs;
  bool _isOnboardingComplete = false;
  bool _isLoading = false;

  OnboardingViewModel(this._sharedPrefs) {
    _loadOnboardingStatus();
  }

  bool get isOnboardingComplete => _isOnboardingComplete;
  bool get isLoading => _isLoading;

  Future<void> _loadOnboardingStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      _isOnboardingComplete = await _sharedPrefs.isOnboardingComplete();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading onboarding status: $e');
      }
      _isOnboardingComplete = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> completeOnboarding() async {
    await _sharedPrefs.setOnboardingComplete();
    _isOnboardingComplete = true;
    notifyListeners();
  }
}