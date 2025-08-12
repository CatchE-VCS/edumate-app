import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// A comprehensive network service with error handling, retry logic, and caching
class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  final http.Client _client = http.Client();
  final Map<String, dynamic> _cache = {};
  static const Duration _defaultTimeout = Duration(seconds: 30);
  static const int _defaultMaxRetries = 3;

  /// Generic GET request with error handling and retry logic
  Future<NetworkResult<T>> get<T>({
    required String url,
    Map<String, String>? headers,
    Duration timeout = _defaultTimeout,
    int maxRetries = _defaultMaxRetries,
    bool useCache = true,
    T Function(dynamic)? parser,
  }) async {
    // Check cache first
    if (useCache && _cache.containsKey(url)) {
      final cachedData = _cache[url];
      if (cachedData['expiry'].isAfter(DateTime.now())) {
        final data = parser != null ? parser(cachedData['data']) : cachedData['data'] as T;
        return NetworkResult.success(data, isFromCache: true);
      }
    }

    int attempt = 0;
    while (attempt < maxRetries) {
      try {
        final response = await _client
            .get(Uri.parse(url), headers: headers)
            .timeout(timeout);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          final dynamic jsonData = jsonDecode(response.body);
          
          // Cache the response
          if (useCache) {
            _cache[url] = {
              'data': jsonData,
              'expiry': DateTime.now().add(const Duration(minutes: 10)),
            };
          }

          final data = parser != null ? parser(jsonData) : jsonData as T;
          return NetworkResult.success(data);
        } else {
          throw HttpException('HTTP ${response.statusCode}: ${response.reasonPhrase}');
        }
      } on TimeoutException {
        if (attempt == maxRetries - 1) {
          return NetworkResult.failure(
            NetworkError.timeout('Request timed out after ${timeout.inSeconds} seconds'),
          );
        }
      } on SocketException {
        if (attempt == maxRetries - 1) {
          return NetworkResult.failure(
            NetworkError.noConnection('No internet connection available'),
          );
        }
      } on HttpException catch (e) {
        return NetworkResult.failure(
          NetworkError.serverError(e.message),
        );
      } on FormatException {
        return NetworkResult.failure(
          NetworkError.parseError('Failed to parse response data'),
        );
      } catch (e) {
        if (attempt == maxRetries - 1) {
          return NetworkResult.failure(
            NetworkError.unknown('An unexpected error occurred: $e'),
          );
        }
      }

      attempt++;
      if (attempt < maxRetries) {
        // Exponential backoff
        await Future.delayed(Duration(seconds: attempt * 2));
      }
    }

    return NetworkResult.failure(
      NetworkError.unknown('Max retries exceeded'),
    );
  }

  /// Clear cache
  void clearCache() {
    _cache.clear();
  }

  /// Dispose resources
  void dispose() {
    _client.close();
    _cache.clear();
  }
}

/// Network result wrapper
class NetworkResult<T> {
  final T? data;
  final NetworkError? error;
  final bool isSuccess;
  final bool isFromCache;

  const NetworkResult._({
    this.data,
    this.error,
    required this.isSuccess,
    this.isFromCache = false,
  });

  factory NetworkResult.success(T data, {bool isFromCache = false}) {
    return NetworkResult._(
      data: data,
      isSuccess: true,
      isFromCache: isFromCache,
    );
  }

  factory NetworkResult.failure(NetworkError error) {
    return NetworkResult._(
      error: error,
      isSuccess: false,
    );
  }

  /// Execute callback on success
  NetworkResult<T> onSuccess(void Function(T data) callback) {
    if (isSuccess && data != null) {
      callback(data!);
    }
    return this;
  }

  /// Execute callback on error
  NetworkResult<T> onError(void Function(NetworkError error) callback) {
    if (!isSuccess && error != null) {
      callback(error!);
    }
    return this;
  }
}

/// Network error types
class NetworkError {
  final String message;
  final NetworkErrorType type;

  const NetworkError._(this.message, this.type);

  factory NetworkError.timeout(String message) =>
      NetworkError._(message, NetworkErrorType.timeout);

  factory NetworkError.noConnection(String message) =>
      NetworkError._(message, NetworkErrorType.noConnection);

  factory NetworkError.serverError(String message) =>
      NetworkError._(message, NetworkErrorType.serverError);

  factory NetworkError.parseError(String message) =>
      NetworkError._(message, NetworkErrorType.parseError);

  factory NetworkError.unknown(String message) =>
      NetworkError._(message, NetworkErrorType.unknown);

  @override
  String toString() => message;
}

/// Network error types enum
enum NetworkErrorType {
  timeout,
  noConnection,
  serverError, 
  parseError,
  unknown,
}