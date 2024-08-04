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
import 'package:auth_flutter/features/auth/presentation/pages/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.signup),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.spacingSmall),
        child: Center(
          child: BlocProvider(
            create: (context) => serviceLocator<SignupBloc>(),
            child: BlocConsumer<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state is SignupFailure) {
                  showSnackbar(context, state.message);
                } else if (state is SignupSuccess) {
                  GoRouter.of(context).pushNamed(RouteConstants.loginRoute);
                }
              },
              builder: (context, state) {
                if (state is SignupLoading) {
                  return const Loader();
                }
                return SingleChildScrollView(
                    child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Icon(
                        Bootstrap.infinity,
                        size: 90,
                      ),
                      const Text(
                        Constants.APP_NAME,
                        style: TextStyle(
                          fontSize: Sizes.fontLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Sizes.sizeBoxHt60,
                      VTextField(
                        hintText: Strings.name,
                        textController: nameController,
                        validator: Utils.nameValidator,
                      ),
                      Sizes.sizeBoxHt14,
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
                      Sizes.sizeBoxHt14,
                      VTextField(
                        hintText: Strings.confirmPassword,
                        textController: confirmPasswordController,
                        validator: _confirmPasswordValidation,
                        obscureText: true,
                      ),
                      Sizes.sizeBoxHt40,
                      VElevatedButton(
                        text: Strings.signup,
                        onPressed: () => _signupPressed(context),
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

  void _signupPressed(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      context.read<SignupBloc>().add(
            SignupRequest(
              name: nameController.text.trim(),
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  String? _confirmPasswordValidation(String? value) {
    if (value == null || value != passwordController.text) {
      return Strings.invalidConfirmPasswordError;
    }

    return null;
  }
}
