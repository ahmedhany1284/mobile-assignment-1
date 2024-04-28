import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_assignment_1/core/routes/app_router.dart';
import 'package:mobile_assignment_1/core/utils/cacheHelper.dart';
import 'package:mobile_assignment_1/core/utils/constatns.dart';
import 'package:mobile_assignment_1/features/splash/presentation/views/widgets/fade_text.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    initFadeAnimation();

    navigateTo();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100, // Adjust as needed
          child: ClipOval(
            child: Image.asset(
              'assets/images/splash.jpg',
              fit: BoxFit.cover,
              width: 200, // Adjust as needed
              height: 200, // Adjust as needed
            ),
          ),
        ),
        const SizedBox(height: 20),
        FadeText(fadeAnimation: fadeAnimation),
      ],
    );
  }

  void initFadeAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
  }

  void navigateTo() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        AppConst.token.isEmpty
            ? GoRouter.of(context).go(AppRouter.kLoginView)
            : GoRouter.of(context).go(AppRouter.kHomeView);
      },
    );
  }
}
