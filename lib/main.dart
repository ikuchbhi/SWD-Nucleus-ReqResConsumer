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
    return MaterialApp(
      title: APP_TITLE,
      theme: APP_DEFAULT_THEME,
      darkTheme: APP_DARK_THEME,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case ROUTE_HOME:
            final currentUser =
                ref.watch(authProvider).authProvider.firebaseAuth.currentUser;
            return currentUser != null
                ? MaterialPageRoute(
                    builder: (_) => const MyHomePage(),
                  )
                : MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  );
          case ROUTE_LOGIN:
            return MaterialPageRoute(
              builder: (_) => const LoginPage(),
            );
          case ROUTE_USERS:
            return MaterialPageRoute(
              builder: (_) => const UsersPage(),
            );
          case ROUTE_RESOURCES:
            return MaterialPageRoute(
              builder: (_) => const ResourcesPage(),
            );
          case ROUTE_ABOUT:
            return MaterialPageRoute(
              builder: (_) => const AboutPage(),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => const LoginPage(),
            );
        }
      },
      home: StreamBuilder<User?>(
        stream: ref
            .watch(authProvider)
            .authProvider
            .firebaseAuth
            .authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MyHomePage();
          } else if (snapshot.data == null) {
            return const LoginPage();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
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
  final PageStorageBucket appBucket = PageStorageBucket();

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
          APP_NAME,
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
          tabs: const [Tab(text: USERS_TAB), Tab(text: RESOURCES_TAB)],
          controller: _ctrller,
        ),
      ),
      body: PageStorage(
        bucket: appBucket,
        child: TabBarView(
          controller: _ctrller,
          physics: const ClampingScrollPhysics(),
          children: const [
            UsersPage(
              key: PageStorageKey(USERS_TAB),
            ),
            ResourcesPage(
              key: PageStorageKey(RESOURCES_TAB),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions(Auth auth) => [
        IconButton(
          tooltip: ABOUT_TOOLTIP,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AboutPage(),
            ),
          ),
          icon: const Icon(Icons.info_outline, color: Colors.white),
        ),
        IconButton(
          onPressed: () async {
            final users = await auth.signOut();
            users.handleError(
              (e) => showDialog(
                context: context,
                builder: (c) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(c),
                      child: const Text(OK_BUTTON),
                    ),
                  ],
                  content: Text(e.toString()),
                  title: const Text(ERROR_BUTTON),
                ),
              ),
            );
          },
          tooltip: LOGOUT_TOOLTIP,
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
}
