import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bright = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: bright ? Alignment.bottomLeft : Alignment.bottomRight,
              end: bright ? Alignment.topRight : Alignment.topCenter,
              colors: _gradient(bright, context),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                backgroundColor: Colors.white,
                minRadius: 75.0,
                maxRadius: 80.0,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/about-img.png'),
                  minRadius: 70.0,
                  maxRadius: 75.0,
                ),
              ),
              SizedBox(height: 40.0),
              Text(
                """ Hello! I am Aman Ranjan, a first-year student pursuing CSE at BITS Pilani, Hyderabad Campus. I hail from Patna, Bihar but currently live in Navi Mumbai, Maharashtra. I am keenly interested in programming, music, and in general, learning new things. Solving puzzles is also an occasional pastime for me. """,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

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
