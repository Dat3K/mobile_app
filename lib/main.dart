import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_app/app.dart';
import 'package:mobile_app/features/auth/data/models/session_model.dart';
import 'package:mobile_app/features/auth/data/models/user_model.dart';
import 'package:mobile_app/features/auth/data/models/user_role_model.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_dependencies.dart';

void main() async {
  // Ensure proper binding initialization
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Register Adapters with error handling
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserRoleModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SessionModelAdapter());
    }

    // Open Hive Boxes with error handling
    final userBox = await Hive.openBox('user');
    final sessionBox = await Hive.openBox('session');

    // Set up error handlers for async errors
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };

    runApp(
      ProviderScope(
        overrides: [
          userBoxProvider.overrideWithValue(userBox),
          sessionBoxProvider.overrideWithValue(sessionBox),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Error during initialization: $e\n$stackTrace');
    rethrow;
  }
}
