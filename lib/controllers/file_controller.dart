import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class FileController
{
  Future<void>  findAudioFilesInDirectory({required String url, ValueChanged<Iterable<Directory>>? onFinished,  ValueChanged<String>? onError }) async {
    final hasStorageAccess = Platform.isAndroid ? await Permission.audio.isGranted : true;
    if(!hasStorageAccess){
    await Permission.audio.request();
    if(!await Permission.audio.isGranted){
    return ;
    }
    }

    Directory dir = Directory(url);

    List<Directory> returnedFiles = [];

    dir.list(recursive: true, followLinks: true).listen((file) {
      if(file is File)
      {
        // print(event.toString());

        String exstension = path.extension(file.path).toLowerCase();

        if(exstension == ".mp3" || exstension == ".wav" || exstension == ".flac" || exstension == ".m4a")
        {
          returnedFiles.add(Directory(file.path));
          //print("Found Song: ${file.path}");
        }
      }

    }, onDone: (){
      onFinished!(returnedFiles);
    },
    onError: (e){
      print(e);
    });
  }


//Start
  Future<String?> pickDirectory() async {

    final hasStorageAccess = Platform.isAndroid ? await Permission.audio.isGranted : true;
    if(!hasStorageAccess){
      await Permission.audio.request();
      if(!await Permission.audio.isGranted){
        print("no permission");
        return "";
      }
    }

    String? result = await FilePicker.platform.getDirectoryPath(dialogTitle: "Test");

    if (result != null) {
      return result;
    }
    return null;
  }
}

