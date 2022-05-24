import 'package:device_apps/device_apps.dart';

class DeviceAppsService {
  Future<List<ApplicationWithIcon>> getInstalledApplications() async {
    final List<ApplicationWithIcon> list =
        await DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            includeSystemApps: false) as List<ApplicationWithIcon>;
    return list;
  }
}
