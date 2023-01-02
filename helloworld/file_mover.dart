import 'dart:io';
import 'package:path/path.dart' as path;



class FileMover {
  //The property holder the current directory path from the cli
  Directory currentDirectory;

  FileMover(String folderPath){
    this.currentDirectory = Directory(folderPath);

  }

  void _move(String foldername, File file) async {
    try{
      await Directory(foldername).create( recursive: true);
      File _file = file;
      await _file.copy(path.join(foldername, path.basename(file.path)));
      print('Copied ${file.path} to the new $foldername');
      await  _file.delete();
    }
    on FileSystemException catch (e) {
      print ('Failed to create the Folder [${e.toString()}]');
    }
    on IOException catch (e){
      print ('Failed to create the Folder [${e.toString()}]');
    }
  }

  void arrange() async{
    Stream<FileSystemEntity> lists = await this.currentDirectory.list(followLinks: false,recursive: false);
   await for (FileSystemEntity file in lists){
      // Get the extension of the current file
     if(FileSystemEntity.isFile(file.path) != null){
        final String currentFileExtension = path.extension(file.path);
        switch(currentFileExtension){
          case '.pdf':
            String pdfFolderPath = "/home/x64/Downloads/pdf/";
            _move(pdfFolderPath, file);
            break;

          case '.zip':
          case '.rar':
          case '.gz':
            String pdfFolderPath = "/home/x64/Downloads/compressed/";
            _move(pdfFolderPath, file);
            break;

          case '.docx':
          case '.csv':
          case '.xlsx':
          case '.pptx':
            String pdfFolderPath = "/home/x64/Downloads/docs/";
            _move(pdfFolderPath, file);
            break;

          case '.jpeg':
          case '.png':
          case '.jpg':
          case '.svg':
          case '.webp':
            String pdfFolderPath = "/home/x64/Downloads/images/";
            _move(pdfFolderPath, file);
            break;

          case '.webm':
          case '.mp4':
            String pdfFolderPath = "/home/x64/Downloads/webm/";
            _move(pdfFolderPath, file);
            break;

          case '.appImage':
            String pdfFolderPath = "/home/x64/Downloads/Linux_Apps/";
            _move(pdfFolderPath, file);
            break;

          case '.sql':
            String pdfFolderPath = "/home/x64/Downloads/DB_Files/";
            _move(pdfFolderPath, file);
            break;

          case '.txt':
            String pdfFolderPath = "/home/x64/Downloads/notes/";
            _move(pdfFolderPath, file);
            break;




        }
     }

   }
  }

}


void main(){
  // Run the application
  FileMover fileMover = FileMover("/home/x64/Downloads/");
  fileMover.arrange();


}