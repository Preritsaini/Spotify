import 'package:get/get.dart';
import '../Model/DummyData.dart'; // Import your DummyData file

class ArtistSearchController extends GetxController {
  // Holds the dummy artist data
  final artists = dummyArtists;

  // Function to filter artists based on the search querry
  List<Artist> searchArtists(String query) {
    if (query.isEmpty) {
      return [];
    }
    return artists
        .where((artist) => artist.artistName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
