import 'package:auth_flutter/core/routes/route_constants.dart';
import 'package:auth_flutter/core/utils/router_transition.dart';
import 'package:auth_flutter/features/auth/presentation/pages/reset_password_page.dart';
import 'package:auth_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:auth_flutter/features/auth/presentation/pages/signup_page.dart';
import 'package:auth_flutter/features/auth/presentation/pages/splash_page.dart';
import 'package:auth_flutter/features/products/presentation/products_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey(debugLabel: "root");

class RoutesProvider {
  static final GoRouter _router = GoRouter(
    initialLocation: "/${RouteConstants.splashRoute}",
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: "/${RouteConstants.splashRoute}",
        name: RouteConstants.splashRoute,
        pageBuilder: (context, state) {
          return RouterTransition(
            key: state.pageKey,
            child: const SplashPage(),
            forMobile: !kIsWeb,
          );
        },
      ),
      GoRoute(
        path: RouteConstants.homeRoute,
        name: RouteConstants.homeRoute,
        pageBuilder: (context, state) {
          return RouterTransition(
            key: state.pageKey,
            child: const ProductsPage(),
            forMobile: !kIsWeb,
          );
        },
      ),
      GoRoute(
        path: "/${RouteConstants.loginRoute}",
        name: RouteConstants.loginRoute,
        pageBuilder: (context, state) {
          return RouterTransition(
            key: state.pageKey,
            child: const LoginPage(),
            forMobile: !kIsWeb,
          );
        },
      ),
      GoRoute(
        path: "/${RouteConstants.signupRoute}",
        name: RouteConstants.signupRoute,
        pageBuilder: (context, state) {
          return RouterTransition(
            key: state.pageKey,
            child: const SignupPage(),
            forMobile: !kIsWeb,
          );
        },
      ),
      GoRoute(
        path: "/${RouteConstants.resetPasswordRoute}",
        name: RouteConstants.resetPasswordRoute,
        pageBuilder: (context, state) {
          return RouterTransition(
            key: state.pageKey,
            child: const ResetPasswordPage(),
            forMobile: !kIsWeb,
          );
        },
      ),
    ],
    redirect: (context, state) {
      return null;
    },
  );

  GoRouter get router => _router;
}
