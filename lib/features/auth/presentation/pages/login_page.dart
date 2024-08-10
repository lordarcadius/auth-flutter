import 'package:auth_flutter/core/di/init_dependencies.dart';
import 'package:auth_flutter/core/routes/route_constants.dart';
import 'package:auth_flutter/core/theme/sizes.dart';
import 'package:auth_flutter/core/utils/show_snackbar.dart';
import 'package:auth_flutter/core/utils/strings.dart';
import 'package:auth_flutter/core/utils/utils.dart';
import 'package:auth_flutter/core/utils/constants.dart';
import 'package:auth_flutter/core/widgets/elevated_button.dart';
import 'package:auth_flutter/core/widgets/loader.dart';
import 'package:auth_flutter/core/widgets/textfield.dart';
import 'package:auth_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.spacingSmall),
        child: Center(
          child: BlocProvider(
            create: (context) => serviceLocator<AuthBloc>(),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackbar(context, state.message);
                } else if (state is AuthLoginSuccess) {
                  GoRouter.of(context).pushNamed(RouteConstants.homeRoute);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                }
                return SingleChildScrollView(
                    child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Sizes.sizeBoxHt24,
                      const Icon(
                        Bootstrap.infinity,
                        size: 90,
                      ),
                      const Text(
                        Constants.APP_NAME,
                        style: TextStyle(
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.bold),
                      ),
                      Sizes.sizeBoxHt60,
                      VTextField(
                        hintText: Strings.email,
                        textController: emailController,
                        validator: Utils.emailValidator,
                      ),
                      Sizes.sizeBoxHt14,
                      VTextField(
                        hintText: Strings.password,
                        textController: passwordController,
                        validator: Utils.passwordlValidator,
                        obscureText: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _forgetPasswordPressed,
                          child: const Text(Strings.forgotPassword),
                        ),
                      ),
                      Sizes.sizeBoxHt10,
                      VElevatedButton(
                        text: Strings.login,
                        onPressed: () => _loginPressed(context),
                      ),
                      Sizes.sizeBoxHt40,
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Sizes.sizeBoxWt10,
                          Text(Strings.orContinueWith),
                          Sizes.sizeBoxWt10,
                          Expanded(child: Divider()),
                        ],
                      ),
                      Sizes.sizeBoxHt40,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Brand(Brands.google)),
                          IconButton(
                              onPressed: () {},
                              icon: Brand(
                                Brands.facebook_circled,
                                size: 40,
                              )),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Bootstrap.github,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                      Sizes.sizeBoxHt40,
                      TextButton(
                        onPressed: _signupPressed,
                        child: RichText(
                          text: TextSpan(
                            text: Strings.dontHaveAccount,
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: " ${Strings.signup}",
                                style: const TextStyle().copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              },
            ),
          ),
        ),
      ),
    );
  }

  void _forgetPasswordPressed() {
    GoRouter.of(context).pushNamed(RouteConstants.resetPasswordRoute);
  }

  void _loginPressed(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      context.read<AuthBloc>().add(
            AuthLogin(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  void _signupPressed() {
    GoRouter.of(context).pushNamed(RouteConstants.signupRoute);
  }
}
