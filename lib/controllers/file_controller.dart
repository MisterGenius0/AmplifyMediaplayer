import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class FileController {
  Future<List<Directory>> findAudioFilesInDirectory({required String url}) async {
    //TODO make this exclude sources and directorys and have it include source files
    // final hasStorageAccess = Platform.isAndroid ? await Permission.audio.isGranted : true;
    // if(!hasStorageAccess){
    // await Permission.audio.request();
    // await Permission.mediaLibrary.request();
    // if(!await Permission.mediaLibrary.isGranted){
    //   print("Android Permission Denied");
    //   await Permission.audio.request();
    //
    // await Permission.mediaLibrary.request();
    // return [];
    // }}
//TODO Permmision issue for android
    Directory dir = Directory(url);
    List<Directory> returnedFiles = [];
    await dir.list(
        recursive: true, followLinks: true).forEach((element) {
      if (element is File) {
        String extensions = path.extension(element.path).toLowerCase();
        if (extensions == ".mp3" || extensions == ".wav" ||
            extensions == ".flac" || extensions == ".m4a") {
          returnedFiles.add(Directory(element.path));
        }
      }
    });

    return returnedFiles;
  }

    //   dir.list(recursive: true, followLinks: true).listen((file) {
    //     if(file is File)
    //     {
    //       // print(event.toString());
    //
    //       String exstension = path.extension(file.path).toLowerCase();
    //
    //       if(exstension == ".mp3" || exstension == ".wav" || exstension == ".flac" || exstension == ".m4a")
    //       {
    //         returnedFiles.add(Directory(file.path));
    //         if (kDebugMode) {
    //           print("Found Song: ${file.path}");
    //         }
    //       }
    //     }
    //
    //   }, onDone: (){
    //     onFinished!(returnedFiles);
    //   },
    //   onError: (e){
    //     if (kDebugMode) {
    //       print(e);
    //     }
    //   });
    // }


//Start
    Future<String?> pickDirectory() async {
      final hasStorageAccess13 = Platform.isAndroid ? await Permission
          .mediaLibrary.isGranted : true;
      final hasStorageAccess12 = Platform.isAndroid ? await Permission
          .mediaLibrary.isGranted : true;
      String? result;

      if (!hasStorageAccess13) {
        await Permission.mediaLibrary.request();
        if (await Permission.mediaLibrary.isGranted) { //android 13
          if (kDebugMode) {
            print("Android 13");
          }
          result = await FilePicker.platform.getDirectoryPath(dialogTitle: "Select Media");
        }
      }

      if (kDebugMode) {
        print("Android 12 pre");
      }
      if (!hasStorageAccess12) {
        await Permission.mediaLibrary.request();
        //await Permission.storage.request();
        if (await Permission.mediaLibrary.isGranted) { //android 13
          if (kDebugMode) {
            print("Android 12");
          }
          result = await FilePicker.platform.getDirectoryPath(dialogTitle: "Select Media");
        }
      }
      else //everybody else
          {
        if (kDebugMode) {
          print("Other");
        }
         result = await FilePicker.platform.getDirectoryPath(dialogTitle: "Select Media");
      }

      if (result != null) {
        return result;
      }
      return null;
    }

    Future<List<String?>?> pickFile() async {
      final hasStorageAccess13 = Platform.isAndroid ? await Permission
          .mediaLibrary.isGranted : true;
      final hasStorageAccess12 = Platform.isAndroid ? await Permission
          .mediaLibrary.isGranted : true;
      FilePickerResult? result;

      if (!hasStorageAccess13) {
        await Permission.mediaLibrary.request();
        if (await Permission.mediaLibrary.isGranted) { //android 13
          if (kDebugMode) {
            print("Android 13");
          }
          result = await FilePicker.platform.pickFiles(dialogTitle: "Select Media", allowMultiple: true);
        }
      }

      if (kDebugMode) {
        print("Android 12 pre");
      }
      if (!hasStorageAccess12) {
        await Permission.mediaLibrary.request();
        //await Permission.storage.request();
        if (await Permission.mediaLibrary.isGranted) { //android 13
          if (kDebugMode) {
            print("Android 12");
          }
          result = await FilePicker.platform.pickFiles(dialogTitle: "Select Media", allowMultiple: true);
        }
      }
      else //everybody else
          {
        if (kDebugMode) {
          print("Other");
        }
        result = await FilePicker.platform.pickFiles(dialogTitle: "Select Media", allowMultiple: true);
      }

      List<String?> filePaths = [];

      if(result != null) {
        filePaths.addAll(result.paths);

        return filePaths;
      }
      return null;
    }
  }

