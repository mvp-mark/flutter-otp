// import 'package:device_information/device_information.dart';
import 'package:device_information/device_information.dart';
import 'package:permission_asker/permission_asker.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:base32/base32.dart';
import 'package:ootp/ootp.dart';
import 'package:macadress_gen/macadress_gen.dart';

String? deviceId;
String? mac;
MacadressGen macadressGen = MacadressGen();

Future<String> metodo() async {
  deviceId = await PlatformDeviceId.getDeviceId;
  if (await Permission.phone.request().isGranted) {
    String imeiNo = await DeviceInformation.deviceIMEINumber;
    print("imeiNo: ${imeiNo}");
  }
  final secret = base32.encodeString(deviceId as String);
  final convert = secret.replaceAll("=", "");
  final decoded = base32.decode(convert);

  final totp = TOTP.secret(decoded);
  String opa = totp.make();
  mac = await macadressGen.getMac();
  print("ID: ${convert}");
  print("Token: ${totp.make()}");
  print("mac: ${mac}");

  return opa;
}
