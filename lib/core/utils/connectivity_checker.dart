import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/error/error_handler.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_checker.g.dart';

/// Service to check and monitor network connectivity
class ConnectivityService {
  final Connectivity _connectivity;
  final LoggerService _logger;
  final ErrorHandler _errorHandler;
  StreamSubscription? _connectivitySubscription;
  
  bool _isConnected = true;
  
  ConnectivityService({
    required Connectivity connectivity,
    required LoggerService logger,
    required ErrorHandler errorHandler,
  })  : _connectivity = connectivity,
        _logger = logger,
        _errorHandler = errorHandler;

  /// Initialize the connectivity service and start monitoring
  Future<void> init() async {
    _logger.i('Initializing connectivity service');
    
    // Check initial connection status
    await checkConnectivity();
    
    // Monitor connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      final wasConnected = _isConnected;
      _isConnected = result != ConnectivityResult.none;
      
      if (wasConnected && !_isConnected) {
        _logger.w('Network connection lost');
        // Report disconnection
        _errorHandler.handleError(
          ConnectionFailure.noInternet(),
        );
      } else if (!wasConnected && _isConnected) {
        _logger.i('Network connection restored');
        // Clear connection error
        _errorHandler.clearError();
      }
    });
  }

  /// Check the current connectivity status
  Future<bool> checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _isConnected = result != ConnectivityResult.none;
      
      if (!_isConnected) {
        _logger.w('No network connection');
      }
      
      return _isConnected;
    } catch (e) {
      _logger.e('Error checking connectivity: $e');
      _isConnected = false;
      return false;
    }
  }

  /// Returns current connectivity status
  bool get isConnected => _isConnected;
  
  /// Dispose the connectivity service
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }
}

/// Provider for the ConnectivityService
@riverpod
ConnectivityService connectivityService(Ref ref) {
  final logger = ref.watch(loggerServiceProvider);
  final errorHandler = ref.watch(errorHandlerProvider.notifier);
  
  final service = ConnectivityService(
    connectivity: Connectivity(),
    logger: logger,
    errorHandler: errorHandler,
  );
  
  // Initialize the service
  Future.microtask(() => service.init());
  
  // Dispose on container dispose
  ref.onDispose(() => service.dispose());
  
  return service;
}

/// Provider to check if the device is currently connected to the internet
@riverpod
bool isConnected(Ref ref) {
  return ref.watch(connectivityServiceProvider).isConnected;
} 