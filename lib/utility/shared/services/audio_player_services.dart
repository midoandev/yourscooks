// import 'package:audioplayers/audioplayers.dart';
//
// class AudioPlayerSingleton {
//   static AudioPlayerSingleton? _instance;
//   static AudioPlayer? _audioPlayer;
//   static const url = 'https://firebasestorage.googleapis.com/v0/b/weddinginvitation-7436a.appspot.com/o/cinta.mp3?alt=media&token=9da979e9-4821-4b32-97bb-6c9af91b817a';
//
//   factory AudioPlayerSingleton() {
//     _instance ??= AudioPlayerSingleton._internal();
//     return _instance!;
//   }
//
//   AudioPlayerSingleton._internal() {
//     _audioPlayer = AudioPlayer();
//     _audioPlayer?.setReleaseMode(ReleaseMode.LOOP);
//   }
//
//   AudioPlayer get audioPlayer => _audioPlayer!;
//   AudioPlayerState get audioPlayerState => audioPlayer.state;
//
//   Future<void> play() async {
//     await _audioPlayer!.play(url);
//   }
//
//   Future<void> pause() async {
//     await _audioPlayer!.pause();
//   }
//   Future<void> resume() async {
//     await _audioPlayer!.resume();
//   }
//
//   Future<void> stop() async {
//     await _audioPlayer!.stop();
//   }
//
//   void dispose() {
//     _audioPlayer!.dispose();
//   }
// }