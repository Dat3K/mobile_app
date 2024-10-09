import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import 'app.dart';
import 'core/services/auth_service.dart';
import 'core/services/event_service.dart';
import 'core/api/api_client.dart';
import 'core/models/event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EventImplAdapter());
  await Hive.openBox<Event>('events');
  await Hive.openBox('authBox');

  final getIt = GetIt.instance;

  getIt.registerSingleton<ApiClient>(ApiClient());
  getIt.registerSingleton<AuthService>(AuthService(getIt<ApiClient>()));
  getIt.registerSingleton<EventService>(EventService(getIt<ApiClient>()));

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
