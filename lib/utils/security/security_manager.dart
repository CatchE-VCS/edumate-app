import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Advanced security manager for protecting sensitive data and operations
class SecurityManager {
  static final SecurityManager _instance = SecurityManager._internal();
  factory SecurityManager() => _instance;
  SecurityManager._internal();

  final Random _random = Random.secure();
  
  /// Generate a secure random string
  String generateSecureToken({int length = 32}) {
    const chars = 'abcdefghijklmnopqrstuvwXYZABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(length, (index) => chars[_random.nextInt(chars.length)]).join();
  }

  /// Generate a UUID-like identifier
  String generateUUID() {
    final bytes = List<int>.generate(16, (i) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40; // Version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80; // Variant bits
    
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }

  /// Hash a password with salt (simplified implementation)
  String hashPassword(String password, {String? salt}) {
    salt ??= generateSecureToken(length: 16);
    final saltedPassword = password + salt;
    final bytes = utf8.encode(saltedPassword);
    // Using simple hash since crypto package is not available
    final hash = bytes.fold(0, (prev, element) => prev + element).toString();
    return '$salt:$hash';
  }

  /// Verify a password against its hash
  bool verifyPassword(String password, String hashedPassword) {
    try {
      final parts = hashedPassword.split(':');
      if (parts.length != 2) return false;
      
      final salt = parts[0];
      final expectedHash = parts[1];
      
      final saltedPassword = password + salt;
      final bytes = utf8.encode(saltedPassword);
      final hash = bytes.fold(0, (prev, element) => prev + element).toString();
      
      return hash == expectedHash;
    } catch (e) {
      return false;
    }
  }

  /// Validate password strength
  PasswordStrength validatePasswordStrength(String password) {
    if (password.length < 6) {
      return PasswordStrength.veryWeak;
    }
    
    int score = 0;
    
    // Length check
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    
    // Character variety checks
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;
    
    // No common patterns
    if (!password.toLowerCase().contains('password') &&
        !password.toLowerCase().contains('123456') &&
        !password.toLowerCase().contains('qwerty')) {
      score++;
    }
    
    if (score <= 2) return PasswordStrength.weak;
    if (score <= 4) return PasswordStrength.medium;
    if (score <= 6) return PasswordStrength.strong;
    return PasswordStrength.veryStrong;
  }

  /// Sanitize user input to prevent injection attacks
  String sanitizeInput(String input) {
    return input
        .replaceAll(RegExp(r'<script\b[^<]*(?:(?!</script>)<[^<]*)*</script>'), '')
        .replaceAll(RegExp(r'javascript:', caseSensitive: false), '')
        .replaceAll(RegExp(r'on\w+\s*=', caseSensitive: false), '')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('&', '&amp;');
  }

  /// Validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email) && email.length <= 254;
  }

