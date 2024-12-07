import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

import '../Model/DummyData.dart';

class SongPlayerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  // Observable current artist/song
  var artist = Artist(
    songName: 'Song Name',
    artistName: 'Artist Name',
    albumImage: 'assets/images/default.jpg',
    songUrl: 'assets/music/default.mp3',
  ).obs;

  // Playback state observables
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var songDuration = Duration.zero.obs;

  // Song list and playback mode observables
  final RxList<Artist> songList = <Artist>[].obs;
  var isLooping = false.obs;
  var isShuffle = false.obs;

  var favorites = <Artist>[].obs;

  // Add a song to favorites
  void addToFavorites(Artist song) {
    if (!favorites.contains(song)) {
      favorites.add(song);
    }
  }

  // Remove a song from favorites
  void removeFromFavorites(Artist song) {
    favorites.remove(song);
  }
  // Playback mode toggles
  void toggleShuffle() {
    isShuffle.value = !isShuffle.value;
  }

  void toggleLoop() {
    isLooping.value = !isLooping.value;
    audioPlayer.setLoopMode(
        isLooping.value ? LoopMode.one : LoopMode.off
    );
  }
  Future<void> selectAndPlaySongFromFavorites(Artist newArtist) async {
    try {
      // Ensure the song is in favorites
      if (!favorites.contains(newArtist)) {
        print("Song not in favorites");
        return;
      }

      // Set playlist to only favorites
      songList.value = favorites.toList();

      // Play the selected song
      await audioPlayer.stop();
      artist.value = newArtist;
      await audioPlayer.setAsset(newArtist.songUrl);
      await audioPlayer.play();
      isPlaying.value = true;
      currentPosition.value = Duration.zero;
    } catch (e) {
      print("Error playing favorite song: $e");
      isPlaying.value = false;
    }
  }
  // Comprehensive method to select and play a song
  Future<void> selectAndPlaySong(Artist newArtist) async {
    try {
      // Stop current playback
      await audioPlayer.stop();

      // Update current artist
      artist.value = newArtist;

      // Set and play the new song
      await audioPlayer.setAsset(newArtist.songUrl);
      await audioPlayer.play();

      // Update playing state
      isPlaying.value = true;

      // Reset position
      currentPosition.value = Duration.zero;

      // Ensure the song is in the playlist
      if (!songList.any((a) => a.songUrl == newArtist.songUrl)) {
        songList.add(newArtist);
      }
    } catch (e) {
      print("Error selecting and playing song: $e");
      isPlaying.value = false;
    }
  }

  // Play song from URL
  Future<void> playSong(String songUrl) async {
    try {
      await audioPlayer.setAsset(songUrl);
      await audioPlayer.play();
      isPlaying.value = true;
    } catch (e) {
      print("Error playing song: $e");
      isPlaying.value = false;
    }
  }

  // Pause current song
  Future<void> pauseSong() async {
    await audioPlayer.pause();
    isPlaying.value = false;
  }

  // Resume current song
  Future<void> resumeSong() async {
    await audioPlayer.play();
    isPlaying.value = true;
  }

  // Seek to a specific position in the song
  Future<void> seekSong(double value) async {
    final position = Duration(
        seconds: (value * songDuration.value.inSeconds).toInt()
    );
    await audioPlayer.seek(position);
  }

  // Navigate to next song
  void nextSong() {
    if (songList.isEmpty) return;

    if (isShuffle.value) {
      // If shuffle is on, pick a random song
      final random = Random();
      final nextIndex = random.nextInt(songList.length);
      selectAndPlaySong(songList[nextIndex]);
    } else {
      // Normal sequential navigation
      final currentIndex = songList.indexOf(artist.value);
      final nextIndex = (currentIndex + 1) % songList.length;
      selectAndPlaySong(songList[nextIndex]);
    }
  }

  // Navigate to previous song
  void previousSong() {
    if (songList.isEmpty) return;

    final currentIndex = songList.indexOf(artist.value);
    final previousIndex = (currentIndex - 1) < 0
        ? songList.length - 1
        : currentIndex - 1;
    selectAndPlaySong(songList[previousIndex]);
  }

  // Get current song details
  Artist getCurrentSong() {
    return artist.value;
  }

  // Initialization
  @override
  void onInit() {
    super.onInit();

    // Populate song list
    songList.assignAll(dummyArtists);

    // Start with first song if list is not empty
    if (songList.isNotEmpty) {
      selectAndPlaySong(songList.first);
    }

    // Listen to position stream
    audioPlayer.positionStream.listen((newPosition) {
      currentPosition.value = newPosition;
    });

    // Listen to duration stream
    audioPlayer.durationStream.listen((newDuration) {
      if (newDuration != null) {
        songDuration.value = newDuration;
      }
    });

    // Comprehensive player state management
    audioPlayer.playerStateStream.listen((playerState) {
      // Update playing state
      isPlaying.value = playerState.playing;

      // Automatic next song when current track ends
      if (playerState.processingState == ProcessingState.completed) {
        nextSong();
      }
    });

    // Error and interruption handling
    audioPlayer.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.idle) {
        // Handle any playback interruptions
        isPlaying.value = false;
      }
    });
  }

  // Cleanup
  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}