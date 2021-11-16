// import 'package:device_information/device_information.dart';
import 'dart:io';

import 'package:device_information/device_information.dart';
import 'package:permission_asker/permission_asker.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:base32/base32.dart';
import 'package:ootp/ootp.dart';
import 'package:macadress_gen/macadress_gen.dart';
import 'package:totp/controller/imei_controller.dart';

String? deviceId;
String? mac;
MacadressGen macadressGen = MacadressGen();

Future<String> metodo(ImeiController imei) async {
  deviceId = await PlatformDeviceId.getDeviceId;

  if (Platform.isAndroid) {
    if (await Permission.phone.request().isGranted) {
      String imeiNo = await DeviceInformation.deviceIMEINumber;
      print("imeiNo: ${imeiNo}");
      imei.refreshScreen();

      // return imeiNo;
    }
    print("android");
  }

  final secret = base32.encodeString(deviceId as String);
  final convert = secret.replaceAll("=", "");
  final decoded = base32.decode(convert);
  // final otpAuthUri =
  //     "otpauth://totp/OOTP:Tester?secret=${encodedSecret}&issuer=OOTP&period=${totp.period}&digits=${totp.digits}";
  final totp = TOTP.secret(decoded);
  String opa = totp.make();
  // mac = await macadressGen.getMac();
  print("ID: ${convert}");
  print("Token: ${totp.make()}");
  // print("mac: ${mac}");

  return opa;
}
