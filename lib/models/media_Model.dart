import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:metadata_god/metadata_god.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Media
{

   Media({
    required this.mediaPath,
     required this.iD,
  });

  final Directory mediaPath;
   final String? iD;
   late Metadata metadata;

  Future<void> saveMetadata()
  async {
    MetadataGod.initialize();
    metadata = await MetadataGod.readMetadata(file: mediaPath.path);
    var prefs = await SharedPreferences.getInstance();

    prefs.setString("${iD}_${mediaPath}_album", metadata.album ?? "");
    List<String> list = prefs.getStringList("${iD}_media") ??  [];
    list.add("${iD}_${mediaPath}");

    prefs.setStringList("${iD}_media", list);


    //save path
    prefs.setString("${iD}_${mediaPath}_path", mediaPath.path);

    //Save metadata

    //Title
    prefs.setString("${iD}_${mediaPath}_title", metadata.title ?? "");

    //GetDurationMs
    prefs.setDouble("${iD}_${mediaPath}_durationMs", metadata.durationMs ?? 0);

    //GetArtist
    prefs.setString("${iD}_${mediaPath}_artist", metadata.artist ?? "");

    //Album
    prefs.setString("${iD}_${mediaPath}_album", metadata.album ?? "");

    //AlbumArtist
    prefs.setString("${iD}_${mediaPath}_albumArtist", metadata.albumArtist ?? "");

    //TrackNumber
    prefs.setInt("${iD}_${mediaPath}_trackNumber", metadata.trackNumber ?? 0);

    //TrackTotal
    prefs.setInt("${iD}_${mediaPath}_trackTotal", metadata.trackTotal ?? 0);

    //DiscNumber
    prefs.setInt("${iD}_${mediaPath}_discNumber", metadata.discNumber ?? 0);

    //DiscTotal
    prefs.setInt("${iD}_${mediaPath}_discTotal", metadata.discTotal ?? 0);

    //Year
    prefs.setInt("${iD}_${mediaPath}_year", metadata.year ?? 0);

    //Genre
    prefs.setString("${iD}_${mediaPath}_genre", metadata.genre ?? "");

    //Picture
    if(metadata.picture != null)
      {
      //  prefs.setStringList("${iD}_${mediaPath}_pictureData", metadata.picture!.data.toList().map((e) => e.toString()).toList());
    //    prefs.setString("${iD}_${mediaPath}_pictureMineType",  metadata.picture?.mimeType ??  "");
      }

    //FileSize
    prefs.setInt("${iD}_${mediaPath}_fileSize", metadata.fileSize ?? 0);

    print("Saved: ${metadata.title}");
  }

  Future<String?> getTitle()
   async {
     var prefs = await SharedPreferences.getInstance();
   return prefs.getString("${iD}_${mediaPath}_title");
}
   Future<double?> getDurationMs()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getDouble("${iD}_${mediaPath}_durationMs");
   }

   Future<String?> getArtist()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getString("${iD}_${mediaPath}_artist");
   }

   Future<String?> getAlbum()
   async {
     var prefs = await SharedPreferences.getInstance();
     print("${iD}_${metadata.album}_album");
     return prefs.getString("${iD}_${mediaPath}_album");
   }

   Future<String?> getAlbumArtist()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getString("${iD}_${mediaPath}_albumArtist");
   }

   Future<int?> getTrackNumber()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getInt("${iD}_${mediaPath}_trackNumber");
   }

   Future<int?> getTrackTotal()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getInt("${iD}_${mediaPath}_trackTotal");
   }

   Future<int?> getDiscNumber()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getInt("${iD}_${mediaPath}_discNumber");
   }

   Future<int?> getDiscTotal()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getInt("${iD}_${mediaPath}_discTotal");
   }

   Future<int?> getYear()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getInt("${iD}_${mediaPath}_year");
   }

   Future<String?> getGenre()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getString("${iD}_${mediaPath}_genre");
   }

   Future<Picture?> Getpicture()
   async {
    print("GetPicture is not implemented yet :)");
    var prefs = await SharedPreferences.getInstance();

    List<int>? pictureData =  prefs.getStringList("${iD}_${mediaPath}_pictureData")?.map((e) => int.parse(e)).toList();
    String? mineType = prefs.getString("${iD}_${mediaPath}_pictureMineType");

    if(pictureData == null || mineType == null)
      {
        return null;
      }
    else
      {
        //Gets image data and builds picture then returns said picture
        return   Picture(mimeType: mineType, data: Uint8List.fromList(pictureData));
      }
   }

   Future<int?> getFileSize()
   async {
     var prefs = await SharedPreferences.getInstance();
     return prefs.getInt("${iD}_${metadata.fileSize}_fileSize");
   }



}