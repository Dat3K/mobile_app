import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    assert(() {
      _emailController.text = '5a00000g@student.tdtu.edu.vn';
      _passwordController.text = 'AppController_YRXoxijGiTq8rbKMbqM21SQRwaA1!';
      return true;
    }());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authNotifierProvider.notifier).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      // Handle errors
      if (next.failure != null) {
          ShadToaster.of(context).show(
            ShadToast.destructive(
              title: Text('auth.auth_error'.tr()),
              description: Text(next.failure!.message),
              action: ShadButton.destructive(
                child: Text('auth.try_again'.tr()),
                onPressed: () => ShadToaster.of(context).hide(),
              ),
            ),
          );
      }
    });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: ShadCard(
              title: Text('auth.welcome_back'.tr()),
              description: Text('auth.login_description'.tr()),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),

                    // Email Field
                    Text('auth.email'.tr()),
                    const SizedBox(height: 8),
                    ShadInputFormField(
                      controller: _emailController,
                      placeholder: Text('auth.enter_email'.tr()),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const ShadDecoration(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'auth.validation.email_required'.tr();
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'auth.validation.email_invalid'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    Text('auth.password'.tr()),
                    const SizedBox(height: 8),
                    ShadInputFormField(
                      controller: _passwordController,
                      placeholder: Text('auth.enter_password'.tr()),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _onLogin(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'auth.validation.password_required'.tr();
                        }
                        if (value.length < 6) {
                          return 'auth.validation.password_length'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Remember Me & Forgot Password
                    Row(
                      children: [
                        ShadCheckbox(
                          value: false,
                          onChanged: (value) {},
                          label: Text('auth.remember_me'.tr()),
                        ),
                        const Spacer(),
                        // ShadButton.ghost(
                        //   child: Text('auth.forgot_password'.tr()),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Login Button
                    authState.isLoading
                        ? ShadButton(
                            onPressed: null,
                            leading:
                                const CircularProgressIndicator(strokeWidth: 2),
                            child: Text('common.please_wait'.tr()),
                          )
                        : ShadButton(
                            onPressed: _onLogin,
                            child: Text('auth.login'.tr()),
                          ),
                    const SizedBox(height: 24),

                    // Button get path state
                    ShadButton(
                      child: const Text('Get path'),
                      onPressed: () {
                      },
                    ),

                    // Divider
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('common.or'.tr()),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShadButton.outline(
                          onPressed: () {},
                          leading: const Icon(Icons.facebook),
                        ),
                        const SizedBox(width: 16),
                        ShadButton.outline(
                          onPressed: () {},
                          leading: const Icon(Icons.g_mobiledata),
                        ),
                        const SizedBox(width: 16),
                        ShadButton.outline(
                          onPressed: () {},
                          leading: const Icon(Icons.apple),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('auth.dont_have_account'.tr()),
                        ShadButton.link(
                          child: Text('auth.sign_up'.tr()),
                          onPressed: () {
                            // Navigate to register page
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
