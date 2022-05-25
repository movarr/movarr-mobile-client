import 'dart:typed_data';

class ApplicationEntity {
  final String name;
  final String packageName;
  final String version;
  final Uint8List image;
  final String sourceApkPath;
  const ApplicationEntity({
    required this.name,
    required this.packageName,
    required this.version,
    required this.image,
    required this.sourceApkPath,
  });

  @override
  String toString() {
    return 'ApplicationEntity(name: $name, packageName: $packageName, version: $version, image: $image, sourceApkPath: $sourceApkPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ApplicationEntity &&
      other.name == name &&
      other.packageName == packageName &&
      other.version == version &&
      other.image == image &&
      other.sourceApkPath == sourceApkPath;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      packageName.hashCode ^
      version.hashCode ^
      image.hashCode ^
      sourceApkPath.hashCode;
  }
}
