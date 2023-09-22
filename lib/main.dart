import 'package:audio_player/controller/audioPlayer_controller.dart';
import 'package:audio_player/utils/route_utils.dart';
import 'package:audio_player/views/screens/detailPage.dart';
import 'package:audio_player/views/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioPlayerController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoute.HomePage,
      routes: {
        MyRoute.HomePage: (context) => const HomePage(),
        MyRoute.DetailPage: (context) => DetailPage(),
      },
    );
  }
}
