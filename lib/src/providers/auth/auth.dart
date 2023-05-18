import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

class Auth extends StateNotifier<User?> {
  final AuthProvider authProvider;

  Auth(this.authProvider) : super(null);

  Stream<User?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async* {
    authProvider.loginWithEmailAndPassword(email, password);
  }

  Stream<User?> loginWithGoogle() async* {
    await authProvider.loginWithGoogle();
    yield* authProvider.firebaseAuth.authStateChanges()
      ..listen(
        (u) => state = u,
      );
  }

  Stream<User?> signOut() async* {
    await authProvider.signOut();
    yield* authProvider.firebaseAuth.authStateChanges()
      ..listen(
        (u) => state = u,
      );
  }

  Stream<User?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async* {
    await authProvider.registerWithEmailAndPassword(email, password);
  }

  Stream<User?> registerWithGoogle() async* {
    await authProvider.registerWithGoogle();
  }
}

final _authProvider = Provider((ref) => AuthProviderImpl());

final authProvider = StateProvider(
  (ref) => Auth(ref.read(_authProvider)),
);
