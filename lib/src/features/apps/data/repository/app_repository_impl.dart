import 'dart:io';
import 'package:movarr/src/features/apps/data/services/apk_extactor_service.dart';
import 'package:movarr/src/features/apps/data/services/device_apps_service.dart';
import 'package:movarr/src/features/apps/entities/application_entity.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/apps_repository.dart';

class AppsRepositoryImpl implements AppsRepository {
  late DeviceAppsService _deviceAppsService;
  late ApkExtractorSerivce _apkExtractorSerivce;
  AppsRepositoryImpl() {
    _deviceAppsService = DeviceAppsService();
    _apkExtractorSerivce = ApkExtractorSerivce();
  }

  @override
  Future<List<ApplicationEntity>> getInstalledApps() async {
    final apps = await _deviceAppsService.getInstalledApplications();
    final List<ApplicationEntity> entities = apps.map((e) {
      final ApplicationEntity entity = ApplicationEntity(
          version: e.versionName! + e.versionCode.toString(),
          sourceApkPath: e.apkFilePath,
          name: e.appName,
          packageName: e.packageName,
          image: e.icon);
      return entity;
    }).toList();
    backupInstalledApps(entities);
    return entities;
  }

  @override
  Future<void> backupInstalledApps(List<ApplicationEntity> apps) async {
    final int length = apps.length;
    final backupPath = await _createAppBackupDir();
    for (int i = 0; i < length; i++) {
      final String name = apps[i].packageName + apps[i].version;
      await _apkExtractorSerivce.extractApk(
          apps[i].sourceApkPath, backupPath, name);
    }
  }

  Future<String> _createAppBackupDir() async {
    // TODO: Maybe move this creation of directory into shared folder
    final DateTime currentTime = DateTime.now();
    final Directory? dir = await getExternalStorageDirectory();
    final appExternalStorage = Directory(
        '${dir!.path}/movarr/backup-(${currentTime.month}-${currentTime.day}-${currentTime.hour})');
    final bool dirExists = await appExternalStorage.exists();
    if (!dirExists) {
      await appExternalStorage.create(recursive: true);
    }
    return appExternalStorage.path;
  }
}
