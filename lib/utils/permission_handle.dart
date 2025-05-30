import 'package:clip_cuts/routes/navigation_services.dart';
import 'package:flutter/Material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> askPermissions() async {
  try {
    PermissionStatus permissionStatusOfMediaLibrary = await getMediaLibraryPermission();
    PermissionStatus permissionStatusOfCamera = await getCameraPermission();

    if (permissionStatusOfMediaLibrary != PermissionStatus.granted) {
      handleInvalidPermissions(permissionStatusOfMediaLibrary);
    }

    if (permissionStatusOfCamera != PermissionStatus.granted) {
      handleInvalidPermissions(permissionStatusOfCamera);
    }

  } catch (e) {
    debugPrint("AskPermissionsError :- ${e.toString()}");
  }
}

Future<PermissionStatus> getMediaLibraryPermission() async {
  PermissionStatus permission = await Permission.photos.status;
  if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.photos.request();
    if (permissionStatus.isGranted) {
      debugPrint("Access to photos is granted.");
    }
    return permissionStatus;
  } else {
    return permission;
  }
}

Future<PermissionStatus> getCameraPermission() async {
  PermissionStatus permission = await Permission.camera.status;
  if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      debugPrint("Access to camera is granted.");
    }
    return permissionStatus;
  } else {
    return permission;
  }
}

Future<void> handleInvalidPermissions(PermissionStatus permissionStatus) async {
  if (permissionStatus == PermissionStatus.denied) {
    const SnackBar(content: Text('Permission Denied'));
    showToastMsg();
  } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
    const SnackBar(content: Text('Please enable permission in your device settings.'));
    showToastMsg();
    Future.delayed(Duration(seconds: 3), () async {
      await openAppSettings();
    });
  }

  debugPrint("permissionStatus=>$permissionStatus");
}

void showToastMsg(){
  ScaffoldMessenger.of(NavigatorService.navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text('Permission denied. Please grant permission to continue.'),
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 3),
    ),
  );
}