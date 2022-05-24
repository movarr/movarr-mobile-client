import '../entities/application_entity.dart';

abstract class AppsRepository {
  Future<List<ApplicationEntity>> getInstalledApps();
}
