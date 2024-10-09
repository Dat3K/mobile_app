import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/models/user.dart';
import '../view_models/auth_view_model.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/localization.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final fullNameController = TextEditingController();
    String selectedRole = 'student';
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: $error')),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.register)),
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
            const SizedBox(height: 16),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: l10n.fullName),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedRole,
              items: ['student', 'enterprise'].map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role == 'student' ? l10n.student : l10n.enterprise),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedRole = newValue;
                }
              },
              decoration: InputDecoration(labelText: l10n.role),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).register(
                      emailController.text,
                      passwordController.text,
                      fullNameController.text,
                      selectedRole,
                    );
              },
              child: Text(l10n.register),
            ),
            TextButton(
              onPressed: () => context.go('/login'),
              child: Text(l10n.login),
            ),
          ],
        ),
      ),
    );
  }
}