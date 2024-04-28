import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_assignment_1/core/models/user_info/user_info.dart';
import 'package:mobile_assignment_1/features/home/home.dart';
import 'package:mobile_assignment_1/features/home/widgets/Update_profile.dart';
import 'package:mobile_assignment_1/features/login/login_screen.dart';
import 'package:mobile_assignment_1/features/register/register_screen.dart';
import 'package:mobile_assignment_1/features/splash/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kHomeView = '/homeView';
  static const kLoginView = '/login';
  static const kRegisterView = '/register';
  static const kProfileView = '/profile';
  static const kEditProfileView = '/editProfile';
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: kSplashView,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (BuildContext context, GoRouterState state) => LoginScreen(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (BuildContext context, GoRouterState state) =>
            RegisterScreen(),
      ),
      GoRoute(
        path: kEditProfileView,
        builder: (BuildContext context, GoRouterState state) =>
            UpdateProfileScreen(),
      ),
    ],
  );
}
