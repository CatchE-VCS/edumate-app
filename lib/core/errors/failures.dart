import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  final int? code;
  
  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });

  factory ServerFailure.fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return const ServerFailure(
          message: 'Bad request. Please check your input.',
          code: 400,
        );
      case 401:
        return const ServerFailure(
          message: 'Unauthorized. Please login again.',
          code: 401,
        );
      case 403:
        return const ServerFailure(
          message: 'Forbidden. You do not have permission to access this resource.',
          code: 403,
        );
      case 404:
        return const ServerFailure(
          message: 'Resource not found.',
          code: 404,
        );
      case 500:
        return const ServerFailure(
          message: 'Internal server error. Please try again later.',
          code: 500,
        );
      case 502:
        return const ServerFailure(
          message: 'Bad gateway. The server is temporarily unavailable.',
          code: 502,
        );
      case 503:
        return const ServerFailure(
          message: 'Service unavailable. Please try again later.',
          code: 503,
        );
      default:
        return ServerFailure(
          message: 'Server error occurred (Code: $statusCode)',
          code: statusCode,
        );
    }
  }
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
  });

  factory NetworkFailure.noConnection() {
    return const NetworkFailure(
      message: 'No internet connection. Please check your network settings.',
      code: -1,
    );
  }

  factory NetworkFailure.timeout() {
    return const NetworkFailure(
      message: 'Request timeout. Please try again.',
      code: -2,
    );
  }

  factory NetworkFailure.unknown() {
    return const NetworkFailure(
      message: 'An unknown network error occurred.',
      code: -3,
    );
  }
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });

  factory CacheFailure.notFound() {
    return const CacheFailure(
      message: 'Data not found in cache.',
      code: 1001,
    );
  }

  factory CacheFailure.expired() {
    return const CacheFailure(
      message: 'Cached data has expired.',
      code: 1002,
    );
  }

  factory CacheFailure.corrupted() {
    return const CacheFailure(
      message: 'Cached data is corrupted.',
      code: 1003,
    );
  }
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });

  factory AuthFailure.invalidCredentials() {
    return const AuthFailure(
      message: 'Invalid email or password.',
      code: 2001,
    );
  }

  factory AuthFailure.userNotFound() {
    return const AuthFailure(
      message: 'User not found.',
      code: 2002,
    );
  }

  factory AuthFailure.emailAlreadyInUse() {
    return const AuthFailure(
      message: 'This email is already registered.',
      code: 2003,
    );
  }

  factory AuthFailure.weakPassword() {
    return const AuthFailure(
      message: 'Password is too weak.',
      code: 2004,
    );
  }

  factory AuthFailure.accountDisabled() {
    return const AuthFailure(
      message: 'This account has been disabled.',
      code: 2005,
    );
  }

  factory AuthFailure.tooManyRequests() {
    return const AuthFailure(
      message: 'Too many requests. Please try again later.',
      code: 2006,
    );
  }

  factory AuthFailure.operationNotAllowed() {
    return const AuthFailure(
      message: 'This operation is not allowed.',
      code: 2007,
    );
  }
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });

  factory ValidationFailure.invalidEmail() {
    return const ValidationFailure(
      message: 'Please enter a valid email address.',
      code: 3001,
    );
  }

  factory ValidationFailure.passwordTooShort() {
    return const ValidationFailure(
      message: 'Password must be at least 8 characters long.',
      code: 3002,
    );
  }

  factory ValidationFailure.requiredField(String fieldName) {
    return ValidationFailure(
      message: '$fieldName is required.',
      code: 3003,
    );
  }

  factory ValidationFailure.invalidFormat(String fieldName) {
    return ValidationFailure(
      message: 'Invalid $fieldName format.',
      code: 3004,
    );
  }
}

/// Permission failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
  });

  factory PermissionFailure.denied(String permission) {
    return PermissionFailure(
      message: '$permission permission denied.',
      code: 4001,
    );
  }

  factory PermissionFailure.permanentlyDenied(String permission) {
    return PermissionFailure(
      message: '$permission permission permanently denied. Please enable it in settings.',
      code: 4002,
    );
  }
}

/// Storage failures
class StorageFailure extends Failure {
  const StorageFailure({
    required super.message,
    super.code,
  });

  factory StorageFailure.insufficientSpace() {
    return const StorageFailure(
      message: 'Insufficient storage space.',
      code: 5001,
    );
  }

  factory StorageFailure.fileNotFound() {
    return const StorageFailure(
      message: 'File not found.',
      code: 5002,
    );
  }

  factory StorageFailure.accessDenied() {
    return const StorageFailure(
      message: 'Access denied to storage.',
      code: 5003,
    );
  }
}

/// General application failures
class AppFailure extends Failure {
  const AppFailure({
    required super.message,
    super.code,
  });

  factory AppFailure.unexpected() {
    return const AppFailure(
      message: 'An unexpected error occurred. Please try again.',
      code: 9999,
    );
  }

  factory AppFailure.maintenance() {
    return const AppFailure(
      message: 'The app is under maintenance. Please try again later.',
      code: 9998,
    );
  }

  factory AppFailure.versionNotSupported() {
    return const AppFailure(
      message: 'This app version is no longer supported. Please update.',
      code: 9997,
    );
  }
}