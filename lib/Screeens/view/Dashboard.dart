import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/Screeens/view/LibraryScreen.dart';
import 'package:spotify_clone/Screeens/view/SearchScreen.dart';
import 'package:spotify_clone/Screeens/view/song.dart';

import '../../Controllers/SongController.dart';
import '../../Model/DummyData.dart';

class DashboardController extends GetxController {
  final RxList<Color> boxColors = [Colors.grey, Colors.grey, Colors.grey].obs;
  final AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var artist = Artist(
    songName: 'Song Name',
    artistName: 'Artist Name',
    albumImage: 'assets/images/default.jpg',
    songUrl: 'assets/music/default.mp3',
  ).obs;

  void updateBoxColor(int index) {
    for (int i = 0; i < boxColors.length; i++) {
      boxColors[i] = (i == index) ? Colors.green : Colors.grey;
    }
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DashboardController _controller = Get.put(DashboardController());

  int _selectedIndex = 0;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 60.0,
                backgroundColor: Colors.black,
                pinned: true,
                stretch: true,
                leading: IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 17,
                    child: Text(
                      'P',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 130),
                    child: Row(
                      children: List.generate(
                        3,
                            (index) => GestureDetector(
                          onTap: () {
                            _controller.updateBoxColor(index);
                          },
                          child: Obx(
                                () => Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: _controller.boxColors[index],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                ['All', 'Music', 'Podcasts'][index],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Favorites',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() {
                        final songPlayerController = Get.find<SongPlayerController>();

                        // If no favorites, return an empty container
                        if (songPlayerController.favorites.isEmpty) {
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'No favorites added yet',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          );
                        }

                        // Display favorites
                        return Row(
                          children: songPlayerController.favorites.map((artist) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      final songPlayerController = Get.find<SongPlayerController>();
                                      // Use the new method for playing from favorites
                                      songPlayerController.selectAndPlaySongFromFavorites(artist);
                                      Get.to(() => Song(artist: artist));
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(artist.albumImage),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    artist.artistName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'To get you started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dummyArtists.map((artist) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    final songPlayerController = Get.find<SongPlayerController>();
                                    songPlayerController.selectAndPlaySong(artist);
                                    Get.to(() => Song(artist: artist));
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(artist.albumImage),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  artist.artistName,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Try something else',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dummyArtists.map((artist) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    final songPlayerController = Get.find<SongPlayerController>();
                                    songPlayerController.selectAndPlaySong(artist);
                                    Get.to(() => Song(artist: artist));
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(artist.albumImage),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  artist.artistName,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Recommended for today',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dummyArtists.map((artist) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    final songPlayerController = Get.find<SongPlayerController>();
                                    songPlayerController.selectAndPlaySong(artist);
                                    Get.to(() => Song(artist: artist));
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(artist.albumImage),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  artist.artistName,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Today\'s big hit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dummyArtists.map((artist) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    final songPlayerController = Get.find<SongPlayerController>();
                                    songPlayerController.selectAndPlaySong(artist);
                                    Get.to(() => Song(artist: artist));
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(artist.albumImage),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  artist.artistName,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),


                  ],
                ),
              ),
            ],
          ),
          // Playback Bar
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey[900],
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Obx(() {
                final songPlayerController = Get.find<SongPlayerController>();
                return InkWell(onTap: (){
                  Get.to(() => Song(artist: songPlayerController.artist.value));
                },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(songPlayerController.artist.value.albumImage),
                            radius: 20,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                songPlayerController.artist.value.songName,
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                songPlayerController.artist.value.artistName,
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          if (songPlayerController.isPlaying.value) {
                            songPlayerController.pauseSong();
                          } else {
                            songPlayerController.resumeSong();
                          }
                        },
                        icon: Icon(
                          songPlayerController.isPlaying.value ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black.withOpacity(0.8),
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey[800],
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: InkWell(onTap: () {
                    Get.to(Dashboard());
                  }, child: Icon(Icons.home)),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                      onTap: () {
                        Get.to(Searchscreen());
                      },
                      child: Icon(Icons.search)),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                      onTap: () {
                        Get.to(Libraryscreen());
                      },
                      child: Icon(Icons.library_music)),
                  label: "Library",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.workspace_premium),
                  label: "Premium",
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  'P',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              title: Text(
                'Prerit',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'view profile',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add, color: Colors.white),
              title: Text('Add account', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
