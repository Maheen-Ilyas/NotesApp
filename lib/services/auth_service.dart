// Firebase is being directly used in the different screens
// Firebase is a low-level abstraction layer that is talking with firebase to provide with high-level functionalities
// The UI is directly communicating with backend
// Auth exceptions will be moved to a seperate file as these are being handled in the main UI
// The Firebase user should not be exposed to the UI. There should be no transparency

import 'package:my_notes_app/services/auth_provider.dart';
import 'package:my_notes_app/services/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
