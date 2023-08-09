class MediaSource
{
   MediaSource({
    required this.sourceName,
    required this.mediaGroup,
    required this.primaryLabel,
    required this.secondaryLabel,
  });

  final String sourceName;
  late String sourceID;

  final MediaGroups mediaGroup;

  final MediaLabels primaryLabel;

  final MediaLabels secondaryLabel;

  //List of sources

  //Map of sorted music

void deleteSource()
  {

  }

   void generateID ()
   {
     sourceID = "${DateTime.timestamp()}_$sourceName";
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
