//TAKEN FROM: https://processing.org/examples/directorylist.html
import java.util.Date;

class DirectoryReader{

  // This function returns all the files in a directory as an array of Strings  
  String[] listFileNames(String dir) {
    // println("dir: "+dir);
    File file = new File(dir);
    if (file.isDirectory()) {
      String names[] = file.list();
      return names;
    } else {
      // If it's not a directory
      println("not dir");
      return null;
    }
  }
  void println_files(File[] files) {
    for (int i = 0; i < files.length; i++) {
      File f = files[i];    
      println("Name: " + f.getName());
      println("Is directory: " + f.isDirectory());
      println("Size: " + f.length());
      String lastModified = new Date(f.lastModified()).toString();
      println("Last Modified: " + lastModified);
      println("-----------------------");
    }
    
  }
  // This function returns all the files in a directory as an array of File objects
  // This is useful if you want more info about the file
  File[] listFiles(String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      File[] files = file.listFiles();
      return files;
    } else {
      // If it's not a directory
      return null;
    }
  }

  // Function to get a list of all files in a directory and all subdirectories
  ArrayList<File> listFilesRecursive(String dir) {
     ArrayList<File> fileList = new ArrayList<File>(); 
     recurseDir(fileList,dir);
     return fileList;
  }

  // Recursive function to traverse subdirectories
  void recurseDir(ArrayList<File> a, String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      // If you want to include directories in the list
      a.add(file);  
      File[] subfiles = file.listFiles();
      for (int i = 0; i < subfiles.length; i++) {
        // Call this function on all files in this directory
        recurseDir(a,subfiles[i].getAbsolutePath());
      }
    } else {
      a.add(file);
    }
  }
}
