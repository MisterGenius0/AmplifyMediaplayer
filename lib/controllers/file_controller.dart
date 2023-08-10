import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;


List<Directory> findAudioFilesInDirectory(String URL) {
  Directory dir = Directory(URL);
  List<Directory> ReturnedFiles = [];

  dir.list(recursive: true, followLinks: true).listen((file) {
    if(file is File)
    {
      // print(event.toString());

      String Exstension = path.extension(file.path).toLowerCase();

      if(Exstension == ".mp3" || Exstension == ".wav" || Exstension == ".flac" || Exstension == ".m4a")
      {
        ReturnedFiles.add(Directory(file.path));
        print(file.path);
      }
    }

  });
  return ReturnedFiles;
}


//Starts
Future<String?> PickDirectory() async {
  String? result = await FilePicker.platform.getDirectoryPath(dialogTitle: "Test");
  if (result != null) {
    print(result);
    return result;
  }
  return null;
}