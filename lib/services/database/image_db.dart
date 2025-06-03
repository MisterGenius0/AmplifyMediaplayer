import 'package:flutter/foundation.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;

import 'base_db.dart';

class ImageDBModel extends BaseDBModel {
  ImageDBModel();

  @override
  String get dbName => "Images cache";

  Future<void> createImageTable() async {
    sqflite.Database db = await loadDB();
    await db.transaction((txn) async {
      txn.execute('''
    CREATE TABLE  IF NOT EXISTS 'Images' (
        id INTEGER NOT NULL PRIMARY KEY,  
        imageID INTEGER,
        image BLOB
    ); ''');
    });
  }

  Future<Uint8List?>findImageByID(int imageID, String filePath) async
  {
    sqflite.Database db = await loadDB();
    await createImageTable();

    List<Map<String, Object?>> image = [];
    Uint8List? result;
    await db.transaction((txn) async {
      image = await txn
          .rawQuery('''SELECT image FROM Images WHERE imageID=$imageID ''');
    });

     // await mediaDB.transaction((txn2) async{
      if(image.isEmpty) {
        Metadata metadata = await MetadataGod.readMetadata(file: filePath);
        addImageToTable(metadata.picture);
        result = metadata.picture?.data;
        return result;
      }
      else
      {
        result = image.first["image"] as Uint8List;
        return result;
      }
  }


  Future<int?> addImageToTable(Picture? image) async {

    sqflite.Database db = await loadDB();
    await createImageTable();
    int? imageID = image?.data.reduce((value, element) => value+element);

    db.transaction((txn) async {
      List<Map<String, Object?>> imageData = await txn
          .rawQuery('''SELECT imageID FROM Images WHERE imageID = $imageID ''');

      if (imageData.isEmpty && image?.data != null) {
        txn.rawInsert('''INSERT INTO  Images (
        imageID,
        image
        ) VALUES (?,?)''', [
          imageID,
          image?.data
        ]);
        if (kDebugMode) {
          print("Saved Image ID: $imageID");
        }
      }
    });
    return imageID;
  }
}
