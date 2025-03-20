import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      _emailController.text = '58268357@student.tdtu.edu.vn';
      _passwordController.text = 'AppController_Md1pOwuiLghnOJVUgriYILNs6aA1!';
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
            constraints: BoxConstraints(maxWidth: 400.w),
            padding: EdgeInsets.all(24.sp),
            child: ShadCard(
              title: Text('auth.welcome_back'.tr()),
              description: Text('auth.login_description'.tr()),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24.h),

                    // Email Field
                    Text('auth.email'.tr()),
                    SizedBox(height: 8.h),
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
                    SizedBox(height: 16.h),

                    // Password Field
                    Text('auth.password'.tr()),
                    SizedBox(height: 8.h),
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
                    SizedBox(height: 16.h),

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
                    SizedBox(height: 24.h),

                    // Login Button
                    authState.isLoading
                        ? ShadButton(
                            onPressed: null,
                            leading:
                                CircularProgressIndicator(strokeWidth: 2.w),
                            child: Text('common.please_wait'.tr()),
                          )
                        : ShadButton(
                            onPressed: _onLogin,
                            child: Text('auth.login'.tr()),
                          ),
                    SizedBox(height: 24.h),

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
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text('common.or'.tr()),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShadButton.outline(
                          onPressed: () {},
                          leading: Icon(Icons.facebook, size: 20.sp),
                        ),
                        SizedBox(width: 16.w),
                        ShadButton.outline(
                          onPressed: () {},
                          leading: Icon(Icons.g_mobiledata, size: 20.sp),
                        ),
                        SizedBox(width: 16.w),
                        ShadButton.outline(
                          onPressed: () {},
                          leading: Icon(Icons.apple, size: 20.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

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
