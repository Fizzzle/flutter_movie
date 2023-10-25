import 'dart:convert';

// Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

//Services
import '../services/http_service.dart';
import '../services/movie_service.dart';

// Model
import '../models/app_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onInitializationComplete});

  final VoidCallback onInitializationComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Чисто Сплеш экран, ради проверки загрузки чего то и продолжение
    /* 
    Future.delayed(Duration(milliseconds: 4000))
        .then((_) => widget.onInitializationComplete());
        */
    Future.delayed(Duration(milliseconds: 4000)).then(
        (_) => _setup(context).then((_) => widget.onInitializationComplete()));
  }

  Future<void> _setup(BuildContext _context) async {
    final getIt = GetIt.instance;

    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(
      AppConfig(
        configData['BASE_API_URL'],
        configData['BASE_IMAGE_API_URL'],
        configData['API_KEY'],
      ),
    );

    getIt.registerSingleton<HTTPService>(
      HTTPService(),
    );

    getIt.registerSingleton<MovieService>(
      MovieService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie App",
      theme: ThemeData(primarySwatch: Colors.orange),
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
                color: Colors.orange.shade700,
                size: 180,
              )),
        ]),
      ),
    );
  }
}
