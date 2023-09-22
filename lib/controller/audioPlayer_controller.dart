import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_player/model/song_model.dart';
import 'package:audio_player/utils/songs_utils.dart';
import 'package:flutter/material.dart';

class AudioPlayerController extends ChangeNotifier {
  AssetsAudioPlayer audioController = AssetsAudioPlayer();

  List<Song> _songObjectList = [];

  double totalDuration = 0;

  bool isPlay = false;

  initData({required int index}) {
    createSongList();

    audioController
        .open(
      Audio(_songObjectList[index].path),
      autoStart: true,
    )
        .then((value) {
      totalDuration =
          audioController.current.value!.audio.duration.inSeconds.toDouble();

      notifyListeners();
    });
  }

  pause() {
    audioController.pause();
    notifyListeners();
  }

  play() {
    audioController.play();
    notifyListeners();
  }

  seek({required int sec}) {
    audioController.seek(
      Duration(seconds: sec),
    );
    notifyListeners();
  }

  pauseAndPlayButton() {
    isPlay = audioController.isPlaying.value;
    notifyListeners();
  }

  List get getSongList {
    createSongList();
    return _songObjectList;
  }

  createSongList() {
    _songObjectList = List.generate(
      songList.length,
      (index) => Song(
        id: songList[index]["id"],
        name: songList[index]["name"],
        artist: songList[index]["artist"],
        path: songList[index]["path"],
      ),
    );
  }
}
