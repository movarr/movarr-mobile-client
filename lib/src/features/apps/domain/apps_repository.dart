import '../entities/application_entity.dart';

abstract class AppsRepository {
  Future<List<ApplicationEntity>> getInstalledApps();
  Future<void> backupInstalledApps(List<ApplicationEntity> apps);
}
