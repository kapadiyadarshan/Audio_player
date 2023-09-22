import 'dart:developer';
import 'dart:math';

import 'package:audio_player/controller/audioPlayer_controller.dart';
import 'package:audio_player/model/song_model.dart';
import 'package:audio_player/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/gradient_slider.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  LinearGradient gradient = LinearGradient(
    colors: [
      Colors.pink,
      Colors.blue,
      Colors.orange,
    ],
  );

  @override
  Widget build(BuildContext context) {
    // Map data = ModalRoute.of(context)!.settings.arguments as Map;
    Song data = ModalRoute.of(context)!.settings.arguments as Song;

    return Consumer<AudioPlayerController>(builder: (context, provider, _) {
      return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 180,
                top: -70,
                child: Container(
                  height: 340,
                  width: 340,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade700,
                        Colors.pink.shade200,
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.bgColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 280,
                bottom: 500,
                child: Container(
                  height: 340,
                  width: 340,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade700,
                        Colors.orange.shade300,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.bgColor,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 360,
                  ),
                  Center(
                    child: Container(
                      height: 340,
                      width: 340,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueAccent.shade700,
                            Colors.blueAccent.shade100,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.bgColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 500,
                child: Container(
                  height: 380,
                  width: 432,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    // color: Colors.black.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 200,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        "${data.name}",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          color: MyColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${data.artist}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: MyColors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      StreamBuilder(
                        stream: provider.audioController.currentPosition,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 4,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.pink,
                                              Colors.blue,
                                              Colors.orange
                                            ],
                                          ),
                                        ),
                                      ),
                                      SliderTheme(
                                        data: SliderThemeData(
                                          trackShape: CustomTrackShape(),
                                          activeTrackColor: Colors.transparent,
                                          inactiveTrackColor: Colors.grey,
                                          thumbColor: Colors.white,
                                          overlayColor: Colors.transparent,
                                        ),
                                        child: Slider(
                                          min: 0,
                                          max: provider.totalDuration,
                                          value: snapshot.data?.inSeconds
                                                  .toDouble() ??
                                              0,
                                          onChanged: (value) {
                                            provider.seek(sec: value.toInt());
                                          },
                                          // activeColor: Colors.blueAccent.shade400,
                                          // inactiveColor:
                                          //     Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${snapshot.data!.inMinutes.toString().padLeft(2, "0")}:${(snapshot.data!.inSeconds % 60).toString().padLeft(2, "0")}",
                                        style: TextStyle(
                                          color: MyColors.white,
                                        ),
                                      ),
                                      Text(
                                        "${(provider.totalDuration.toInt() ~/ 60).toString().padLeft(2, "0")}:${(provider.totalDuration.toInt() % 60).toString().padLeft(2, "0")}",
                                        style: TextStyle(
                                          color: MyColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              provider.pause();
                            },
                            icon: const Icon(Icons.repeat),
                            color: MyColors.white,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Transform.rotate(
                              angle: pi,
                              child: const Icon(Icons.fast_forward),
                            ),
                            color: MyColors.white,
                          ),
                          Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pink.shade400,
                                    Colors.blue.shade200,
                                    Colors.orange.shade400,
                                  ],
                                  stops: const [
                                    0.1,
                                    0.5,
                                    0.9,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: StreamBuilder(
                                stream: provider.audioController.isPlaying,
                                builder: (context, snapshot) {
                                  bool isPlay = snapshot?.data ?? false;

                                  return IconButton(
                                    onPressed: () {
                                      isPlay
                                          ? provider.pause()
                                          : provider.play();
                                    },
                                    icon: Icon(
                                      isPlay ? Icons.pause : Icons.play_arrow,
                                      color: MyColors.bgColor,
                                      size: 32,
                                    ),
                                  );
                                },
                              )),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.fast_forward),
                            color: MyColors.white,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border),
                            color: MyColors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: MyColors.bgColor,
      );
    });
  }
}
