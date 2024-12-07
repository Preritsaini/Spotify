import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/Screeens/view/Dashboard.dart';
import 'package:spotify_clone/Screeens/view/LibraryScreen.dart';
import 'package:spotify_clone/Screeens/view/PremiumScreen.dart';
import 'package:spotify_clone/Screeens/view/song.dart';
import '../../Controllers/artistcontroller.dart';
import '../../Model/DummyData.dart';

class Searchscreen extends StatefulWidget {
  Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  List<String> Dibbe = ['Podcast', 'Live Events', 'Made For You', 'Songs'];
  final _searchController = ArtistSearchController(); // Initialize controller
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              'P',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
        title: Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Autocomplete<Artist>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return _searchController.searchArtists(textEditingValue.text);
                },
                displayStringForOption: (Artist artist) => artist.artistName,
                onSelected: (Artist selectedArtist) {
                  // Navigate to the song screen when an artist is selected
                  Get.to(() => Song(artist: selectedArtist));
                },
                fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: "What do you want to listen to?",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Start Browsing',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 15, // Horizontal spacing between items
                      runSpacing: 15, // Vertical spacing between rows
                      children: List.generate(
                        Dibbe.length,
                            (index) => Container(
                          height: 80,
                          width: 180,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              Dibbe[index], // Add the corresponding text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
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
            icon: InkWell(
              onTap: () {
                Get.to(Dashboard());
              },
              child: Icon(Icons.home),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(Searchscreen());
              },
              child: Icon(Icons.search),
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(Libraryscreen());
              },
              child: Icon(Icons.book_outlined),
            ),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(Premiumscreen());
              },
              child: Icon(Icons.workspace_premium),
            ),
            label: "Premium",
          ),
        ],
      ),
    );
  }
}
