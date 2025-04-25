import 'package:flutter/material.dart';
import '../../../core/services/shared_prefs_service.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingViewModel extends ChangeNotifier {
  final SharedPrefsService _sharedPrefs;
  final PageController pageController = PageController();
  int _currentPage = 0;
  bool _isOnboardingComplete = false;

  final List<OnboardingItem> onboardingPages = [
    OnboardingItem(
      image: 'assets/onboarding1.png',
      title: 'مرحباً بك في مكتبتنا',
      description: 'استكشف عالمًا من المعرفة مع آلاف الكتب في مختلف المجالات',
    ),
    OnboardingItem(
      image: 'assets/onboarding2.png',
      title: 'نظام إعارة سهل',
      description: 'استعير كتبك المفضلة بسهولة واحتفظ بسجل للإعارات',
    ),
    OnboardingItem(
      image: 'assets/onboarding3.png',
      title: 'ابدأ رحلتك الآن',
      description: 'سجل حسابك وابدأ في استكشاف مكتبتنا الرقمية',
    ),
  ];

  OnboardingViewModel(this._sharedPrefs) {
    _loadOnboardingStatus();
  }

  int get currentPage => _currentPage;
  bool get isOnboardingComplete => _isOnboardingComplete;

  Future<void> _loadOnboardingStatus() async {
    _isOnboardingComplete = await _sharedPrefs.isOnboardingComplete();
    notifyListeners();
  }

  void updatePageIndex(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> completeOnboarding() async {
    await _sharedPrefs.setOnboardingComplete();
    _isOnboardingComplete = true;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}