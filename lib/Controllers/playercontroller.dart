import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var songDuration = Duration.zero.obs;

  void playSong(String songUrl) async {
    try {
      await audioPlayer.setAsset(songUrl);
      await audioPlayer.play();
      isPlaying.value = true;
    } catch (e) {
      print("Error playing song: $e");
    }
  }

  void pauseSong() async {
    await audioPlayer.pause();
    isPlaying.value = false;
  }

  void resumeSong() async {
    await audioPlayer.play();
    isPlaying.value = true;
  }

  void seekSong(double value) async {
    final position = Duration(seconds: (value * songDuration.value.inSeconds).toInt());
    await audioPlayer.seek(position);
  }

  @override
  void onInit() {
    super.onInit();

    audioPlayer.positionStream.listen((newPosition) {
      currentPosition.value = newPosition;
    });

    audioPlayer.durationStream.listen((newDuration) {
      if (newDuration != null) {
        songDuration.value = newDuration;
      }
    });

    audioPlayer.playerStateStream.listen((playerState) {
      isPlaying.value = playerState.playing;
    });
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
