import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reqres_consumer/src/common/constants.dart';
import 'package:reqres_consumer/src/ui/users_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        fontFamily: 'Circular',
        primaryColor: Colors.indigo.shade400,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Circular',
        primaryColor: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController? _ctrller;

  @override
  void initState() {
    super.initState();
    _ctrller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ReqRes Consumer",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.indigo.shade400, Colors.blue]),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        bottom: TabBar(
          tabs: const [
            Tab(
              text: "Users",
            ),
            Tab(
              text: "Resources",
            )
          ],
          controller: _ctrller,
        ),
      ),
      body: TabBarView(
        controller: _ctrller,
        physics: const ClampingScrollPhysics(),
        children: [
          UsersPage(),
          const AppPage("Resources"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Reload',
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppPage extends StatelessWidget {
  final String title;

  const AppPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(title),
      ),
    );
  }
}
