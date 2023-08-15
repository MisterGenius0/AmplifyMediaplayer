class MediaSource
{
   MediaSource({
    required this.sourceName,
    required this.mediaGroup,
    required this.primaryLabel,
    required this.secondaryLabel,
     required this.sourceDirectorys,
  });

  final String sourceName;
  late String sourceID = "";

  final MediaGroups mediaGroup;

  final MediaLabels primaryLabel;

  final MediaLabels secondaryLabel;

  final List<String> sourceDirectorys;

  //List of sources

  //Map of sorted music

void deleteSource()
  {

  }

   void generateID ()
   {
     sourceID = "${DateTime.timestamp()}";
   }
}

enum MediaGroups {
  album,
  artest,
  year,
  genre,
  albumArtest,
  composer
}

enum MediaLabels {
  artestCount,
  albumCount,
  totalTime,
  songCount,
  yearRange,
  genreCount,
  albumArtestCount,
  composerCount,
  discNumbers,
}
