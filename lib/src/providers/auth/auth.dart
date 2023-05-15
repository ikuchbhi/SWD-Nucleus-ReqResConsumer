import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

class Auth extends StateNotifier<User?> {
  final AuthProvider authProvider;

  User? user;

  Auth(this.authProvider)
      : _auth = authProvider.firebaseAuth,
        super(null);

  final FirebaseAuth _auth;

  Stream<User?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async* {
    authProvider.loginWithEmailAndPassword(email, password);
    yield* _auth.authStateChanges()
      ..listen((u) {
        if (u != null) user = u;
      });
  }

  Stream<User?> loginWithGoogle() async* {
    authProvider.loginWithGoogle();
    yield* _auth.authStateChanges()
      ..listen((u) {
        if (u != null) user = u;
      });
    ;
  }

  Stream<User?> signOut() async* {
    authProvider.signOut();
    yield* _auth.authStateChanges()
      ..listen((u) {
        user = u;
      });
    ;
  }

  Stream<User?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async* {
    authProvider.registerWithEmailAndPassword(email, password);
    yield* _auth.authStateChanges()
      ..listen((u) {
        if (u != null) user = u;
      });
  }

  Stream<User?> registerWithGoogle() async* {
    authProvider.registerWithGoogle();
    yield* _auth.authStateChanges()
      ..listen((u) {
        if (u != null) user = u;
      });
  }
}

final _authProvider = Provider((ref) => AuthProviderImpl());

final authProvider = StateProvider(
  (ref) => Auth(ref.read(_authProvider)),
);
