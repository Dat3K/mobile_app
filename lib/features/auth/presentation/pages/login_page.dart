import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authControllerProvider.notifier).login(
            _emailController.text.trim(),
            _passwordController.text,
          );
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      // Handle errors
      if (next.failure != null) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Authentication Error'),
            description: Text(next.failure!.message),
            action: ShadButton.destructive(
              child: const Text('Try again'),
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
              title: const Text('Welcome back'),
              description:
                  const Text('Enter your credentials to access your account'),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),

                    // Email Field
                    const Text('Email'),
                    const SizedBox(height: 8),
                    ShadInputFormField(
                      controller: _emailController,
                      placeholder: const Text('Enter your email'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const ShadDecoration(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    const Text('Password'),
                    const SizedBox(height: 8),
                    ShadInputFormField(
                      controller: _passwordController,
                      placeholder: const Text('Enter your password'),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _onLogin(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
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
                          label: const Text('Remember me'),
                        ),
                        const Spacer(),
                        ShadButton.ghost(
                          child: const Text('Forgot password?'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Login Button
                    authState.isLoading
                        ? ShadButton(
                            onPressed: null,
                            icon: const CircularProgressIndicator(strokeWidth: 2),
                            child: const Text('Please wait'),
                          )
                        : ShadButton(
                            onPressed: _onLogin,
                            child: const Text('Login'),
                          ),
                    const SizedBox(height: 24),

                    // Button get path state
                    ShadButton(
                      child: const Text('Get path'),
                      onPressed: () {
                        print(authState.user);
                      },
                    ),

                    // Divider
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShadButton.outline(
                          onPressed: () {},
                          icon: const Icon(Icons.facebook),
                        ),
                        const SizedBox(width: 16),
                        ShadButton.outline(
                          onPressed: () {},
                          icon: const Icon(Icons.g_mobiledata),
                        ),
                        const SizedBox(width: 16),
                        ShadButton.outline(
                          onPressed: () {},
                          icon: const Icon(Icons.apple),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        ShadButton.link(
                          child: const Text('Sign up'),
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
