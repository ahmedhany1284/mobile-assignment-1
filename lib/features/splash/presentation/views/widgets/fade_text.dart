import 'package:flutter/material.dart';

class FadeText extends StatelessWidget {
  const FadeText({
    super.key,
    required this.fadeAnimation,
  });

  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (BuildContext context, _) {
        return FadeTransition(
          opacity: fadeAnimation,
          child: const Text(
            'Enterprise Mobile Application Development',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}