import 'package:flutter/material.dart';

typedef SignInCallback = void Function();

class GoogleSignInButton extends StatelessWidget {
  final SignInCallback onPressed;
  final bool loginState;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    required this.loginState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 4.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/google-logo.png', width: 24.0, height: 24.0),
          MaterialButton(
            onPressed: onPressed,
            child: Text(
              loginState ? "Sign in with Google" : "Continue with Google",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
