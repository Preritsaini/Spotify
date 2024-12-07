
class Artist {
  final String artistName;
  final String songName;
  final String albumImage;
  final String songUrl;

  Artist({
    required this.artistName,
    required this.songName,
    required this.albumImage,
    required this.songUrl,
  });
}

// List of dummy artist data
final List<Artist> dummyArtists = [
  Artist(
    artistName: 'Shubh',
    songName: 'You and Me',
    albumImage: 'assets/images/shubh.jpeg',
    songUrl: 'assets/audio/you.mp3',
  ),
  Artist(
    artistName: 'Rashmeet Kaur',
    songName: 'Ishq Nachave',
    albumImage: 'assets/images/Nimrat.jpeg',
    songUrl: 'assets/audio/ishqnachave.mp3',
  ),
  Artist(
    artistName: 'Citizen',
    songName: 'You haunt me',
    albumImage: 'assets/images/citizen.jpeg',
    songUrl: 'assets/audio/yoyhauntme.mp3',
  ),
  Artist(
    artistName: 'The Weeknd',
    songName: 'Moth To Flame',
    albumImage: 'assets/images/weeknd.jpeg',
    songUrl: 'assets/audio/flame.mp3',
  ),
  Artist(
    artistName: 'Billie Eillish',
    songName: 'Wilflower',
    albumImage: 'assets/images/Billie.jpeg',
    songUrl: 'assets/audio/wildflower.mp3',
  ),
  Artist(
    artistName: 'Parmish Verma',
    songName: 'Aam Jahe Munde',
    albumImage: 'assets/images/parmish.jpeg',
    songUrl: 'assets/audio/aamjahemunde.mp3',
  ),
  Artist(
    artistName: 'Diljit Dosanjh',
    songName: 'Born to Shine',
    albumImage: 'assets/images/diljit.jpeg',
    songUrl: 'assets/audio/borntoshine.mp3',
  ),
  Artist(
    artistName: 'AP Dhillon',
    songName: 'With You',
    albumImage: 'assets/images/ap.jpeg',
    songUrl: 'assets/audio/withyou.mp3',
  ),
  Artist(
    artistName: 'Karan Aujla',
    songName: 'Softly',
    albumImage: 'assets/images/karan.jpeg',
    songUrl: 'assets/audio/softly.mp3',
  ),
  Artist(
    artistName: 'Yo Yo Honey Singh',
    songName: 'Millionare',
    albumImage: 'assets/images/honey.jpeg',
    songUrl: 'assets/audio/millionare.mp3',
  ),
];
