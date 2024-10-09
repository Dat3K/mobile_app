import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/models/user.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../view_models/auth_view_model.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/localization.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final l10n = AppLocalizations.of(context);

    ref.listen<AsyncValue<User?>>(authViewModelProvider, (_, state) {
      state.whenOrNull(
        data: (user) {
          if (user != null) {
            if (user.role == 'student') {
              context.go('/student/events');
            } else if (user.role == 'enterprise') {
              context.go('/enterprise/events');
            }
          }
        },
        error: (error, _) {
          ShadToaster.of(context).show(
            ShadToast.destructive(
              title: const Text('Error'),
              description: const Text('There was a problem with your request'),
              action: ShadButton.outline(
                child: const Text('Try again'),
                onPressed: () => ShadToaster.of(context).hide(),
              ),
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.login)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: l10n.email),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: l10n.password),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).login(
                      emailController.text,
                      passwordController.text,
                    );
              },
              child: Text(l10n.login),
            ),
            TextButton(
              onPressed: () => context.go('/register'),
              child: Text(l10n.register),
            ),
          ],
        ),
      ),
    );
  }
}
