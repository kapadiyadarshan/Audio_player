import 'package:audio_player/controller/audioPlayer_controller.dart';
import 'package:audio_player/utils/colors_utils.dart';
import 'package:audio_player/utils/route_utils.dart';
import 'package:audio_player/utils/songs_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../model/song_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Consumer<AudioPlayerController>(builder: (context, provider, _) {
      //   return CustomScrollView(
      //     slivers: [
      //       SliverAppBar(
      //         // expandedHeight: 180,
      //         title: GradientText(
      //           "MY MUSIC",
      //           style: const TextStyle(
      //             fontWeight: FontWeight.bold,
      //           ),
      //           colors: const [
      //             Colors.pink,
      //             Colors.blue,
      //             Colors.orange,
      //           ],
      //         ),
      //         backgroundColor: MyColors.bgColor,
      //         // flexibleSpace: FlexibleSpaceBar(
      //         //   title: GradientText(
      //         //     "MY MUSIC",
      //         //     style: const TextStyle(
      //         //       fontWeight: FontWeight.bold,
      //         //     ),
      //         //     colors: const [
      //         //       Colors.pink,
      //         //       Colors.blue,
      //         //       Colors.orange,
      //         //     ],
      //         //   ),
      //         //   centerTitle: true,
      //         // ),
      //         centerTitle: true,
      //         pinned: false,
      //         floating: true,
      //         snap: false,
      //       ),
      //       SliverFillRemaining(
      //         child: Row(
      //           children: [
      //             CircleAvatar(),
      //             CircleAvatar(),
      //             CircleAvatar(),
      //             CircleAvatar(),
      //           ],
      //         ),
      //       ),
      //       SliverList(
      //         delegate: SliverChildBuilderDelegate(
      //             childCount: provider.getSongList.length, (context, index) {
      //           Song temp = provider.getSongList[index];
      //
      //           return Padding(
      //             padding: const EdgeInsets.all(2),
      //             child: ListTile(
      //               onTap: () {
      //                 Provider.of<AudioPlayerController>(context, listen: false)
      //                     .initData(index: index);
      //
      //                 Navigator.pushNamed(
      //                   context,
      //                   MyRoute.DetailPage,
      //                   arguments: temp,
      //                 );
      //               },
      //               leading: CircleAvatar(
      //                 radius: 28,
      //                 backgroundColor: MyColors.white,
      //                 child: Text(
      //                   "${temp.name[0]}",
      //                   style: const TextStyle(
      //                     fontSize: 24,
      //                   ),
      //                 ),
      //               ),
      //               title: Text(
      //                 "${temp.name}",
      //                 style: const TextStyle(
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //               subtitle: Text(
      //                 "${temp.artist}",
      //                 style: const TextStyle(
      //                   fontSize: 12,
      //                 ),
      //               ),
      //               tileColor: MyColors.bgColor,
      //               textColor: MyColors.white,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(16),
      //               ),
      //               //                 ),
      //             ),
      //           );
      //         }),
      //       ),
      //     ],
      //   );
      // }),
      appBar: AppBar(
        title: GradientText(
          "MY MUSIC",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          colors: [
            Colors.pink,
            Colors.blueAccent.shade200,
            Colors.orange,
          ],
        ),
        centerTitle: true,
        backgroundColor: MyColors.bgColor,
        foregroundColor: MyColors.white,
      ),
      body: Consumer<AudioPlayerController>(builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 260.0,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  // autoPlayInterval: const Duration(seconds: 1),
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    provider.changPlaylist(index: index);
                  },
                ),
                items: List.generate(
                  PlayList.length,
                  (index) => Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage("${PlayList[index]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  PlayList.length,
                  (index) => Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: (provider.playlistIndex == index)
                      //     ? Colors.pink
                      //     : Colors.grey.withOpacity(0.5),
                      gradient: LinearGradient(
                        colors: (provider.playlistIndex == index)
                            ? [
                                Colors.pink.shade200,
                                Colors.blue.shade200,
                                Colors.orange.shade200,
                              ]
                            : [
                                Colors.grey.withOpacity(0.5),
                                Colors.grey.withOpacity(0.5),
                                Colors.grey.withOpacity(0.5),
                              ],
                        stops: const [
                          0.2,
                          0.5,
                          0.8,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: songList.length,
                  itemBuilder: (context, index) {
                    Song temp = provider.getSongList[index];

                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        onTap: () {
                          Provider.of<AudioPlayerController>(context,
                                  listen: false)
                              .initData(index: index);

                          Navigator.pushNamed(
                            context,
                            MyRoute.DetailPage,
                            arguments: index,
                          );
                        },
                        leading: Container(
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
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.transparent,
                            child: Text(
                              "${temp.name[0]}",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: MyColors.bgColor,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          "${temp.name}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${temp.artist}",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        trailing: Icon(
                          Icons.play_arrow,
                          color: MyColors.white,
                        ),
                        tileColor: MyColors.bgColor,
                        textColor: MyColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      backgroundColor: MyColors.bgColor,
    );
  }
}
