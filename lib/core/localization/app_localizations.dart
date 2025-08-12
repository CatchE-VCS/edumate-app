import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Internationalization support for the Edumate app
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('es', 'ES'), // Spanish
    Locale('fr', 'FR'), // French
    Locale('de', 'DE'), // German
    Locale('ja', 'JP'), // Japanese
    Locale('zh', 'CN'), // Chinese
    Locale('ar', 'SA'), // Arabic
    Locale('hi', 'IN'), // Hindi
  ];

  /// Get localized strings based on current locale
  Map<String, String> get _localizedStrings {
    switch (locale.languageCode) {
      case 'es':
        return _spanishStrings;
      case 'fr':
        return _frenchStrings;
      case 'de':
        return _germanStrings;
      case 'ja':
        return _japaneseStrings;
      case 'zh':
        return _chineseStrings;
      case 'ar':
        return _arabicStrings;
      case 'hi':
        return _hindiStrings;
      default:
        return _englishStrings;
    }
  }

  // Common UI strings
  String get appName => _localizedStrings['app_name'] ?? 'Edumate';
  String get loading => _localizedStrings['loading'] ?? 'Loading...';
  String get error => _localizedStrings['error'] ?? 'Error';
  String get retry => _localizedStrings['retry'] ?? 'Retry';
  String get cancel => _localizedStrings['cancel'] ?? 'Cancel';
  String get confirm => _localizedStrings['confirm'] ?? 'Confirm';
  String get save => _localizedStrings['save'] ?? 'Save';
  String get delete => _localizedStrings['delete'] ?? 'Delete';
  String get edit => _localizedStrings['edit'] ?? 'Edit';
  String get close => _localizedStrings['close'] ?? 'Close';
  String get back => _localizedStrings['back'] ?? 'Back';
  String get next => _localizedStrings['next'] ?? 'Next';
  String get previous => _localizedStrings['previous'] ?? 'Previous';
  String get done => _localizedStrings['done'] ?? 'Done';
  String get ok => _localizedStrings['ok'] ?? 'OK';

  // Authentication strings
  String get login => _localizedStrings['login'] ?? 'Login';
  String get logout => _localizedStrings['logout'] ?? 'Logout';
  String get signUp => _localizedStrings['sign_up'] ?? 'Sign Up';
  String get email => _localizedStrings['email'] ?? 'Email';
  String get password => _localizedStrings['password'] ?? 'Password';
  String get forgotPassword => _localizedStrings['forgot_password'] ?? 'Forgot Password?';
  String get resetPassword => _localizedStrings['reset_password'] ?? 'Reset Password';
  String get loginWithGoogle => _localizedStrings['login_with_google'] ?? 'Login with Google';
  String get loginWithFacebook => _localizedStrings['login_with_facebook'] ?? 'Login with Facebook';
  String get loginWithTwitter => _localizedStrings['login_with_twitter'] ?? 'Login with Twitter';

  // Navigation strings
  String get home => _localizedStrings['home'] ?? 'Home';
  String get profile => _localizedStrings['profile'] ?? 'Profile';
  String get courses => _localizedStrings['courses'] ?? 'Courses';
  String get contests => _localizedStrings['contests'] ?? 'Contests';
  String get skills => _localizedStrings['skills'] ?? 'Skills';
  String get leaderboard => _localizedStrings['leaderboard'] ?? 'Leaderboard';
  String get settings => _localizedStrings['settings'] ?? 'Settings';
  String get notifications => _localizedStrings['notifications'] ?? 'Notifications';

  // Course strings
  String get myCourses => _localizedStrings['my_courses'] ?? 'My Courses';
  String get courseProgress => _localizedStrings['course_progress'] ?? 'Course Progress';
  String get completedCourses => _localizedStrings['completed_courses'] ?? 'Completed Courses';
  String get enrolledCourses => _localizedStrings['enrolled_courses'] ?? 'Enrolled Courses';
  String get startCourse => _localizedStrings['start_course'] ?? 'Start Course';
  String get continueCourse => _localizedStrings['continue_course'] ?? 'Continue Course';
  String get watchVideo => _localizedStrings['watch_video'] ?? 'Watch Video';
  String get downloadVideo => _localizedStrings['download_video'] ?? 'Download Video';

  // Contest strings
  String get upcomingContests => _localizedStrings['upcoming_contests'] ?? 'Upcoming Contests';
  String get liveContests => _localizedStrings['live_contests'] ?? 'Live Contests';
  String get pastContests => _localizedStrings['past_contests'] ?? 'Past Contests';
  String get participate => _localizedStrings['participate'] ?? 'Participate';
  String get register => _localizedStrings['register'] ?? 'Register';
  String get results => _localizedStrings['results'] ?? 'Results';

  // Redemption strings
  String get redeemStore => _localizedStrings['redeem_store'] ?? 'Redeem Store';
  String get availableItems => _localizedStrings['available_items'] ?? 'Available Items';
  String get redeem => _localizedStrings['redeem'] ?? 'Redeem';
  String get insufficientCoins => _localizedStrings['insufficient_coins'] ?? 'Insufficient Coins';
  String get redeemNow => _localizedStrings['redeem_now'] ?? 'Redeem Now';
  String get deliveryInformation => _localizedStrings['delivery_information'] ?? 'Delivery Information';
  String get addressLine1 => _localizedStrings['address_line_1'] ?? 'Address Line 1';
  String get addressLine2 => _localizedStrings['address_line_2'] ?? 'Address Line 2 (Optional)';
  String get phoneNumber => _localizedStrings['phone_number'] ?? 'Phone Number';
  String get selectSize => _localizedStrings['select_size'] ?? 'Select Size';

  // Error messages
  String get networkError => _localizedStrings['network_error'] ?? 'Network error occurred';
  String get serverError => _localizedStrings['server_error'] ?? 'Server error occurred';
  String get unknownError => _localizedStrings['unknown_error'] ?? 'An unknown error occurred';
  String get validationError => _localizedStrings['validation_error'] ?? 'Please check your input';
  String get emailRequired => _localizedStrings['email_required'] ?? 'Email is required';
  String get invalidEmail => _localizedStrings['invalid_email'] ?? 'Please enter a valid email';
  String get passwordRequired => _localizedStrings['password_required'] ?? 'Password is required';
  String get addressRequired => _localizedStrings['address_required'] ?? 'Address is required';
  String get phoneRequired => _localizedStrings['phone_required'] ?? 'Phone number is required';

  // Success messages
  String get loginSuccess => _localizedStrings['login_success'] ?? 'Login successful';
  String get registrationSuccess => _localizedStrings['registration_success'] ?? 'Registration successful';
  String get passwordResetSent => _localizedStrings['password_reset_sent'] ?? 'Password reset email sent';
  String get redemptionSuccess => _localizedStrings['redemption_success'] ?? 'Redemption request submitted successfully';

  // Time and date formats
  String get timeFormat => _localizedStrings['time_format'] ?? 'HH:mm';
  String get dateFormat => _localizedStrings['date_format'] ?? 'MM/dd/yyyy';
  String get dateTimeFormat => _localizedStrings['datetime_format'] ?? 'MM/dd/yyyy HH:mm';
}

