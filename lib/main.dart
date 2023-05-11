import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reqres_consumer/src/common/constants.dart';
import 'package:reqres_consumer/src/ui/resource_page.dart';
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
        cardColor: Colors.grey[200],
        canvasColor: Colors.grey[400],
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Circular',
        primaryColor: Colors.indigo.shade400,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
          brightness: Brightness.dark,
        ),
        cardColor: Colors.grey[600],
        canvasColor: Colors.blueGrey[700],
        scaffoldBackgroundColor: Colors.grey[700],
        useMaterial3: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
    final bright = Theme.of(context).brightness == Brightness.light;
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
              begin: bright ? Alignment.bottomLeft : Alignment.bottomRight,
              end: bright ? Alignment.topRight : Alignment.topCenter,
              colors: bright
                  ? [
                      Colors.indigo.shade400,
                      Colors.blue,
                    ]
                  : [
                      Theme.of(context).colorScheme.secondary,
                      Colors.deepOrange[400]!,
                    ],
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
        child: BottomAppBar(
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
        ),
      ),
    );
  }
}
