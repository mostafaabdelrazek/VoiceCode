
import 'package:ext_storage/ext_storage.dart';
import 'dart:io';

class FileModel {
  final fileName ;
  final fileExtension;
  var _internalPath;


  FileModel(this.fileName,this.fileExtension){
    this._internalPath =   'projects/$fileName.$fileExtension';
    print('called');
    FileModel.createAppDir();
    this.createFile();
  }


  Future<String> get _localPath async {
    final path = await  ExtStorage.getExternalStorageDirectory();
    return path;
  }

  static Future createAppDir() async{
    dynamic directory = await ExtStorage.getExternalStorageDirectory();
    Directory dir =  new Directory('$directory/projects');
   // print(dir);
   // print('monako');
    if(await dir.exists()){
      return dir;
    }else {
      return dir.create();
    }
  }

  static Future getAllFiles(String fileExtension) async{
    dynamic directory = await ExtStorage.getExternalStorageDirectory();
    Directory dir =  new Directory('$directory/projects');
    List files =  dir.listSync();
   return files.where((element) => element.toString().endsWith('.$fileExtension\'')).toList();
     //return files;
  }


  Future<File> get _localFile async{
    final path = await _localPath;
    final fullPath = '$path/$_internalPath';
    return File(fullPath);
  }

  Future<File>  createFile() async{

    final path = await _localPath;
    final fullPath = '$path/$_internalPath';
    //print(fullPath);
    //print(File(fullPath).create());
    if( await File(fullPath).exists()){
      return  File(fullPath);
    }else{
      return await File(fullPath).create();
    }

  }


  Future<File> writeCounter(String content) async {
    final file = await createFile();
    // Write the file
    return await file.writeAsString('$content');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      return (contents);
    } catch (e) {
      // If encountering an error, return 0
      return '0';
    }
  }

  Future prepareFile(String welcomeMessage) async{
     return await writeCounter(welcomeMessage);
  }
}