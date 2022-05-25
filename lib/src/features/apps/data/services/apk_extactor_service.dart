import 'dart:io';

class ApkExtractorSerivce {
  Future<String> extractApk(
      String sourcePath, String destDir, String name) async {
    final File source = File(sourcePath);
    final File newFile = File('$destDir/$name.apk');
    await newFile.create();
    await source.copy('$destDir/$name.apk');
    return newFile.absolute.path;
  }
}
