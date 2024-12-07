import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/SongController.dart';
import '../../Model/DummyData.dart';
import '../../Utils.dart';

class Song extends StatefulWidget {
  final Artist artist;

  const Song({Key? key, required this.artist}) : super(key: key);

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  final SongPlayerController songPlayerController = Get.find<SongPlayerController>();

  @override
  void initState() {
    super.initState();
    // Ensure the selected song is playing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      songPlayerController.selectAndPlaySong(widget.artist);
    });
  }

  // Utility function to format the time
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Container(
              height: screenHeight(1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){ Get.back();},
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Playing the album',
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),

                  // Album Art
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 80),
                    child: Container(
                      height: screenHeight(0.4),
                      width: screenWidth(1),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            songPlayerController.artist.value.albumImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Song Info
                  ListTile(
                    title: Text(
                      songPlayerController.artist.value.songName,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      songPlayerController.artist.value.artistName,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        // Add the current song to favorites
                        songPlayerController.addToFavorites(songPlayerController.artist.value);
                        Get.snackbar(
                          "Added to Favorites",
                          "${songPlayerController.artist.value.songName} added!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                    ),
                  ),
                  // Slider for song progress
                  Obx(() {
                    final position = songPlayerController.currentPosition.value;
                    final duration = songPlayerController.songDuration.value;

                    return Column(
                      children: [
                        Slider(
                          value: position.inSeconds.toDouble(),
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,
                          onChanged: (newValue) {
                            songPlayerController.seekSong(
                              newValue / duration.inSeconds.toDouble(),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatDuration(position),
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                formatDuration(duration),
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                  // Playback Controls
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Shuffle Button
                        IconButton(
                          onPressed: () {
                            songPlayerController.toggleShuffle(); // Toggle shuffle state
                          },
                          icon: Icon(
                            Icons.shuffle,
                            color: songPlayerController.isShuffle.value
                                ? Colors.green // Green when shuffle is active
                                : Colors.white, // Default color when shuffle is inactive
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () => songPlayerController.previousSong(),
                          icon: Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Obx(() {
                          return IconButton(
                            onPressed: () {
                              if (songPlayerController.isPlaying.value) {
                                songPlayerController.pauseSong();
                              } else {
                                songPlayerController.resumeSong();
                              }
                            },
                            icon: Icon(
                              songPlayerController.isPlaying.value
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                              color: Colors.white,
                              size: 50,
                            ),
                          );
                        }),
                        IconButton(
                          onPressed: () => songPlayerController.nextSong(),
                          icon: Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            songPlayerController.toggleLoop();

                          },

                          icon: Icon(
                            Icons.repeat,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
