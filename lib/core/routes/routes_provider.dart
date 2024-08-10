import 'package:auth_flutter/core/routes/route_constants.dart';
import 'package:auth_flutter/core/utils/router_transition.dart';
import 'package:auth_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_flutter/features/auth/presentation/pages/reset_password_page.dart';
import 'package:auth_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:auth_flutter/features/auth/presentation/pages/signup_page.dart';
import 'package:auth_flutter/features/products/presentation/products_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey(debugLabel: "root");

class RoutesProvider {
  static final GoRouter _router = GoRouter(
    initialLocation: "/login",
    navigatorKey: _rootNavigatorKey,
    routes: [
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
    redirect: (context, state) async {
      // Check if the user is on the Login page
      if (state.fullPath == "/${RouteConstants.loginRoute}" ||
          state.fullPath == "/${RouteConstants.signupRoute}") {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        // Dispatch the event to validate user login status
        authBloc.add(AuthIsUserLoggedIn());

        // Wait for the state to be emitted
        final authState = await authBloc.stream.firstWhere(
            (state) => state is AuthLoginSuccess || state is AuthFailure);
        // User is on the Login page
        if (authState is AuthLoginSuccess) {
          // User is logged in, redirect to Products page
          return RouteConstants.homeRoute;
        }
      }

      // Default case: No redirection
      return null;
    },
  );

  GoRouter get router => _router;
}
