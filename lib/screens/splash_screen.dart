import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onInitializationComplete});

  final VoidCallback onInitializationComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        child: Stack(children: [
          Positioned(
            top: 25,
            left: 25,
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              width: 150,
              height: 150,
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shake(delay: 1100.ms),
          ),
          Container(
              height: 200,
              width: 200,
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.deepOrangeAccent,
                size: 180,
              )),
        ]),
      ),
    );
  }
}
