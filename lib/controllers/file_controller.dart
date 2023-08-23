import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

class FileController
{
  void  findAudioFilesInDirectory({required String url, ValueChanged<Iterable<Directory>>? onFinished,  ValueChanged<String>? onError }){
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
          print(file.path);
        }
      }

    }, onDone: (){
      onFinished!(returnedFiles);
    },
    onError: (e){
      onError!(e);
    });
  }


//Starts
  Future<String?> pickDirectory() async {
    String? result = await FilePicker.platform.getDirectoryPath(dialogTitle: "Test");

    if (result != null) {
      print(result);
      return result;
    }
    return null;
  }
}

