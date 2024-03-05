import 'package:badgemagic/bluetooth/core/data/Mode.dart';
import 'package:badgemagic/bluetooth/core/data/Speed.dart';
import 'package:flutter/material.dart';
import 'package:badgemagic/bluetooth/core/data/dataToSend.dart';
import 'package:badgemagic/bluetooth/core/data/Messages.dart';
import 'package:badgemagic/bluetooth/core/DataToByteArrayConverter.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

DataToSend data = DataToSend(messages: [
  Message(hexStrings: "M1",marquee: true,mode: Mode.ANIMATION,speed: Speed.EIGHT),
  Message(hexStrings: "M2",flash: true,speed: Speed.EIGHT,marquee: true,mode: Mode.ANIMATION),
  Message(hexStrings: "M3",speed: Speed.EIGHT,marquee: true,mode: Mode.ANIMATION),
  Message(hexStrings: "M4",speed: Speed.EIGHT,marquee: true,mode: Mode.ANIMATION),
  Message(hexStrings: "M5",speed: Speed.EIGHT,marquee: true,mode: Mode.ANIMATION),
  Message(hexStrings: "M6",speed: Speed.EIGHT,marquee: true,mode: Mode.ANIMATION),
  Message(hexStrings: "M7",speed: Speed.EIGHT,marquee: true,mode: Mode.ANIMATION),
  Message(hexStrings: "M8",speed: Speed.EIGHT,marquee: true,mode: Mode.ANIMATION)
]);

List<List<int>> ans = convert(data);
void readCharacteristic(BluetoothDevice device, Guid characteristicId) async {
  List<BluetoothService> services = await device.discoverServices();
  for (BluetoothService service in services) {
    // Reads all characteristics
    var characteristics = service.characteristics;
    for (BluetoothCharacteristic c in characteristics) {
      if (c.properties.write) {
        // await c.write(ans[0], allowLongWrite: true);
        // List<int> value = await c.read();
        for (int x = 0; x < ans.length; x++) {
          await c.write(ans[x],
              withoutResponse: false, timeout: 70, allowLongWrite: true);
        }
        print("Characteristic is written");
      }
    }
  }
}

void writeCharacteristic(
    BluetoothDevice device, Guid characteristicId, List<int> data) async {
  List<BluetoothService> services = await device.discoverServices();
  for (BluetoothService service in services) {
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      if (characteristic.uuid == characteristicId) {
        await characteristic.write(data);
        print('Data written successfully.');
      }
    }
  }
}

List<BluetoothDevice> devices = [];
Future ScanDevice() async {
  var subscription = FlutterBluePlus.onScanResults.listen(
    (results) async {
      if (results.isNotEmpty) {
        ScanResult r = results.last;
        r.device.connect(autoConnect: true, mtu: null);
        await r.device.connectionState
            .where((val) => val == BluetoothConnectionState.connected)
            .first;
        if (r.device.isConnected) {
          print("device is connected");
          readCharacteristic(
              r.device, Guid("0000fee1-0000-1000-8000-00805f9b34fb"));
        } else {
          print("Device is not connected");
        }
        // the most recently found device
        print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
      }
    },
    onError: (e) => print(e),
  );
  await FlutterBluePlus.startScan(
      withServices: [Guid("0000fee0-0000-1000-8000-00805f9b34fb")],
      timeout: Duration(seconds: 10));
  print(devices);
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    ScanDevice();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Text(
        getSizes(data),
        style: TextStyle(fontSize: 25, color: Colors.white),
      )),
    );
  }
}