/// Delegate for loading app localizations
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .any((supportedLocale) => supportedLocale.languageCode == locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// English strings (default)
const Map<String, String> _englishStrings = {
  'app_name': 'Edumate',
  'loading': 'Loading...',
  'error': 'Error',
  'retry': 'Retry',
  'cancel': 'Cancel',
  'confirm': 'Confirm',
  'save': 'Save',
  'delete': 'Delete',
  'edit': 'Edit',
  'close': 'Close',
  'back': 'Back',
  'next': 'Next',
  'previous': 'Previous',
  'done': 'Done',
  'ok': 'OK',
  'login': 'Login',
  'logout': 'Logout',
  'sign_up': 'Sign Up',
  'email': 'Email',
  'password': 'Password',
  'forgot_password': 'Forgot Password?',
  'reset_password': 'Reset Password',
  'login_with_google': 'Login with Google',
  'login_with_facebook': 'Login with Facebook',
  'login_with_twitter': 'Login with Twitter',
  'home': 'Home',
  'profile': 'Profile',
  'courses': 'Courses',
  'contests': 'Contests',
  'skills': 'Skills',
  'leaderboard': 'Leaderboard',
  'settings': 'Settings',
  'notifications': 'Notifications',
  'my_courses': 'My Courses',
  'course_progress': 'Course Progress',
  'completed_courses': 'Completed Courses',
  'enrolled_courses': 'Enrolled Courses',
  'start_course': 'Start Course',
  'continue_course': 'Continue Course',
  'watch_video': 'Watch Video',
  'download_video': 'Download Video',
  'upcoming_contests': 'Upcoming Contests',
  'live_contests': 'Live Contests',
  'past_contests': 'Past Contests',
  'participate': 'Participate',
  'register': 'Register',
  'results': 'Results',
  'redeem_store': 'Redeem Store',
  'available_items': 'Available Items',
  'redeem': 'Redeem',
  'insufficient_coins': 'Insufficient Coins',
  'redeem_now': 'Redeem Now',
  'delivery_information': 'Delivery Information',
  'address_line_1': 'Address Line 1',
  'address_line_2': 'Address Line 2 (Optional)',
  'phone_number': 'Phone Number',
  'select_size': 'Select Size',
  'network_error': 'Network error occurred',
  'server_error': 'Server error occurred',
  'unknown_error': 'An unknown error occurred',
  'validation_error': 'Please check your input',
  'email_required': 'Email is required',
  'invalid_email': 'Please enter a valid email',
  'password_required': 'Password is required',
  'address_required': 'Address is required',
  'phone_required': 'Phone number is required',
  'login_success': 'Login successful',
  'registration_success': 'Registration successful',
  'password_reset_sent': 'Password reset email sent',
  'redemption_success': 'Redemption request submitted successfully',
  'time_format': 'HH:mm',
  'date_format': 'MM/dd/yyyy',
  'datetime_format': 'MM/dd/yyyy HH:mm',
};

// Spanish strings
const Map<String, String> _spanishStrings = {
  'app_name': 'Edumate',
  'loading': 'Cargando...',
  'error': 'Error',
  'retry': 'Reintentar',
  'cancel': 'Cancelar',
  'confirm': 'Confirmar',
  'save': 'Guardar',
  'delete': 'Eliminar',
  'edit': 'Editar',
  'close': 'Cerrar',
  'back': 'Atrás',
  'next': 'Siguiente',
  'previous': 'Anterior',
  'done': 'Hecho',
  'ok': 'OK',
  'login': 'Iniciar Sesión',
  'logout': 'Cerrar Sesión',
  'sign_up': 'Registrarse',
  'email': 'Email',
  'password': 'Contraseña',
  'forgot_password': '¿Olvidaste tu contraseña?',
  'reset_password': 'Restablecer Contraseña',
  'login_with_google': 'Iniciar con Google',
  'login_with_facebook': 'Iniciar con Facebook',
  'login_with_twitter': 'Iniciar con Twitter',
  'home': 'Inicio',
  'profile': 'Perfil',
  'courses': 'Cursos',
  'contests': 'Concursos',
  'skills': 'Habilidades',
  'leaderboard': 'Tabla de Líderes',
  'settings': 'Configuración',
  'notifications': 'Notificaciones',
  'redeem_store': 'Tienda de Canje',
  'available_items': 'Artículos Disponibles',
  'redeem': 'Canjear',
  'insufficient_coins': 'Monedas Insuficientes',
  'delivery_information': 'Información de Entrega',
  'address_line_1': 'Dirección Línea 1',
  'phone_number': 'Número de Teléfono',
  'select_size': 'Seleccionar Talla',
  'network_error': 'Error de red',
  'email_required': 'El email es requerido',
  'invalid_email': 'Por favor ingresa un email válido',
};

// French strings
const Map<String, String> _frenchStrings = {
  'app_name': 'Edumate',
  'loading': 'Chargement...',
  'error': 'Erreur',
  'retry': 'Réessayer',
  'cancel': 'Annuler',
  'confirm': 'Confirmer',
  'save': 'Sauvegarder',
  'delete': 'Supprimer',
  'login': 'Se connecter',
  'logout': 'Se déconnecter',
  'sign_up': "S'inscrire",
  'email': 'Email',
  'password': 'Mot de passe',
  'home': 'Accueil',
  'profile': 'Profil',
  'courses': 'Cours',
  'contests': 'Concours',
  'skills': 'Compétences',
  'settings': 'Paramètres',
  'redeem_store': 'Boutique de Récompenses',
  'redeem': 'Échanger',
  'delivery_information': 'Informations de Livraison',
};

// German strings
const Map<String, String> _germanStrings = {
  'app_name': 'Edumate',
  'loading': 'Wird geladen...',
  'error': 'Fehler',
  'retry': 'Wiederholen',
  'cancel': 'Abbrechen',
  'confirm': 'Bestätigen',
  'login': 'Anmelden',
  'logout': 'Abmelden',
  'email': 'E-Mail',
  'password': 'Passwort',
  'home': 'Startseite',
  'profile': 'Profil',
  'courses': 'Kurse',
  'contests': 'Wettbewerbe',
  'skills': 'Fähigkeiten',
  'settings': 'Einstellungen',
  'redeem_store': 'Einlöse-Shop',
  'redeem': 'Einlösen',
};

// Japanese strings
const Map<String, String> _japaneseStrings = {
  'app_name': 'Edumate',
  'loading': '読み込み中...',
  'error': 'エラー',
  'retry': '再試行',
  'cancel': 'キャンセル',
  'login': 'ログイン',
  'logout': 'ログアウト',
  'email': 'メール',
  'password': 'パスワード',
  'home': 'ホーム',
  'profile': 'プロフィール',
  'courses': 'コース',
  'contests': 'コンテスト',
  'skills': 'スキル',
  'settings': '設定',
  'redeem_store': '交換ストア',
  'redeem': '交換',
};

// Chinese strings
const Map<String, String> _chineseStrings = {
  'app_name': 'Edumate',
  'loading': '加载中...',
  'error': '错误',
  'retry': '重试',
  'cancel': '取消',
  'login': '登录',
  'logout': '登出',
  'email': '邮箱',
  'password': '密码',
  'home': '首页',
  'profile': '个人资料',
  'courses': '课程',
  'contests': '竞赛',
  'skills': '技能',
  'settings': '设置',
  'redeem_store': '兑换商店',
  'redeem': '兑换',
};

// Arabic strings
const Map<String, String> _arabicStrings = {
  'app_name': 'Edumate',
  'loading': 'جاري التحميل...',
  'error': 'خطأ',
  'retry': 'إعادة المحاولة',
  'cancel': 'إلغاء',
  'login': 'تسجيل الدخول',
  'logout': 'تسجيل الخروج',
  'email': 'البريد الإلكتروني',
  'password': 'كلمة المرور',
  'home': 'الرئيسية',
  'profile': 'الملف الشخصي',
  'courses': 'الدورات',
  'contests': 'المسابقات',
  'skills': 'المهارات',
  'settings': 'الإعدادات',
  'redeem_store': 'متجر الاستبدال',
  'redeem': 'استبدال',
};

// Hindi strings
const Map<String, String> _hindiStrings = {
  'app_name': 'Edumate',
  'loading': 'लोड हो रहा है...',
  'error': 'त्रुटि',
  'retry': 'पुनः प्रयास करें',
  'cancel': 'रद्द करें',
  'login': 'लॉगिन',
  'logout': 'लॉगआउट',
  'email': 'ईमेल',
  'password': 'पासवर्ड',
  'home': 'होम',
  'profile': 'प्रोफाइल',
  'courses': 'कोर्स',
  'contests': 'प्रतियोगिताएं',
  'skills': 'कौशल',
  'settings': 'सेटिंग्स',
  'redeem_store': 'रिडीम स्टोर',
  'redeem': 'रिडीम',
};