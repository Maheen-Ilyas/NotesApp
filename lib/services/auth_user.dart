import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
  final user = FirebaseAuth.instance.currentUser;
  final bool isEmailVerified;
  AuthUser(this.isEmailVerified);
}
