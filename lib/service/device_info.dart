import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {}

class DeviceInfoService {
  static MethodChannel mathodChannel = const MethodChannel('device_info');
  static Future<String> printIps() async {
    String ip = "";
    for (NetworkInterface interface in await NetworkInterface.list()) {
      for (InternetAddress addr in interface.addresses) {
        ip = addr.address;
      }
    }
    debugPrint("IP : $ip");
    return ip;
  }

  // Android imei or IOS serial number
  static Future<String> getIMEI() async {
    String imei = "";
    if (Platform.isAndroid) {
      imei = await mathodChannel.invokeMethod('getIMEI');
    } else if (Platform.isIOS) {
      imei = await mathodChannel.invokeMethod('getSerialNumber');
    }
    return imei;
  }

  static Future<String> getModelName() async {
    String modelName = "";
    if (Platform.isAndroid) {
      modelName = await mathodChannel.invokeMethod('getAndoidModelName');
    } else if (Platform.isIOS) {
      modelName = await mathodChannel.invokeMethod('getIOSModelName');
    }
    debugPrint("Model Name: $modelName");
    return modelName;
  }

  Future getAppVersion() async {
    String appVersion = '';
    if (Platform.isAndroid) {
      appVersion = await mathodChannel.invokeMethod('getAndroidAppVersion');
    } else if (Platform.isIOS) {
      appVersion = await mathodChannel.invokeMethod('getIOSAppVersion');
    }
    debugPrint("App Version: $appVersion");
  }
}