  /// Validate phone number format
  bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    return phoneRegex.hasMatch(phone);
  }

  /// Encrypt sensitive data (simple XOR encryption for demo)
  String encryptData(String data, String key) {
    if (data.isEmpty || key.isEmpty) return data;
    
    final dataBytes = utf8.encode(data);
    final keyBytes = utf8.encode(key);
    final encrypted = <int>[];
    
    for (int i = 0; i < dataBytes.length; i++) {
      encrypted.add(dataBytes[i] ^ keyBytes[i % keyBytes.length]);
    }
    
    return base64.encode(encrypted);
  }

  /// Decrypt sensitive data
  String decryptData(String encryptedData, String key) {
    if (encryptedData.isEmpty || key.isEmpty) return encryptedData;
    
    try {
      final encrypted = base64.decode(encryptedData);
      final keyBytes = utf8.encode(key);
      final decrypted = <int>[];
      
      for (int i = 0; i < encrypted.length; i++) {
        decrypted.add(encrypted[i] ^ keyBytes[i % keyBytes.length]);
      }
      
      return utf8.decode(decrypted);
    } catch (e) {
      return encryptedData;
    }
  }

  /// Rate limiting for API calls
  final Map<String, List<DateTime>> _rateLimitTracker = {};
  
  bool checkRateLimit(String identifier, {int maxRequests = 10, Duration window = const Duration(minutes: 1)}) {
    final now = DateTime.now();
    final windowStart = now.subtract(window);
    
    _rateLimitTracker[identifier] ??= [];
    final requests = _rateLimitTracker[identifier]!;
    
    // Remove old requests
    requests.removeWhere((time) => time.isBefore(windowStart));
    
    if (requests.length >= maxRequests) {
      return false; // Rate limit exceeded
    }
    
    requests.add(now);
    return true;
  }

  /// Clear rate limit data for an identifier
  void clearRateLimit(String identifier) {
    _rateLimitTracker.remove(identifier);
  }

  /// Validate API key format
  bool isValidApiKey(String apiKey) {
    // Basic API key validation - should be at least 32 characters
    return apiKey.length >= 32 && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(apiKey);
  }

  /// Generate secure headers for API requests
  Map<String, String> generateSecureHeaders({
    String? apiKey,
    String? userAgent,
  }) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'X-Request-ID': generateUUID(),
    };

    if (apiKey != null) {
      headers['Authorization'] = 'Bearer $apiKey';
    }

    if (userAgent != null) {
      headers['User-Agent'] = userAgent;
    }

    return headers;
  }

  /// Log security events (in debug mode)
  void logSecurityEvent(String event, {Map<String, dynamic>? details}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      print('SECURITY EVENT [$timestamp]: $event');
      if (details != null) {
        print('Details: $details');
      }
    }
  }

  /// Check for suspicious patterns in user input
  bool containsSuspiciousPatterns(String input) {
    final suspiciousPatterns = [
      RegExp(r'<script', caseSensitive: false),
      RegExp(r'javascript:', caseSensitive: false),
      RegExp(r'eval\s*\(', caseSensitive: false),
      RegExp(r'document\.cookie', caseSensitive: false),
      RegExp(r'window\.location', caseSensitive: false),
      RegExp(r'SELECT.*FROM', caseSensitive: false),
      RegExp(r'DROP\s+TABLE', caseSensitive: false),
      RegExp(r'INSERT\s+INTO', caseSensitive: false),
      RegExp(r'DELETE\s+FROM', caseSensitive: false),
      RegExp(r'UNION\s+SELECT', caseSensitive: false),
    ];

    return suspiciousPatterns.any((pattern) => pattern.hasMatch(input));
  }

  /// Validate file upload security
  bool isSecureFileUpload(String fileName, List<int> fileBytes, {
    List<String> allowedExtensions = const ['.jpg', '.jpeg', '.png', '.gif', '.pdf', '.doc', '.docx'],
    int maxSizeBytes = 10 * 1024 * 1024, // 10MB
  }) {
    // Check file size
    if (fileBytes.length > maxSizeBytes) {
      logSecurityEvent('File upload rejected: Size too large', {
        'fileName': fileName,
        'size': fileBytes.length,
        'maxSize': maxSizeBytes,
      });
      return false;
    }

    // Check file extension
    final extension = fileName.toLowerCase().substring(fileName.lastIndexOf('.'));
    if (!allowedExtensions.contains(extension)) {
      logSecurityEvent('File upload rejected: Invalid extension', {
        'fileName': fileName,
        'extension': extension,
        'allowedExtensions': allowedExtensions,
      });
      return false;
    }

    // Basic file header validation
    if (!_isValidFileHeader(fileBytes, extension)) {
      logSecurityEvent('File upload rejected: Invalid file header', {
        'fileName': fileName,
        'extension': extension,
      });
      return false;
    }

    return true;
  }

  bool _isValidFileHeader(List<int> bytes, String extension) {
    if (bytes.length < 4) return false;

    final header = bytes.take(4).toList();
    
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return header[0] == 0xFF && header[1] == 0xD8;
      case '.png':
        return header[0] == 0x89 && header[1] == 0x50 && header[2] == 0x4E && header[3] == 0x47;
      case '.gif':
        return header[0] == 0x47 && header[1] == 0x49 && header[2] == 0x46;
      case '.pdf':
        return header[0] == 0x25 && header[1] == 0x50 && header[2] == 0x44 && header[3] == 0x46;
      default:
        return true; // Allow other extensions without header validation
    }
  }

  /// Generate CSRF token
  String generateCSRFToken() {
    return generateSecureToken(length: 32);
  }

  /// Validate CSRF token
  bool validateCSRFToken(String token, String expectedToken) {
    return token == expectedToken && token.isNotEmpty;
  }
}

/// Password strength levels
enum PasswordStrength {
  veryWeak,
  weak,
  medium,
  strong,
  veryStrong,
}

/// Extension for password strength
extension PasswordStrengthExtension on PasswordStrength {
  String get displayName {
    switch (this) {
      case PasswordStrength.veryWeak:
        return 'Very Weak';
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.strong:
        return 'Strong';
      case PasswordStrength.veryStrong:
        return 'Very Strong';
    }
  }

  Color get color {
    switch (this) {
      case PasswordStrength.veryWeak:
        return const Color(0xFFD32F2F); // Red
      case PasswordStrength.weak:
        return const Color(0xFFFF9800); // Orange
      case PasswordStrength.medium:
        return const Color(0xFFFFC107); // Amber
      case PasswordStrength.strong:
        return const Color(0xFF689F38); // Light Green
      case PasswordStrength.veryStrong:
        return const Color(0xFF388E3C); // Green
    }
  }

  double get progress {
    switch (this) {
      case PasswordStrength.veryWeak:
        return 0.1;
      case PasswordStrength.weak:
        return 0.3;
      case PasswordStrength.medium:
        return 0.5;
      case PasswordStrength.strong:
        return 0.8;
      case PasswordStrength.veryStrong:
        return 1.0;
    }
  }
}

/// Security utilities for common operations
class SecurityUtils {
  /// Mask sensitive information for logging
  static String maskSensitiveData(String data, {int visibleChars = 4}) {
    if (data.length <= visibleChars) {
      return '*' * data.length;
    }
    
    final visible = data.substring(0, visibleChars);
    final masked = '*' * (data.length - visibleChars);
    return visible + masked;
  }

  /// Generate a secure session ID
  static String generateSessionId() {
    return SecurityManager().generateSecureToken(length: 48);
  }

  /// Validate session ID format
  static bool isValidSessionId(String sessionId) {
    return sessionId.length == 48 && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(sessionId);
  }

  /// Create secure random bytes
  static List<int> generateSecureBytes(int length) {
    final random = Random.secure();
    return List.generate(length, (i) => random.nextInt(256));
  }

  /// Constant-time string comparison to prevent timing attacks
  static bool secureStringEquals(String a, String b) {
    if (a.length != b.length) return false;
    
    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    
    return result == 0;
  }
}