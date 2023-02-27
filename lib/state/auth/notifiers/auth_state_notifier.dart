import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:edumate/state/auth/backend/authenticator.dart';
import 'package:edumate/state/auth/models/auth_result.dart';
import 'package:edumate/state/auth/models/auth_state.dart';
import 'package:edumate/state/posts/typedefs/user_id.dart';
import 'package:edumate/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  AuthStateNotifier() : super(const AuthState.initial()) {
    if (_authenticator.isAuthenticated) {
      state = AuthState(
        result: AuthResult.successful,
        userId: _authenticator.userId,
        isLoading: false,
      );
    }
  }
  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.successful && userId != null) {
      await saveUserInfo(userId: userId);
      state = AuthState(
        result: result,
        userId: userId,
        isLoading: false,
      );
    } else {
      state = state.copiedWithIsLoading(false);
    }
  }
  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.signInWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.successful && userId != null) {
      await saveUserInfo(userId: userId);
      state = AuthState(
        result: result,
        userId: userId,
        isLoading: false,
      );
    } else {
      state = state.copiedWithIsLoading(false);
    }
  }
  Future<void> saveUserInfo({required UserId userId})=> _userInfoStorage.saveUserInfo(userId: userId, displayName: _authenticator.displayName, email: _authenticator.email);
  Future<void> logout() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logout();
    state = const AuthState.initial();
  }
  // AuthState get authState => state;
}
