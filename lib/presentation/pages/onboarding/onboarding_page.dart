// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../viewmodels/onboarding_viewmodel.dart';
//
// class OnboardingPage extends StatelessWidget {
//   const OnboardingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final onboardingVM = Provider.of<OnboardingViewModel>(context, listen: false);
//
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Welcome to Onboarding'),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 onboardingVM.completeOnboarding();
//                 Navigator.pushReplacementNamed(context, '/home');
//               },
//               child: const Text('Get Started'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:maktabati_app/core/app_colors.dart' show AppColors;
import 'package:provider/provider.dart';
import '../../viewmodels/onboarding_viewmodel.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingVM = Provider.of<OnboardingViewModel>(context, listen: true);

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: onboardingVM.pageController,
            itemCount: onboardingVM.onboardingPages.length,
            onPageChanged: onboardingVM.updatePageIndex,
            itemBuilder: (context, index) {
              return _OnboardingContent(item: onboardingVM.onboardingPages[index]);
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Page Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingVM.onboardingPages.length,
                        (index) => _buildPageIndicator(index, onboardingVM.currentPage),
                  ),
                ),
                const SizedBox(height: 30),

                // Next Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (onboardingVM.currentPage == onboardingVM.onboardingPages.length - 1) {
                        onboardingVM.completeOnboarding();
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        onboardingVM.nextPage();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, // استخدام اللون من AppColors
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      onboardingVM.currentPage == onboardingVM.onboardingPages.length - 1
                          ? 'ابدأ الآن'
                          : 'التالي',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index, int currentPage) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: currentPage == index
            ? AppColors.activeIndicator
            : AppColors.inactiveIndicator,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _OnboardingContent extends StatelessWidget {
  final OnboardingItem item;

  const _OnboardingContent({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundGradientStart,
            AppColors.backgroundGradientEnd
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(item.image, height: 300),
          const SizedBox(height: 40),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              item.description,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textDark.withOpacity(0.8),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}