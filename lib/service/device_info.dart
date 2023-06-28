import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceInfoService {
  static Future<String> printIps() async {
    String ip = "";
    for (NetworkInterface interface in await NetworkInterface.list()) {
      for (InternetAddress addr in interface.addresses) {
        ip = addr.address;
      }
    }
    debugPrint(ip);
    return ip;
  }

  // Android imei or IOS serial number
  static Future<String> getIMEI() async {
    const MethodChannel mathodChannel = MethodChannel('device_info');
    String imei = "";
    if (Platform.isAndroid) {
      imei = await mathodChannel.invokeMethod('getIMEI');
    } else if (Platform.isIOS) {
      imei = await mathodChannel.invokeMethod('getSerialNumber');
    }
    debugPrint(imei);
    return imei;
  }
}
