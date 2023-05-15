import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './src/common/constants.dart';
import './src/providers/auth/auth.dart';
import './src/ui/resource_page.dart';
import './src/ui/users_page.dart';
import './src/ui/login_page.dart';
import './firebase_options.dart';
import './src/ui/about_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.read(authProvider);
    return MaterialApp(
      title: APP_TITLE,
      theme: APP_DEFAULT_THEME,
      darkTheme: APP_DARK_THEME,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: _auth.authProvider.firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              return const MyHomePage();
            } else if (snapshot.data == null) {
              return const LoginPage();
            }
            return Container();
          } catch (e) {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.pop(_),
                    ),
                  ],
                  content: Text(snapshot.error.toString()),
                  title: const Text("An Error Occured"),
                );
              },
            );
            return Container();
          }
        },
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  TabController? _ctrller;

  @override
  void initState() {
    super.initState();
    _ctrller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bright = Theme.of(context).brightness == Brightness.light;
    final auth = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ReqRes Consumer",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: _buildActions(auth),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: bright ? Alignment.bottomLeft : Alignment.bottomRight,
              end: bright ? Alignment.topRight : Alignment.topCenter,
              colors: _gradient(bright, context),
            ),
          ),
        ),
        bottom: TabBar(
          indicatorColor: !bright ? Colors.white : Colors.grey[800],
          indicatorWeight: 4.0,
          tabs: const [Tab(text: "Users"), Tab(text: "Resources")],
          controller: _ctrller,
        ),
      ),
      body: TabBarView(
        controller: _ctrller,
        physics: const ClampingScrollPhysics(),
        children: const [
          UsersPage(),
          ResourcesPage(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: _buildBottomBar(bright),
      ),
    );
  }

  List<Widget> _buildActions(Auth auth) => [
        IconButton(
          tooltip: "About",
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AboutPage(),
            ),
          ),
          icon: const Icon(Icons.info_outline, color: Colors.white),
        ),
        IconButton(
          onPressed: () {
            auth.signOut().listen((u) {
              if (u == null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              }
            });
          },
          tooltip: "Log Out",
          icon: const Icon(Icons.output_outlined, color: Colors.white),
        ),
      ];

  List<Color> _gradient(bool bright, BuildContext context) => bright
      ? [
          Theme.of(context).primaryColor,
          Colors.blue,
        ]
      : [
          Theme.of(context).colorScheme.secondary,
          Colors.deepOrange[400]!,
        ];

  Widget _buildBottomBar(bool bright) => BottomAppBar(
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: !bright
                  ? [
                      Colors.indigo.shade400,
                      Colors.blue,
                    ]
                  : [
                      Theme.of(context).colorScheme.secondary,
                      Colors.deepOrange[400]!,
                    ],
              begin: !bright ? Alignment.bottomLeft : Alignment.bottomRight,
              end: !bright ? Alignment.topRight : Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                      child: LinearProgressIndicator(
                        value: 0.3,
                        color: !bright
                            ? Colors.deepOrange[400]!
                            : Theme.of(context).primaryColor,
                        minHeight: 11.0,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "1/6",
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
          ),
        ),
      );
}
