import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/api_exception.dart';

abstract class AuthProvider {
  const AuthProvider();

  FirebaseAuth get firebaseAuth;

  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> registerWithEmailAndPassword(String email, String password);
  Future<void> registerWithGoogle();
  Future<void> loginWithGoogle();
}

class AuthProviderImpl implements AuthProvider {
  final FirebaseAuth _auth;

  AuthProviderImpl() : _auth = FirebaseAuth.instance;

  Stream<User?> get users => _auth.authStateChanges();

  // Login Methods
  // 2 ways (Google, Email+Password)
  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw APIException(e.toString());
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      final user = await GoogleSignIn().signIn();
      final details = await user!.authentication;
      final creds = GoogleAuthProvider.credential(
        accessToken: details.accessToken,
        idToken: details.idToken,
      );

      _auth.signInWithCredential(creds);
    } catch (e) {
      throw APIException(e.toString());
    }
  }

  // Register a user
  @override
  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw APIException(e.toString());
    }
  }

  // Sign out
  @override
  Future<void> signOut() async {
    await _auth.signOut();
    print("sign out called");
    await GoogleSignIn().disconnect();
  }

  @override
  FirebaseAuth get firebaseAuth => _auth;

  @override
  Future<void> registerWithGoogle() async => loginWithGoogle();
}
