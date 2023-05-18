import 'dart:math' show pi;

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../common/constants.dart';
import '../providers/auth/auth.dart';
import '../ui/google_signin_button.dart';
import '../models/tab_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final CustomSegmentedController<TabState> _controller =
      CustomSegmentedController<TabState>()..value = TabState.login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bright = Theme.of(context).brightness == Brightness.light;
    final auth = ref.watch(authProvider);
    return Container(
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: _getColor(bright),
          center: Alignment.topLeft,
          startAngle: _toDeg(-53.0),
          endAngle: _toDeg(127.0),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.125,
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  color: Colors.grey[400]!,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32.0,
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: CustomSlidingSegmentedControl<TabState>(
                            children: {
                              TabState.login: Text(
                                LOGIN_TEXT,
                                style: TextStyle(
                                  color: _controller.value == TabState.login
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              TabState.register: Text(
                                REGISTER_TEXT,
                                style: TextStyle(
                                  color: _controller.value == TabState.register
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            },
                            controller: _controller,
                            thumbDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).primaryColor,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.grey[200],
                            ),
                            isStretch: true,
                            curve: Curves.easeInOutCubicEmphasized,
                            duration: const Duration(milliseconds: 500),
                            onValueChanged: (v) => setState(() {
                              _email.clear();
                              _password.clear();
                              _controller.value = v;
                            }),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40.0,
                              ),
                              ListTile(
                                dense: true,
                                leading: const Center(
                                  widthFactor: 1.0,
                                  child: Text(
                                    EMAIL_TEXT,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                title: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _email,
                                  validator: (v) =>
                                      v!.contains("@") ? null : "Invalid Email",
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 8.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ListTile(
                                leading: const Center(
                                  widthFactor: 1.0,
                                  child: Text(
                                    PASSWORD_TEXT,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                title: TextFormField(
                                  obscureText: true,
                                  controller: _password,
                                  validator: (v) {
                                    if (v?.isNotEmpty ?? false) {
                                      if (v!.length < 5) {
                                        return PASSWORD_TOO_SHORT;
                                      }
                                    } else {
                                      return PASSWORD_EMPTY;
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 8.0,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: MaterialButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    bool isCorrect =
                                        _formKey.currentState?.validate() ??
                                            false;
                                    bool isLogin =
                                        _controller.value == TabState.login;
                                    if (isCorrect) {
                                      if (isLogin) {
                                        final email = _email.value.text;
                                        final pwd = _password.value.text;
                                        ref
                                            .read(authProvider)
                                            .loginWithEmailAndPassword(
                                              email,
                                              pwd,
                                            );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (c) => const MyHomePage(),
                                          ),
                                        );
                                      } else {
                                        final email = _email.value.text;
                                        final pwd = _password.value.text;
                                        ref
                                            .read(authProvider)
                                            .registerWithEmailAndPassword(
                                              email,
                                              pwd,
                                            )
                                            .listen((u) {
                                          if (u != null) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (c) =>
                                                    const MyHomePage(),
                                              ),
                                            );
                                          }
                                        });
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 12.0,
                                    ),
                                    child: Text(
                                      _controller.value == TabState.login
                                          ? LOGIN_TEXT
                                          : REGISTER_TEXT,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              GoogleSignInButton(
                                onPressed: () {
                                  (_controller.value == TabState.login
                                          ? auth.loginWithGoogle()
                                          : auth.registerWithGoogle())
                                      .listen((u) {
                                    if (u != null) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const MyHomePage(),
                                        ),
                                      );
                                    }
                                  });
                                },
                                loginState: _controller.value == TabState.login,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.01,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Colors.blue,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Card(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              APP_NAME,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _toDeg(double d) => pi * d / 180;

  List<Color> _getColor(bool bright) => !bright
      ? [
          Colors.deepOrange[400]!,
          Theme.of(context).colorScheme.secondary,
        ]
      : [
          Theme.of(context).primaryColor,
          Colors.blue[400]!,
        ];
}
