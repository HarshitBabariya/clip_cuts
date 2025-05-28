// import 'dart:io';
// import 'package:flutter/Material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// Future<void> askPermissions() async {
//   try {
//     PermissionStatus permissionStatusOfNotification = await getNotificationPermission();
//     PermissionStatus permissionStatusOfMediaLibrary = await getMediaLibraryPermission();
//     PermissionStatus permissionStatusOfLocation = await getLocationPermission();
//     PermissionStatus permissionStatusOfBluetooth = await getBluetoothPermission();
//     PermissionStatus permissionStatusOfBluetoothScan = await getBluetoothScanPermission();
//     PermissionStatus permissionStatusOfBluetoothConnect = await getBluetoothConnectPermission();
//     PermissionStatus permissionStatusOfStorage = await getStoragePermission();
//     PermissionStatus permissionStatusOfManageStorage = await getManageStoragePermission();
//
//     if (permissionStatusOfNotification != PermissionStatus.granted) {
//       handleInvalidPermissions(permissionStatusOfNotification);
//     }
//     if (permissionStatusOfMediaLibrary != PermissionStatus.granted) {
//       handleInvalidPermissions(permissionStatusOfMediaLibrary);
//     }
//     if (permissionStatusOfLocation != PermissionStatus.granted) {
//       handleInvalidPermissions(permissionStatusOfLocation);
//     }
//     if (permissionStatusOfBluetooth != PermissionStatus.granted) {
//       handleInvalidPermissions(permissionStatusOfBluetooth);
//     }
//     if (permissionStatusOfBluetoothScan != PermissionStatus.granted) {
//       handleInvalidPermissions(permissionStatusOfBluetoothScan);
//     }
//     if (permissionStatusOfBluetoothConnect != PermissionStatus.granted) {
//       handleInvalidPermissions(permissionStatusOfBluetoothConnect);
//     }
//     // if (permissionStatusOfStorage != PermissionStatus.granted) {
//     //   handleInvalidPermissions(permissionStatusOfStorage);
//     // }
//     if (permissionStatusOfManageStorage != PermissionStatus.granted) {
//       handleInvalidPermissions(permissionStatusOfManageStorage);
//     }
//   } catch (e) {
//     debugPrint("AskPermissionsError :- ${e.toString()}");
//   }
// }
//
// Future<PermissionStatus> getNotificationPermission() async {
//   PermissionStatus permission = await Permission.notification.status;
//   if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.notification.request();
//     if (permissionStatus.isGranted) {
//       debugPrint("Access to Notification is granted.");
//     } else {
//       debugPrint("Not Access to Notification is granted.");
//     }
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }
//
// Future<PermissionStatus> getLocationPermission() async {
//   PermissionStatus permission = await Permission.location.status;
//   if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.location.request();
//     if (permissionStatus.isGranted) {
//       debugPrint("Access to location is granted.");
//     } else {
//       debugPrint("Not Access to location is granted.");
//     }
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }
//
// Future<PermissionStatus> getBluetoothPermission() async {
//   PermissionStatus permission = await Permission.bluetooth.status;
//   if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.bluetooth.request();
//     if (permissionStatus.isGranted) {
//       debugPrint("Access to bluetooth is granted.");
//     } else {
//       debugPrint("Not Access to bluetooth is granted.");
//     }
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }
//
// Future<PermissionStatus> getBluetoothScanPermission() async {
//   PermissionStatus permission = await Permission.bluetoothScan.status;
//   if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.bluetoothScan.request();
//     if (permissionStatus.isGranted) {
//       debugPrint("Access to bluetooth Scan is granted.");
//     } else {
//       debugPrint("Not Access to bluetooth Scan is granted.");
//     }
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }
//
// Future<PermissionStatus> getBluetoothConnectPermission() async {
//   PermissionStatus permission = await Permission.bluetoothConnect.status;
//   if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.bluetoothConnect.request();
//     if (permissionStatus.isGranted) {
//       debugPrint("Access to Bluetooth Connect Scan is granted.");
//     } else {
//       debugPrint("Not Access to Bluetooth Connect Scan is granted.");
//     }
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }
//
// Future<PermissionStatus> getStoragePermission() async {
//   PermissionStatus permission = await Permission.storage.status;
//   if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.storage.request();
//     if (permissionStatus.isGranted) {
//       debugPrint("Access to storage is granted.");
//     } else {
//       debugPrint("Not Access to storage is granted.");
//     }
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }
//
// Future<PermissionStatus> getManageStoragePermission() async {
//   PermissionStatus permission = await Permission.manageExternalStorage.status;
//   if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.manageExternalStorage.request();
//     if (permissionStatus.isGranted) {
//       debugPrint("Access to manageExternalStorage is granted.");
//     } else {
//       debugPrint("Not Access to manageExternalStorage is granted.");
//     }
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }
//
// Future<PermissionStatus> getMediaLibraryPermission() async {
//   PermissionStatus permission = await Permission.mediaLibrary.status;
//   if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.mediaLibrary.request();
//     if (permissionStatus.isGranted) {
//       debugPrint("Access to storage is granted.");
//     }
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }
//
// void handleInvalidPermissions(PermissionStatus permissionStatus) {
//   if (permissionStatus == PermissionStatus.denied) {
//     const snackBar = SnackBar(content: Text('Permission denied.'));
//     ScaffoldMessenger.of(Get.key.currentContext!).showSnackBar(snackBar);
//   } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
//     const SnackBar(content: Text('Please enable permission in your device settings.'));
//     //ScaffoldMessenger.of(Get.key.currentContext!).showSnackBar(snackBar);
//   }
//   debugPrint("permissionStatus=>$permissionStatus");
// }