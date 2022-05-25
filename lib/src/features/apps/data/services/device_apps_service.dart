import 'package:device_apps/device_apps.dart';

class DeviceAppsService {
  Future<List<ApplicationWithIcon>> getInstalledApplications() async {
    final List<Application> list = await DeviceApps.getInstalledApplications(
        includeAppIcons: true, includeSystemApps: false);
    return list.map((e) => e as ApplicationWithIcon).toList();
  }
}
