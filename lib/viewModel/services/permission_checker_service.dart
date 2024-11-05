import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionServices {
  /// Check the status of a specific permission.
  Future<PermissionStatus> checkPermission(Permission permission) async {
    return await permission.status;
  }

  /// Request a specific permission.
  Future<bool> requestPermission(Permission permission) async {
    PermissionStatus status = await permission.request();
    return status.isGranted;
  }

  /// Check and request permission if it is denied.
  Future<bool> checkAndRequestPermission(Permission permission, BuildContext context) async {
    PermissionStatus status = await checkPermission(permission);

    if (status.isGranted) {
      return true; // Permission granted
    } else if (status.isDenied) {
      bool isGranted = await requestPermission(permission);
      if (isGranted) {
        return true; // Permission granted after request
      } else {
        _showPermissionDeniedDialog(context, permission);
        return false; // Permission denied
      }
    } else if (status.isPermanentlyDenied) {
      _showOpenSettingsDialog(context);
      return false; // Permission permanently denied
    }

    return false; // Other cases (like restricted)
  }

  /// Show a dialog to inform the user about the denied permission.
  void _showPermissionDeniedDialog(BuildContext context, Permission permission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text('This app needs ${permission.toString().split('.').last} permission to function properly.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Show a dialog that redirects the user to app settings.
  void _showOpenSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Permanently Denied'),
          content: Text('Please enable permissions in the app settings.'),
          actions: [
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
