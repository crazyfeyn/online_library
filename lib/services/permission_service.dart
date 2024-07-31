import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestStoragePermission() async {
    final isGranted = await Permission.storage.isGranted;
    if (!isGranted) {
      await Permission.storage.request();
    }

    return isGranted;
  }
}
