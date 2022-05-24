import 'dart:typed_data';

class ApplicationEntity {
  final String name;
  final String packageName;
  final Uint8List image;
  const ApplicationEntity({
    required this.name,
    required this.packageName,
    required this.image,
  });

  @override
  String toString() =>
      'ApplicationEntity(name: $name, packageName: $packageName, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApplicationEntity &&
        other.name == name &&
        other.packageName == packageName &&
        other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ packageName.hashCode ^ image.hashCode;
}
