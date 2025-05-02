import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/core/services/navigation_service.dart';
import 'package:mobile_app/core/widgets/error_display.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg

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
    final theme = ShadTheme.of(context); 

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
          child: Container(
            constraints: BoxConstraints(maxWidth: 400.w),
            child: ShadCard(
              title: Text(
                'auth.welcome_back'.tr(),
                style: theme.textTheme.h4,
              ),
              description: Text(
                'auth.login_description'.tr(),
                style:
                    theme.textTheme.muted,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24.h),

                    // Email Field
                    ShadInputFormField(
                      controller: _emailController,
                      label: Text('auth.email'.tr()), // Sử dụng label từ Shadcn
                      placeholder: Text('auth.enter_email'.tr()),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
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
                    ShadInputFormField(
                      controller: _passwordController,
                      label:
                          Text('auth.password'.tr()), // Sử dụng label từ Shadcn
                      placeholder: Text('auth.enter_password'.tr()),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _onLogin(),
                      obscureText: true, // Ẩn mật khẩu
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShadCheckbox(
                          value: false, // Cần quản lý state này
                          onChanged: (value) {
                            // TODO: Implement remember me logic
                          },
                          label: Text('auth.remember_me'.tr()),
                        ),
                        // ShadButton.link(
                        //   text('auth.forgot_password'.tr()),
                        //   onPressed: () {
                        //     // TODO: Implement forgot password navigation
                        //   },
                        // ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Display error if there is one
                    if (authState.failure != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: InlineErrorDisplay(
                          failure: authState.failure!,
                          onRetry: _onLogin,
                        ),
                      ),

                    // Login Button
                    authState.isLoading
                        ? ShadButton(
                            onPressed: null,
                            leading: SizedBox(
                              width: 16.w,
                              height: 16.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.w,
                                color: theme.colorScheme.primaryForeground,
                              ),
                            ),
                            child: Text('common.please_wait'.tr()),
                          )
                        : ShadButton(
                            onPressed: _onLogin,
                            child: Text('auth.login'.tr()),
                          ),
                    SizedBox(height: 24.h),

                    // Divider
                    Row(
                      children: [
                        const Expanded(child: ShadSeparator.horizontal()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'common.or'.tr(),
                            style: theme.textTheme
                                .muted,
                          ),
                        ),
                        const Expanded(child: ShadSeparator.horizontal()),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'auth.dont_have_account'.tr(),
                          style: theme.textTheme
                              .muted,
                        ),
                        ShadButton.link(
                          child: Text('auth.sign_up'.tr()),
                          onPressed: () {
                            ref
                                .read(navigationServiceProvider)
                                .push(RoutePaths.register);
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
