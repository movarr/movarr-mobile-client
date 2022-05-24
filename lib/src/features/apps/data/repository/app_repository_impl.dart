import 'package:movarr/src/features/apps/data/services/device_apps_service.dart';
import 'package:movarr/src/features/apps/entities/application_entity.dart';

import '../../domain/apps_repository.dart';

class AppsRepositoryImpl implements AppsRepository {
  late DeviceAppsService _deviceAppsService;
  AppsRepositoryImpl() {
    _deviceAppsService = DeviceAppsService();
  }
  @override
  Future<List<ApplicationEntity>> getInstalledApps() async {
    final apps = await _deviceAppsService.getInstalledApplications();
    final List<ApplicationEntity> entities = apps.map((e) {
      final ApplicationEntity entity = ApplicationEntity(
          name: e.appName, packageName: e.packageName, image: e.icon);
      return entity;
    }).toList();
    return entities;
  }
}
