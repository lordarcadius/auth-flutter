import 'package:auth_flutter/core/di/init_dependencies.dart';
import 'package:auth_flutter/core/routes/route_constants.dart';
import 'package:auth_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocProvider(
          create: (context) => serviceLocator<AuthBloc>()..add(AuthIsUserLoggedIn()),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoginSuccess) {
                context.goNamed(RouteConstants.homeRoute);
              } else if (state is AuthFailure) {
                context.goNamed(RouteConstants.loginRoute);
              }
            },
            builder: (context, state) {
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
