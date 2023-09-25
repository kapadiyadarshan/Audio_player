import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_player/model/song_model.dart';
import 'package:audio_player/utils/songs_utils.dart';
import 'package:flutter/material.dart';

class AudioPlayerController extends ChangeNotifier {
  AssetsAudioPlayer audioController = AssetsAudioPlayer();

  List<Song> _songObjectList = [];

  double totalDuration = 0;

  bool isPlay = false;

  int songIndex = 0;
  int playlistIndex = 0;

  initData({required int index}) {
    createSongList();
    changeSong(index: index);

    audioController
        .open(
      Audio(_songObjectList[songIndex].path),
      autoStart: true,
    )
        .then((value) {
      totalDuration =
          audioController.current.value!.audio.duration.inSeconds.toDouble();

      notifyListeners();
    });
  }

  changeSong({required int index}) {
    songIndex = index;
    notifyListeners();
  }

  forwardSong() {
    if (songIndex < 17) {
      songIndex++;
      initData(index: songIndex);
    }
    notifyListeners();
  }

  backwardSong() {
    if (songIndex != 0) {
      songIndex--;
      initData(index: songIndex);
    }
    notifyListeners();
  }

  repeatSong() {
    initData(index: songIndex);
    notifyListeners();
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

  changPlaylist({required int index}) {
    playlistIndex = index;
    notifyListeners();
  }
}
